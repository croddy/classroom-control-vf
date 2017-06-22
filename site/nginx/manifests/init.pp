class nginx {
  case $facts['os']['family']{
    'redhat','debian':{
      $Package_Name           = 'nginx'
      $Owner                  = 'root'
      $Group                  = 'root'
      $Document_Root          = '/var/www'
      $Config_Directory       = '/etc/nginx'
      $Logs_Directory         = '/var/log/nginx'
    }
    'windows':{
      $Package_Name           = 'nginx-service'
      $Owner                  = 'Administrator'
      $Group                  = 'Administrators'
      $Document_Root          = 'C:/ProgramData/nginx/html'
      $Config_Directory       = 'C:/ProgramData/nginx'
      $Logs_Directory         = 'C:/ProgramData/nginx/logs'
    }
    default {
      fail("not supported on ${facts['os']['family']}")
    }
  }
  
  # user the service will run as. Used in the nginx.conf.epp template
  $User_Service_Runs_As = $facts['os']['family'] ? {
    'redhat'  => 'nginx',
    'debian'  => 'www-data',
    'windows' => 'nobody',
  }
  
  File {
    owner => $Owner,
    group => $Group,
    mode => '0644',
  }
  
  package {$Package_Name:
    ensure => present,
  }
  
  file { ['${Document_Root}','${Config_Directory}/conf.d']:
    ensure => directory,
  }
  
  file { '${Document_Root}/index.html':
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { '${Config_Directory}/nginx.conf':
    ensure => file,
    content => epp('nginx/nginx.conf.epp'{
      user => $Owner,
      confdir => $Config_Directory,
      logdir => $Log_Directory,
    }),
    notify => Service['nginx'],
  }
  
  file { '${Config_Directory}/conf.d/default.conf':
    ensure => file,
    content => epp('nginx/default.conf.epp'{
      docroot => $Document_Root,
    }),
    notify => Service['nginx'],
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
  }
}
