class stimberry {

	package {
		['nodejs', 'npm']:,;
	}
	package {['mysql-server']: }
	service { 'mysql':
		ensure     => 'running',
	}
	package {['iceweasel']:}

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
	vcsrepo { '/var/www/nodesites/stimboard/ui':
		ensure   => present,
		provider => git,
		source   => 'git://github.com/Fenitra/STIMBoard.git',

		require  => [
			File['/var/www/nodesites'],
			Vcsrepo['/var/www/nodesites/stimboard'],
			    ],
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
