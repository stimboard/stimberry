class stimberry {

	package {
		['nodejs', 'npm']:,;
	}
	file { '/usr/bin/node':
		ensure  => 'link',
		target  => '/usr/bin/nodejs',
	}	

	file { ['/var/www', '/var/www/nodesites']:
		ensure  => 'directory',
	}
	vcsrepo { '/var/www/nodesites/trivial-chat':
		ensure   => present,
		provider => git,
		source   => 'git://github.com/fmaurica/trivial-chat.git',

		require  => File['/var/www/nodesites'],
	}
	# node_modules has to be done manually because not supported by puppetlabs...
	service { 'trivial-chat':
		ensure     => 'stopped',
		hasrestart => false,
		hasstatus  => false,
		start      => 'node /var/www/nodesites/trivial-chat/index.js',
		stop       => 'killall -s SIGKILL node',
	}

	class { 'fm_hostapd':
		interface  => 'wlan0',
		ssid       => 'stimberry_wn',
		channel    => '5',
		passphrase => 'changeme',
	}

}
