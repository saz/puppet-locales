class locales::install {
    package { $locales::params::package_name:
        ensure => present,
    }
}
