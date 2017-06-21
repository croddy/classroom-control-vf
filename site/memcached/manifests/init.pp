class memcached {
  
  package { "memcached":
    ensure => present,
    enable => true,
  }
  
  file { '/etc/sysconfig/memchached':
    ensure => file,
    source => 'puppet:///modules/memchached/memchached',    
    require => Package['memchached'[,
  }
  
  service { 'memchached':
    ensure => running,
    enable => true,
    subscribe => File['/etc/sysconfig/memchached'],
  }
  
}
