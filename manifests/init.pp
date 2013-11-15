class stimberry {
	
	package {
		['nodejs', 'npm']:,
	}

	class { 'fm_hostapd':
		interface  => 'wlan0',
		ssid       => 'stimberry_wn',
		channel    => '5',
		passphrase => 'changeme',
	}

}
