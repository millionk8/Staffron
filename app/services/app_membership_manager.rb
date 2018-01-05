class AppMembershipManager

  def initialize(company, package)
    @company = company
    @package = package
  end

  def create
    AppMembership.transaction do
      existing_active_packages.update_all(active: false) if existing_active_packages.any?
      app_membership = AppMembership.new(package: @package, app: @package.app, company: @company)
      if app_membership.save
        method_name = "setup_#{@package.app.machine_name}_app"
        self.send(method_name) if self.respond_to?(method_name)
      end
      app_membership
    end
  end

  def setup_timeclock_app
    add_default_billing_categories
    add_default_pto_categories
  end

  private

  def existing_active_packages
    AppMembership.where(app: @package.app, company: @company, active: true)
  end

  def add_default_billing_categories
    existing_categories = BillingCategory.where(app: @package.app, company: @company)
    create_default_categories('default_billing_categories.yml', 'BillingCategory', 'billing_categories') unless existing_categories.any?
  end

  def add_default_pto_categories
    existing_categories = PtoCategory.where(app: @package.app, company: @company)
    create_default_categories('default_pto_categories.yml', 'PtoCategory', 'pto_categories') unless existing_categories.any?
  end

  def create_default_categories(file_name, type, i18_prefix)
    categories = YAML.load_file(Rails.root.join('config', file_name))
    categories.each do |category_key, options|
      Category.create(options.merge(app: @package.app, company: @company, type: type, name: I18n.t("#{i18_prefix}.#{category_key}")))
    end
  end
end