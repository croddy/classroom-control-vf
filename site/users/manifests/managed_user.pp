define user::managed(
  $homedir = "/home/${title}",
  $primary_group = $title,
){
  user {$title:
    ensure => present,
    gid => $primary_group,
  }
  group { $primary_group:
    ensure => present,
  }
  file { $homedir:
    ensure => directory,
    owner => $title,
    group => $primary_group
    mode => $mode,
  }
  file { "${homedir}/.ssh":
    ensure => directory, 
    owner => $title, 
    group => $primary_group,
    mode => '0600'
  }
)
