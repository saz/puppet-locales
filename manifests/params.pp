class locales::params {
  case $::operatingsystem {
    /(Ubuntu|Debian)/: {
      $package = 'locales'
      $config_file = '/etc/locale.gen'
      $locale_gen_cmd = '/usr/sbin/locale-gen'
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }
}
