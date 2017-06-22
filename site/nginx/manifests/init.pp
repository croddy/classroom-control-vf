class nginx
(
  $package = $nginx::params::package,
  $owner = $nginx::params::owner,
  $group = $nginx::params::group,
  $docroot = $nginx::params::docroot,
  $confdir = $nginx::params::confdir,
  $blockdir = $nginx::params::blockdir,
  $logdir = $nginx::params::logdir,
  $user = $nginx::params::user,
) inherits nginx::params
{
  File {
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0640',
  }

  $service_name = 'nginx'
  
  $template_params = {
    user => $user,
    blockdir => $blockdir,
    confdir => $confdir,
    docroot => $docroot,
    logdir => $logdir,
    port => '80',
  }

  package { $package:
    ensure => present,
  }  
  file { [$docroot,$blockdir]:
    ensure => directory,
  }
  file { "${docroot}/index.html":
    source => 'puppet:///modules/nginx/index.html',
  }
  file { "${confdir}/nginx.conf":
    content => epp('nginx/nginx.conf.epp',$template_params),
    require => Package[$package],
    notify => Service[$service_name],
  }
  file { "${blockdir}/default.conf":
    content => epp('nginx/default.conf.epp',$template_params),
    require => Package[$package],
    notify => Service[$service_name],
  }
  service { $service_name:
    ensure => running,
    enable => true,
  }
}
