class users::admins {
  users::managed_user {'joe': mode => '0640'}
  users::managed_user {'alice':group => 'staff'}
  users::managed_user {'bill':group => 'wheel'}
  group {['staff','wheel']: ensure => present,}
}
