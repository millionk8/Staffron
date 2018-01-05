class AppSettingsManager

  def initialize(app, company)
    @app = app
    @company = company
  end

  def build
    method_name = "#{@app.machine_name}_settings"
    self.send(method_name) if self.respond_to?(method_name)
  end

  def timeclock_settings
    {}.tap do |settings|
      billing_categories = BillingCategory.visible.where(app: @app, company: @company)
      settings.merge!(ActiveModelSerializers::SerializableResource.new(billing_categories).as_json) if billing_categories.any?

      pto_categories = PtoCategory.visible.where(app: @app, company: @company)
      settings.merge!(ActiveModelSerializers::SerializableResource.new(pto_categories).as_json) if pto_categories.any?
    end
  end

end