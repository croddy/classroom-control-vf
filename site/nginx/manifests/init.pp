class nginx {
  case $facts['os'] {
    'RedHat': {
      $Document_Root          = '/var/www'
      $Config_Directory       = '/etc/nginx'
      $Logs_Directory         = '/var/log/nginx'
      $User_Service_Runs_As   = 'nginx'
    }
    'Windows': {
      $Document_Root          = 'C:/ProgramData/nginx/html'
      $Config_Directory       = 'C:/ProgramData/nginx'
      $Logs_Directory         = 'C:/ProgramData/nginx/logs'
      $User_Service_Runs_As   = 'nobody'
    }
    default {
      fail("not supported on ${facts['os']}")
    }
  }
  $Package_Name = 'nginx'
  $Service_Name = 'nginx'
  $Server_Block_Directory = '${configdir}/conf.d'
  File {
    owner => 'root',
    group => 'root',
    mode => '0644',
  }
  package {'nginx':
    ensure => present,
  }
  file { ['${Document_Root}','${Config_Directory}','${Server_Block_Directory}']:
    ensure => directory,
  }
  file { '${Document_Root}/index.html':
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  file { '${Config_Directory}/nginx.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  file { '${Server_Block_Directory}/default.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
