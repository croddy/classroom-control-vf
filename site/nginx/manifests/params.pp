
class nginx::params {
  $osfamily = $facts['os']['family']
  case $osfamily {
    'redhat','debian': {
      $package = 'nginx'
      $owner = root
      $group = root
      $docroot = '/var/www'
      $confdir = '/etc/nginx'
      $blockdir = '/etc/nginx/conf.d'
      $logdir = '/var/log/nginx'
      $service = 'nginx'
      $port = '80'
    }
    'windows': {
      $package = 'nginx-service'
      $owner = 'Administrator'
      $group = 'Administrators'
      $docroot = 'C:\ProgramData\nginx\html'
      $confdir = 'C:\ProgramData\nsginx'
      $blockdir = 'C:\ProgramData\nginx\conf.d'
      $logdir = 'C:\ProgramData\nginx\logs'
      $service = 'nginx'
      $port = '80'
    }
    default: {
      fail("Module ${module_name} is not supported on ${osfamily}.")
    }
  }
  $user = $osfamily ? {
    'redhat' => 'nginx',
    'debian' => 'www-data',
    'windows' => 'nobody',
  }
}
