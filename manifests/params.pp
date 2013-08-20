class locales::params {

  $config_file = $::operatingsystem ? {
    Debian => '/etc/locale.gen',
    Ubuntu => '/var/lib/locales/supported.d/local',
  }

  case $::operatingsystem {
    /(Ubuntu|Debian)/: {
      $package = 'locales'
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
