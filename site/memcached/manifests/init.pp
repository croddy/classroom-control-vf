class memcached {
  package { 'memcached':
    ensure => present,
  }
  file { 'memcached config':
    ensure => file,
    path => '/etc/sysconfig/memcached',
    source => 'puppet:///modules/memcached/sysconfig',
    require => Package['memcached'],
  }
  service { 'memcached':
    ensure => running,
    enable => true,
    subscribe => File['memcache config'],
  }
}
