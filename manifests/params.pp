class locales::params {
    case $operatingsystem {
        /(Ubuntu|Debian)/: {
            $package_name = 'locales'
            $locales_gen = '/etc/locale.gen'
            $locale_gen_cmd = '/usr/sbin/locale-gen'
        }
    }
}
