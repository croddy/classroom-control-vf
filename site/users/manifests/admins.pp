class users::admins {
  users::managed_user {'joe':}
  users::managed_user {'alice':
    primary_group => 'staff',
  }
  group { 'staff':
    ensure => present,
  }
  users::managed_user {'aaron':
    primary_group => 'staff',
  }
}
