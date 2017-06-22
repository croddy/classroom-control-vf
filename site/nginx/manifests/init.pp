class nginx (
      $package =  $nginx::params::package,
      $owner = $nginx::params::owner,
      $group = $nginx::params::group,
      $docroot = $nginx::params::docroot,
      $confdir = $nginx::params::confdir,
      $blockdir = $nginx::params::blockdir,
      $logdir = $nginx::params::logdir,
      $service = $nginx::params::service,
      $user = $nginx::params::user,
) inherits nginx::params {
  
  $template_params = {
    docroot => $docroot,
    confdir => $confdir,
    blockdir => $blockdir,
    logdir => $logdir,
    user => $user,
  }
  File {
    owner => $owner,
    group => $group,
    mode => '0644',
  }
  package { $package:
    ensure => present,
  }
  file { 'nginx main config':
    ensure => file,
    path => "${confdir}/nginx.conf",
    content => epp('nginx/nginx.conf.epp', $template_params),
    require => Package[$package],
  }
  file { 'nginx default block':
    ensure => file,
    path => "${blockdir}/default.conf",
    content => epp('nginx/default.conf.epp', $template_params),
    require => Package[$package],
  }
  service { 'nginx':
    ensure => running,
    enable => true,
    subscribe => [ 
      File['nginx main config'],
      File['nginx default block'],
    ]
  }
  
  file { $docroot:
    ensure => directory,
  }
  file { "${docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
}
