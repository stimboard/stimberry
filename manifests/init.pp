class stimberry {
	
	package {
		['nodejs', 'npm']:,;
		['forever']:
			provider => 'npm',;
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

	class { 'fm_hostapd':
		interface  => 'wlan0',
		ssid       => 'stimberry_wn',
		channel    => '5',
		passphrase => 'changeme',
	}

}
