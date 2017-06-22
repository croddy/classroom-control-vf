class users::admins {
  users::managed_users { 'jose': }
  users::managed_users { 'alice':
    group => 'staff',
  }
  users::managed_users { 'chen':
    group => 'staff',
  }
  group { 'staff':
    ensure => present,
  }
}
