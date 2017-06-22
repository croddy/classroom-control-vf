class users::admins {
  users::managed_user { 'jose': }
  users::managed_user { 'alice':
    primary_group => 'wheel',
  }
  users::managed_user { 'chen':
    mode => '0600',
  }
}
