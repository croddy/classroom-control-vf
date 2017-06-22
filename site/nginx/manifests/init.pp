class nginx (
  $root = undef,
) {
  case $osfamily {
    'redhat': {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $docroot = '/var/www'
      $confdir = '/etc/nginx'
      $blockdir = '/etc/nginx/conf.d'
      $logdir = '/var/log/nginx'
      $service = 'nginx'
      $user = 'nginx'
    }
    'debian': {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $docroot = '/var/www'
      $confdir = '/etc/nginx'
      $blockdir = '/etc/nginx/conf.d'
      $logdir = '/var/log/nginx'
      $service = 'nginx'
      $user = 'www-data'
    }
    'windows': {
      $package = 'nginx-service'
      $owner = 'Administrator'
      $group = 'Administrators'
      $docroot = 'C:/ProgramData/nginx/html'
      $confdir = 'C:/ProgramData/nginx'
      $blockdir = 'C:/ProgramData/nginx/conf.d'
      $logdir = 'C:/ProgramData/nginx/logs'
      $service = 'nginx'
      $user = 'nobody'
    }
    default: { fail("Unsupported platform: ${::osfamily}") }
  }
  $real_docroot = pick($root, $docroot)
  
  $template_params = {
    docroot => $real_docroot,
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
  
  file { $real_docroot:
    ensure => directory,
  }
  file { "${real_docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
}
