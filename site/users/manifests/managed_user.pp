define users::managed_user( $user = $title, $group = $title, $home = "/home/${title}", $mode = '0644' )
{
  user {$user: ensure => present}
  file { "${user} home":
    path => $home,
    ensure => directory,
    owner => $user,
    group => $group,
    mode => $mode,
  }
  file { "${user} bashrc":
    path => "${home}/.bashrc",
    ensure => file,
    owner => $user,
    group => $group,
    mode => $mode,
  }
  file { "${user} bash_profile":
    path => "${home}/.bash_profile",
    ensure => file,
    owner => $user,
    group => $group,
    mode => $mode,
  }
  file { "${user} sshdir":
    path => "${home}/.ssh",
    ensure => directory,
    owner => $title,
    group => $group,
    mode => '0700',
  }
}
