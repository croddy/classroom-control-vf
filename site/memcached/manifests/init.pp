class memcached {
  package { 'memcached':
    ensure => present,
   }
   file { '/etc/sysconfig/memcached':
    ensure => file,
    source => 'puppet
   }
   service { 'memcached':
    ensure => running,
    enabled => true,
    subscribe => File['memcache config'],
   }
}
