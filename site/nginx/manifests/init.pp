class nginx {
  package { 'nginx':   
   ensure => present,
}
file { '/etc/nginx/nginx.conf':
  ensure => file,
  source => 'puppet:///modules/nginx/default.conf',
}
file { '/etc/nginx/conf.d/default.conf':
 ensure => file,
 source => 'puppet:///modules/nginx/default.conf',
}
service { 'nginx':
 ensure => running,
 enable => true,
}
file { '/var/www/index.html':
 ensure => file,
 source => 'puppet:///modules/nginx/index.html',
}
file { '/var/www':
 ensure => directory,
}
  }

