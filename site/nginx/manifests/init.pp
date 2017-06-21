class nginx {
  $osfamily = $facts['os']['family']
  case $osfamily {
    'redhat','debian': {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $docroot = '/var/www'
      $confdir = '/etc/nginx'
      $logdir = '/var/log/nginx'
    }
    'windows': {
      $package = 'nginx-service'
      $owner = 'Administrator'
      $group = 'Administrators'
      $docroot = 'C:\ProgramData\nginx\html'
      $confdir = 'C:\ProgramData\nsginx'
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
  $service_name = 'nginx'
  File {
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
  }
  package { $package:
    ensure => present,
  }  
  file { [$docroot,"${confdir}/conf.d"]:
    ensure => directory,
  }
  file { "${docroot}/index.html":
    source => 'puppet:///modules/nginx/index.html',
  }
  file { "${confdir}/nginx.conf":
    content => epp('nginx/nginx.conf.epp',
      {
        user => $user,
        confdir => $confidir,
        logdir => $logdir,
      }
    )
    require => Package[$package],
    notify => Service[$service_name],
  }
  file { "${confdir}/conf.d/default.conf":
    content => epp('nginx/default.conf.epp',
      {
        docroot => $docroot,
      }
    )
    require => Package[$package],
    notify => Service[$service_name],
  }
  service { $service_name:
    ensure => running,
    enable => true,
  }
}
