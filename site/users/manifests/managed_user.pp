define users::managed_user( $user = $title, $group = $title, $home = "/home/${title}" )
{
  user {$user: ensure => present}
  file { 'home':
    path => $home,
    ensure => directory,
    owner => $title,
    group => $group,
  }
  file { 'bashrc':
    path => "${home}/.bashrc",
    ensure => file,
    owner => $user,
    group => $group,
    mode => '0644',
  }
  file { 'bash_profile':
    path => "${home}/.bash_profile",
    ensure => file,
    owner => $user,
    group => $group,
    mode => '0644',
  }
  file { 'sshdir':
    path => "${home}/.ssh",
    ensure => directory,
    owner => $title,
    group => $group,
    mode => '0700',
  }
}
