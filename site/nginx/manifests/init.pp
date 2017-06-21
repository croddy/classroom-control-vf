class {
  package { 'nginx':
    ensure => present,
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure => file,
    source => 'puppet:///module/nginx/nginx.conf',
  }
  
  file { '/etc/nginx/config.d/default.conf':
    ensure => file,
    source => 'puppet:///module/nginx/default.conf',
  }
  
  file { '/var/wwww/index.html':
    ensure => file,
    source => 'puppet:///module/nginx/index.html',
  }
  
  service { 'nginx':
    esure => running,
    enabled => true,
  }
  
  
}
