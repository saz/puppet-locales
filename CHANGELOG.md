# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.1.1]
### Fixed
- Fix warning on Gentoo systems (#64)

## [3.1.0]
### Added
- Support Rocky linux (#60)

## [3.0.0]
### Added
- Support AlmaLinux (#58)
- Support Puppet 7 (#56)
- Support Raspbian (#55)
- Added types to parameters
- Added `manage_package` parameter (#51)
- Added CHANGELOG.md (only for new releases), fixes #43
### Changed
- BREAKING CHANGE: Testing for Puppet < 6 has been dropped
- Switched from Travis to Github Actions
- Dependencies updated to support the newest releases
- Fixed gentoo config_file path (#50)
- Some linting changes
