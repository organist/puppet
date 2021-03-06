class organist::install {


    file { "/etc/nginx/conf.d/organist.conf":
		ensure => present,
		source => [
            "puppet:///modules/organist/organist.conf",
        ],
        group => 'root',
        owner => 'root',
        notify => Service["nginx"]
	}

    file { "/etc/nginx/conf.d/default.conf":
		ensure => absent,
	}

	exec { 'sudo gem install capifony --version "=2.2.10"':
	    path   => "/usr/bin:/usr/sbin:/bin",
        creates => "/usr/lib/ruby/gems/1.8/specifications/capifony-2.2.10.gemspec"
	}

	exec { 'sudo gem install capistrano --version "=2.15.4"':
	    path   => "/usr/bin:/usr/sbin:/bin",
        creates => "/usr/lib/ruby/gems/1.8/specifications/capistrano-2.15.4.gemspec"
	}

	exec { 'sudo gem install capistrano_rsync_with_remote_cache	 --version "=2.4.0"':
	    path   => "/usr/bin:/usr/sbin:/bin",
        creates => "/usr/lib/ruby/gems/1.8/specifications/capistrano_rsync_with_remote_cache-2.4.0.gemspec"
    }

	exec { 'sudo gem install capistrano-ext	--version "=1.2.1"':
	    path   => "/usr/bin:/usr/sbin:/bin",
        creates => "/usr/lib/ruby/gems/1.8/specifications/capistrano-ext-1.2.1.gemspec"
    }

    mysql::db { 'organist':
        user     => 'vagrant',
        password => 'vagrant',
        host     => 'localhost',
        grant    => ['all']
    }

    exec { "organistInstall":
        command => "/home/deploy/install_organist.sh",
        provider => shell,
        path => "/usr/bin:/usr/sbin:/bin",
        creates => "/home/deploy/organist/src",
        user => deploy,
        require => Mysql::Db["organist"]
    }

    exec { "oganistVendors":
        command => "/home/deploy/install_vendors.sh",
        provider => shell,
        path => "/usr/bin:/usr/sbin:/bin",
        creates => "/home/deploy/organist/vendor",
        user => deploy,
        require => Exec["organistInstall"]
    }

    exec { "organistAnyterm":
        command => "/home/deploy/install_anytermservice.sh",
        provider => shell,
        path => "/usr/bin:/usr/sbin:/bin",
        creates => "/etc/init.d/anyterm",
        user => vagrant,
        require => Exec["oganistVendors"]
    }


    # Anyterm port
    firewall { '7778 open port 7778':
        port   => [ 7778  ],
        proto  => tcp,
        action => accept
    }

}
