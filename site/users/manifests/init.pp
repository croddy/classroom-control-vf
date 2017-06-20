class users {
  user {'fundamentals':
    ensure => present,
    password = 'pinocchio',
    groups = ['users'],
  }
} 
