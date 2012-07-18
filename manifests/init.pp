# Class: locales
#
# This module manages locales
#
# Parameters:
#   [*locales*]
#     Name of locales to generate
#     Default: [ 'en_US.UTF-8 UTF-8', 'de_DE.UTF-8 UTF-8', ]
#
#   [*ensure*]
#     Ensure if present or absent.
#     Default: present
#
#   [*autoupgrade*]
#     Upgrade package automatically, if there is a newer version.
#     Default: false
#
#   [*package*]
#     Name of the package.
#     Only set this, if your platform is not supported or you know, what you're doing.
#     Default: auto-set, platform specific
#
#   [*config_file*]
#     Main configuration file.
#     Only set this, if your platform is not supported or you know, what you're doing.
#     Default: auto-set, platform specific
#
#   [*locale_gen_command*]
#     Command to generate locales.
#     Only set this, if your platform is not supported or you know, what you're doing.
#     Default: auto-set, platform specific
#
# Actions:
#   Installs locales package and generates specified locales
#
# Requires:
#   Nothing
#
# Sample Usage:
#   class { 'locales':
#     locales => [ 'en_US.UTF-8 UTF-8', 'de_DE.UTF-8 UTF-8', 'en_GB.UTF-8 UTF-8', ],
#   }
#
# [Remember: No empty lines between comments and class definition]
class locales(
  $locales = [ 'en_US.UTF-8 UTF-8', 'de_DE.UTF-8 UTF-8', ],
  $ensure = 'present',
  $autoupgrade = false,
  $package = $locales::params::package,
  $config_file = $locales::params::config_file,
  $locale_gen_cmd = $locales::params::locale_gen_cmd,
  $default_file = $locales::params::default_file,
  $update_locale_pkg = $locales::params::update_locale_pkg,
  $update_locale_cmd = $locales::params::update_locale_cmd
) inherits locales::params {

  case $ensure {
    /(present)/: {
      if $autoupgrade == true {
        $package_ensure = 'latest'
      } else {
        $package_ensure = 'present'
      }
    }
    /(absent)/: {
      $package_ensure = 'absent'
    }
    default: {
      fail('ensure parameter must be present or absent')
    }
  }

  package { $package:
    ensure => $package_ensure,
  }

  package { $update_locale_pkg:
    ensure => $package_ensure,
  }

  file { $config_file:
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => 0644,
    content => template('locales/locale.gen.erb'),
    require => Package[$package],
    notify  => Exec['locale-gen'],
  }

  file { $default_file:
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => 0644,
    require => Package[$update_locale_pkg],
    notify  => Exec['update-locale'],
  }

  exec { 'locale-gen':
    command     => $locale_gen_cmd,
    refreshonly => true,
    require     => Package[$package],
  }

  exec { 'update-locale':
    command     => $update_locale_cmd,
    refreshonly => true,
    require     => Package[$update_locale_pkg],
  }

}
