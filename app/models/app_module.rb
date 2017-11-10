class AppModule < ActiveRecord::Base

  # Associations
  belongs_to :package

  # Methods
  def permission
    "#{self.package.app.machine_name}:can_access_#{self.machine_name}_module"
  end

end