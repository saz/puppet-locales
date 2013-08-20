# puppet-locales

Manage locales via Puppet

## Usage

By default, en and de locales will be generated.

```
  class { 'locales': }
```

Advanced usage allows you to select which locales will be configured as well as the default one.


```
  class { 'locales':
    default_locale  => 'en_US.UTF-8',
    locales         => ['en_US.UTF-8 UTF-8', 'fr_CH.UTF-8 UTF-8'],
  }
```

## Other class parameters
* locales: Name of locales to generate, default: ['en_US.UTF-8 UTF-8', 'de_DE.UTF-8 UTF-8']
* ensure: present or absent, default: present
* default_locale: string, default: 'C'. Set the default locale.
* autoupgrade: true or false, default: false. Auto-upgrade package, if there is a newer version.
* package: string, default: OS specific. Set package name, if platform is not supported.
* config_file: string, default: OS specific. Set config_file, if platform is not supported.
* locale_gen_command: string, default: OS specific. Set locale_gen_command, if platform is not supported.
