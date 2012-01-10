# puppet-locales

Manage locales via Puppet

## Usage

By default, en and de locales will be generated.

```
  class { 'locales': }
```

## Other class parameters
* ensure: present or absent, default: present
* autoupgrade: true or false, default: false. Auto-upgrade package, if there is a newer version.
* package: string, default: OS specific. Set package name, if platform is not supported.
* config_file: string, default: OS specific. Set config_file, if platform is not supported.
* locale_gen_command: string, default: OS specific. Set locale_gen_command, if platform is not supported.
