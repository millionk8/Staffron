class PermissionsManager

  PERMISSIONS = [
    'can_manage_timesheets'
  ]

  def initialize(user)
    @user = user
    @timeclock_app = App.find_by(machine_name: 'timeclock')
    @ticketing_system = App.find_by(machine_name: 'ticketing_system')
  end


  def build_permissions
    [].tap do |active_permissions|
      PERMISSIONS.each do |permission|
        active_permissions << permission if self.send(permission)
      end
    end
  end

  def can_manage_timesheets
    if @user.admin
      true
    else
      user_membership = UserMembership.find_by(user: @user, app: @timeclock_app)

      user_membership && user_membership.role.machine_name == 'office_administration'
    end
  end

end