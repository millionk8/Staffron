class PermissionsManager

  PERMISSIONS = [
    'officeAdmin',
    'manager',
    'employee',
    'admin',
    'master'
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

  # ROLES
  def master
    @user.master
  end

  def admin
    @user.admin
  end

  def officeAdmin
    user_membership = UserMembership.find_by(user: @user, app: @timeclock_app)
    user_membership && user_membership.role.machine_name == 'office_administration'
  end

  def manager
    user_membership = UserMembership.find_by(user: @user, app: @timeclock_app)
    user_membership && user_membership.role.machine_name == 'manager'
  end

  def employee
    user_membership = UserMembership.find_by(user: @user, app: @timeclock_app)
    user_membership && user_membership.role.machine_name == 'employee'
  end

end