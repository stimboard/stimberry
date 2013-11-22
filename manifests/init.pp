class stimberry {

	package {
		['nodejs', 'npm']:,;
	}
	package {['mysql-server']: }
#	service { 'mysql-server':
#		ensure     => 'running',
#	}

	file { '/usr/bin/node':
		ensure  => 'link',
		target  => '/usr/bin/nodejs',
	}	

	file { ['/var/www', '/var/www/nodesites']:
		ensure  => 'directory',
	}
	vcsrepo { '/var/www/nodesites/stimboard':
		ensure   => present,
		provider => git,
		source   => 'git://github.com/laza1618/T8_node_server_projet.git',

		require  => File['/var/www/nodesites'],
	}
	# node_modules has to be done manually because not supported by puppetlabs...
	service { 'stimboard':
		ensure     => 'stopped',
		hasrestart => false,
		hasstatus  => false,
		start      => 'node /var/www/nodesites/stimboard/server.js',
		stop       => 'killall -s SIGKILL node',
	}

	class { 'fm_hostapd':
		interface  => 'wlan0',
		ssid       => 'stimberry_wn',
		channel    => '5',
		passphrase => 'changeme',
		ensure     => 'running',
	}

}
