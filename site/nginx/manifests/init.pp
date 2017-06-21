class nginx {
  package { 'nginx':
    ensure => present,
   }
  file { '/var/www':
    ensure => directory,
    source => 'puppet:///modules/nginx/index.html',
   }
   file { '/etc/nginx/conf.d/default.conf':
    ensure => file,
    source => 'puppet://modules/
}
