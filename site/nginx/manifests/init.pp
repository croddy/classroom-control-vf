class nginx {
  package { 'nginx':
    ensure => present,
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
  }
  
  file { '/etc/nginx/config.d/default.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
  }
  
  file { '/usr/share/nginx/html/index.html':
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
    require => Package['nginx'],    
  }
  
  service { 'nginx':
    ensure => running,
    enable => true,
    subscribe => File['/etc/nginx/config.d/default.conf'],
  }
  
  
}
