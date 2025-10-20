# locales module for Puppet

[![Build Status](https://github.com/saz/puppet-locales/workflows/CI/badge.svg)](https://github.com/saz/puppet-locales/actions?query=workflow%3ACI)

Manage locales via Puppet

## Usage

By default, en and de locales will be generated.

```
  class { 'locales': }
```

Configure a bunch of locales.

```
  class { 'locales':
    locales   => ['en_US.UTF-8 UTF-8', 'fr_CH.UTF-8 UTF-8'],
  }
```

Advanced usage allows you to select which locales will be configured as well as the default one.

```
  class { 'locales':
    default_locale  => 'en_US.UTF-8',
    locales         => ['en_US.UTF-8 UTF-8', 'fr_CH.UTF-8 UTF-8'],
  }
```

You can also set specific locale environment variables. See the locale man-page
for available LC_* environment variables and their descriptions:

```
  class { 'locales':
    default_locale  => 'en_US.UTF-8',
    locales         => ['en_US.UTF-8 UTF-8', 'fr_CH.UTF-8 UTF-8', 'en_DK.UTF-8 UTF-8', 'de_DE.UTF-8 UTF-8' ],
    lc_time         => 'en_DK.UTF-8',
    lc_paper        => 'de_DE.UTF-8',
  }
```
