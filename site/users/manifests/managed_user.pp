define users::managed_user( $user = $title, $group = $title, $homedir = "/home/${title}" )
{
  user {$user: ensure => present}
  file { 'homedir':
    path => $homedir,
    ensure => directory,
    owner => $title,
    group => $group,
  }
  file { 'bashrc':
    path => "${homedir}/.bashrc",
    ensure => file,
    owner => $user,
    group => $group,
    mode => '0644',
  }
  file { 'bash_profile':
    path => "${homedir}/.bash_profile",
    ensure => file,
    owner => $user,
    group => $group,
    mode => '0644',
  }
  file { 'sshdir':
    path => "${homedir}/.ssh",
    ensure => directory,
    owner => $title,
    group => $group,
    mode => '0700',
  }
}
