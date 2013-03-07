class locales::params {
  case $::operatingsystem {
    /(Ubuntu|Debian)/: {
      $package = 'locales'
      $default_locale = 'C'
      $config_file = '/etc/locale.gen'
      $default_file = '/etc/default/locale'
      $locale_gen_cmd = '/usr/sbin/locale-gen'
      $update_locale_cmd = '/usr/sbin/update-locale'

      case $::lsbdistid {
        'Ubuntu': {
          case $::lsbdistcodename {
            'hardy': {
              $update_locale_pkg = 'belocs-locales-bin'
            }
            default: {
              $update_locale_pkg = 'libc-bin'
            }
          }
        }
        default: {
          $update_locale_pkg = false
        }
      }
    }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }
}
