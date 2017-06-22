class profile::blog_server {

  class { 'mysql::server':
    root_password => 'strong_password1', # note: not a very strong password
    users => {
      'wordpress@localhost' => {
        ensure => 'present',
        password_hash => '*34FD07B148CCA9FCB2BE6C2EA20689053E748B13',
      },
    },
    grants => {
      'wordpress@localhost/wordpress.*' => {
        ensure => 'present',
        privileges => ['ALL'],
        table => 'wordpress.*',
        user => 'wordpress@localhost',
      },
    },
  }
  class { 'mysql::bindings':
    php_enable => true,
  }
  
  class { 'apache':
    docroot => '/opt/wordpress',
  }
  include apache::mod::php
  
  class { 'wordpress':
    create_db_user => false,
    db_name => 'wordpress',
    db_user => 'wordpress',
    db_password => 'pass1234', # note: should be in hiera-eyaml like the other one!
  }   
}
