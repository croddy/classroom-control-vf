Last login: Tue Jun 20 17:45:11 on ttys004
gamma:~/Documents/Virtual Machines.localized$ port
Warning: port definitions are more than two weeks old, consider updating them by running 'port selfupdate'.
MacPorts 2.4.1
Entering shell mode... ("help" for help, "quit" to quit)
[Documents/Virtual Machines.localized] > help
[Documents/Virtual Machines.localized] > ^D
Goodbye
gamma:~/Documents/Virtual Machines.localized$ sudo port  selfupdate
--->  Updating MacPorts base sources using rsync
MacPorts base version 2.4.1 installed,
MacPorts base version 2.4.1 downloaded.
--->  Updating the ports tree
^Cgamma:~/Documents/Virtual Machines.localized$ sudo port -v sync
--->  Updating the ports tree
Synchronizing local ports tree from rsync://rsync.macports.org/release/tarballs/ports.tar

Willkommen auf dem RSYNC-server auf ftp.fau.de.
Nicht all unsere Mirror sind per rsync verfuegbar.

Welcome to the RSYNC daemon on ftp.fau.de.
Not all of our mirrors are available through rsync.


receiving file list ... done
./
ports.tar
ports.tar.rmd160

sent 56363 bytes  received 3252 bytes  10839.09 bytes/sec
total size is 64467968  speedup is 1081.41

Willkommen auf dem RSYNC-server auf ftp.fau.de.
Nicht all unsere Mirror sind per rsync verfuegbar.

Welcome to the RSYNC daemon on ftp.fau.de.
Not all of our mirrors are available through rsync.


receiving file list ... done
PortIndex

sent 19280 bytes  received 963525 bytes  115624.12 bytes/sec
total size is 11301320  speedup is 11.50

Willkommen auf dem RSYNC-server auf ftp.fau.de.
Nicht all unsere Mirror sind per rsync verfuegbar.

Welcome to the RSYNC daemon on ftp.fau.de.
Not all of our mirrors are available through rsync.


receiving file list ... done
PortIndex.rmd160

sent 44 bytes  received 626 bytes  268.00 bytes/sec
total size is 512  speedup is 0.76
gamma:~/Documents/Virtual Machines.localized$ port outdated |less
gamma:~/Documents/Virtual Machines.localized$ port search puppet
puppet @2.7.6_1 (sysutils)
    Puppet is a configuration management solution.
gamma:~/Documents/Virtual Machines.localized$ vi foo
gamma:~/Documents/Virtual Machines.localized$ vi foo
gamma:~/Documents/Virtual Machines.localized$ vi foo

 19     }
 20     default: {
 21       fail("Module ${module_name} is not supported on ${osfamily}.")
 22     }
 23   }
 24   $user = $osfamily ? {
 25     'redhat' => 'nginx',
 26     'debian' => 'www-data',
 27     'windows' => 'nobody',
 28   }
 29   $service_name = 'nginx'
 30   File {
 31     ensure => file,
 32     owner => 'root',
 33     group => 'root',
 34     mode => '0644',
 35   }
 36   package { $package:
 37     ensure => present,
 38   }
 39   file { [$docroot,"${confdir}/conf.d"]:
 40     ensure => directory,
 41   }
 42   file { "${docroot}/index.html":
 43     source => 'puppet:///modules/nginx/index.html',
 44   }
 45   file { "${confdir}/nginx.conf":
 46     content => epp('nginx/nginx.conf.epp',
 47       {
 48         user => $user,
 49         confdir => $confidir,
 50         logdir => $logdir,
 51       }
 52     ),
 53     require => Package[${package}],
 54     notify => Service[${service_name}],
 55   }
 56   file { "${confdir}/conf.d/default.conf":
 57     content => epp('nginx/default.conf.epp',
 58       {
 59         docroot => $docroot,
 60       }
 61     ),
 62     require => Package[${package}],
 63     notify => Service[${service_name}],
 64   } 
 65   service { $service_name:
"foo" 70L, 1603C written
