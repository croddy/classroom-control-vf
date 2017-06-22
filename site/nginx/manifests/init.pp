class nginx(
  $root=undef,
){
  case $facts['os']['family']{
   'redhat','debian':{
    $package ='nginx'
    $owner ='root'
    $group ='root'
    $docroot ='/var/www/'
    $confdir ='/etc/nginx'
    $logdir ='/var/log/nginx'
   }
   'windows':{
    $package ='nginx-service'
    $owner ='Administrator'
    $group ='Administrators'
    $docroot ='C:/ProgramData/nginx/html'
    $confdir ='C:/ProgramData/nginx'
    $logdir ='C:/ProgramData/nginx/logs'
   }
   default :{
    fail("Module ${module_name} is not supported on this different type of system: ${facts['os']['family']}")
   }
  }

  $real_docroot = pick($root, $docroot)
  
  #What user the service will run as: 
  $user=$facts['os']['family']?{
    'redhat' => 'nginx',
    'debian' => 'www-data',
    'windows' => 'nobody',
  }
    
  File {
    owner=> $owner,
    group=> $group,
    mode=>'0664',
  }
  package { $package:
    ensure => present,
  }
  file { "${confdir}/nginx.conf":
    ensure => file,
    #does this (source) need to be content?
    content => epp('nginx/nginx.conf.epp', 
              {
              user => $user,
              confdir => $confdir,
              logdir => $logdir,
              }),
    require => Package[$package],
  }
  
  file { "${confdir}/conf.d/default.conf":
    ensure => file,
    content => epp('nginx/default.conf.epp',
        {
          docroot=>$real_docroot,
        }),
    notify => Service['nginx'],
    require => Package[$package],
  }
  service { 'nginx':
    ensure => running,
    enable => true,
    subscribe => [
      File["${confdir}/nginx.conf"],
      File["${confdir}/conf.d/default.conf"],
    ]
  }
  
  file {[$real_docroot,"${confdir}/conf.d"]:
    ensure => directory,
  }
  file { "${docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  
}
