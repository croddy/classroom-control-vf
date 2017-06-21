class memcached {
  package { 'memcached':
    ensure => present,
  }
  file { 'memcached config':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    path => '/etc/sysconfig/memcached',
    source  => 'puppet:///modules/memcached/sysconfig',
    require => Package[;memcached'],
  }
  service { 'memcached':
    ensure    => running,
    enable    => true,
    subscribe => File['memcached config'],
  }
}
