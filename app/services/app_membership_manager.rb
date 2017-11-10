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
  end

  private

  def existing_active_packages
    AppMembership.where(app: @package.app, company: @company, active: true)
  end

  def add_default_billing_categories
    categories = YAML.load_file(Rails.root.join('config', 'default_billing_categories.yml'))
    categories.each do |category_key|
      BillingCategory.create(app: @package.app, company: @company, name: I18n.t("billing_categories.#{category_key}"))
    end
  end
end