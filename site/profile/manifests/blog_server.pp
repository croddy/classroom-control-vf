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
        privileges => ['ALL PRIVILEGES'],
        table => 'wordpress.*',
        user => 'wordpress@localhost',
      },
    },
  }
}
