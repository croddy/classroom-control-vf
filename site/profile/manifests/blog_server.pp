class profile::blog_server {
  class { 'mysql::server':
    root_password => 'strong_password1' # note: not a very strong password
  }
}
