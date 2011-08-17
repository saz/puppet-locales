class locales::config {
    file { $locales::params::locales_gen:
        ensure  => present,
        owner   => root,
        group   => root,
        mode    => 644,
        source  => 'puppet:///modules/locales/locale.gen',
        notify  => Exec['locale-gen'],
        require => Class['locales::install'],
    }

    exec { 'locale-gen':
        command     => $locales::params::locale_gen_cmd,
        refreshonly => true,
        require     => Class['locales::install'],
        subscribe   => File[$locales::params::locales_gen],
    }
}
