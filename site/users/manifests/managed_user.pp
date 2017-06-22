define users::managed_user (
  $homedir = "/home/${title}",
  $primary_group = $title,
  $mode = "0644",
) {
  user { $title:
    ensure => present,
    gid => $primary_group,
  }
  file { $homedir:
    owner => $title,
    group => $primary_group,
    mode => $mode,
  }
  file { "${homedir}/.ssh":
    ensure => present,
    owner => $title,
    group => $primary_group,
    mode => '0600',
  }
}
