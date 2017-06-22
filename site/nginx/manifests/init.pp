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
  $port = '80'
  
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
    content => epp('nginx/nginx.conf.epp',
      {
        user => $user,
        blockdir => $blockdir,
        confdir => $confdir,
        logdir => $logdir,
      }
    ),
    require => Package[$package],
    notify => Service[$service_name],
  }
  file { "${blockdir}/default.conf":
    content => epp('nginx/default.conf.epp',{docroot => $docroot, port => $port }),
    require => Package[$package],
    notify => Service[$service_name],
  }
  service { $service_name:
    ensure => running,
    enable => true,
  }
}
