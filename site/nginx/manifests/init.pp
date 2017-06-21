class nginx {
  File {
    owner => 'root',
    group => 'root',
    mode => '0644',
 }
  package { 'nginx':   
   ensure => present,
}
file { '/etc/nginx/nginx.conf':
  ensure => file,
  source => 'puppet:///modules/nginx/default.conf',
  require => package['nginx'],
}
file { '/etc/nginx/conf.d/default.conf':
 ensure => file,
 source => 'puppet:///modules/nginx/default.conf',
 require => package['nginx'],
}
service { 'nginx':
 ensure => running,
 enable => true,
 subscribe => [
   file['/etc/nginx/nginx.conf'],
   file['/etc/nginx/conf.d/default.conf'],
   ]
}

file { '/var/www':
 ensure => directory,
 }
file { '/var/www/index.html':
 ensure => file,
 source => 'puppet:///modules/nginx/index.html',
    }
}

