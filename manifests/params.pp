class locales::params {

  $config_file = $::operatingsystem ? {
    'Debian' => '/etc/locale.gen',
    'Ubuntu' => '/var/lib/locales/supported.d/local',
  }

  case $::operatingsystem {
    /(Ubuntu|Debian)/: {
      $lc_ctype          = undef
      $lc_collate        = undef
      $lc_time           = undef
      $lc_numeric        = undef
      $lc_monetary       = undef
      $lc_messages       = undef
      $lc_paper          = undef
      $lc_name           = undef
      $lc_address        = undef
      $lc_telephone      = undef
      $lc_measurement    = undef
      $lc_identification = undef
      $lc_all            = undef
      $package           = 'locales'
      $default_file      = '/etc/default/locale'
      $locale_gen_cmd    = '/usr/sbin/locale-gen'
      $update_locale_cmd = '/usr/sbin/update-locale'
      $supported_locales  = '/usr/share/i18n/SUPPORTED' # ALL locales support

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
