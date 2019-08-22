Role.seed_once(:id,
  { id: 1, name: 'Manager', machine_name: 'manager', app_id: 1 },
  { id: 2, name: 'Employee', machine_name: 'employee', app_id: 1 },
  { id: 3, name: 'Office Administration', machine_name: 'office_administration', app_id: 1 },
  { id: 4, name: 'Admin', machine_name: 'admin', app_id: 1 },
)