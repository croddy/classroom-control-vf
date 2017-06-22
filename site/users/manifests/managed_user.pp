define users::managed_user (
  $group=$title,
){
  users {$title:
    ensure => present,
  }
  title { "/home/${title}":
    ensure => directory,
    owner => $title,
    group => $title,
  }
 }  
