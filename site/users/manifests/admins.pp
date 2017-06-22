class users::admins {
  users::managed_user {'joe':}
  users::managed_user {'alice':
    group => 'staff',
  }
  $primary_group { 'staff':
    ensure => present,
  }
  users::managed_user {'aaron':
    group => 'staff',
  }
}
