class users::admins {
  users::managed_user {'joe': mode => '0640'}
  users::managed_user {'alice':group => 'staff'}
  users::managed_user {'bill':group => 'staff'}
  group {'staff': ensure => present,}
}
