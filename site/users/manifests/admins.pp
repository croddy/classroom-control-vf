class users::admins {
  users::managed_user {'Bob':}
  users::managed_user {'Fred':}
  users::managed_user {'Julia':
    primary_group =>wheel,
  }
  users::managed_user {'Mary':}
}
