class nginx ( String $root = undef, Boolean $highperf = true )
{
  File {
    owner => 'root',
    group => 'root',
    mode => '0440'
  }
  $osfamily = $facts['os']['family']
  case $osfamily {
    'redhat','debian': {
      $package = 'nginx'
      #$docroot = '/var/www'
      $confdir = '/etc/nginx'
      $blockdir = '/etc/nginx/conf.d'
      $logdir = '/var/log/nginx'
    }
    'windows': {
      $package = 'nginx-service'
      $owner = 'Administrator'
      $group = 'Administrators'
      #$docroot = 'C:\ProgramData\nginx\html'
      $confdir = 'C:\ProgramData\nsginx'
      $blockdir = 'C:\ProgramData\nginx\conf.d'
      $logdir = 'C:\ProgramData\nginx\logs'
    }
    default: {
      fail("Module ${module_name} is not supported on ${osfamily}.")
    }
  }
  $user = $osfamily ? {
    'redhat' => 'nginx',
    'debian' => 'www-data',
    'windows' => 'nobody',
  }
  $docroot = $root ? {
    undef => $default_docroot,
    default => $root,
  }
  $service_name = 'nginx'
  $port = '80'
  File {
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
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
    content => epp('nginx/nginx.conf.epp',
      {
        user => $user,
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
