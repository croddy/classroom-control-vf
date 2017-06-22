class user::admins {
  user::managed_user{"joe"}
  user::managed_user{"alice":
    group => 'staff',
  }
  users::managed_user{"aaron":
    group => 'staff',
  }
  group{'staff':
    ensure => present,
  }  
}
