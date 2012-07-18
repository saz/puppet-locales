class locales::params {
  case $::operatingsystem {
    /(Ubuntu|Debian)/: {
      $package = 'locales'
      $config_file = '/etc/locale.gen'
      $default_file = '/etc/default/locale'
      $locale_gen_cmd = '/usr/sbin/locale-gen'
      $update_locale_cmd = '/usr/sbin/update-locale'
      $update_locale_pkg = 'libc-bin'
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }
}
