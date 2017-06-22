define users::managed_user( $user = $title, $group = $title, $home = "/home/${title}" )
{
  user {$user: ensure => present}
  file { "${user} home":
    ensure => directory,
    owner => $user,
    group => $group,
  }
  file { "${user} bashrc":
    path => "${home}/.bashrc",
    ensure => file,
    owner => $user,
    group => $group,
    mode => '0644',
  }
  file { "${user} bash_profile":
    path => "${home}/.bash_profile",
    ensure => file,
    owner => $user,
    group => $group,
    mode => '0644',
  }
  file { "${user} sshdir':
    path => "${home}/.ssh",
    ensure => directory,
    owner => $title,
    group => $group,
    mode => '0700',
  }
}
