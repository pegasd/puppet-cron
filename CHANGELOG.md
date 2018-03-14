# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- Acceptance tests for `/etc/cron.allow`.
- Manage package version through `$cron::package_version` parameter.
- The following parameters are now available to manage cron service:
  - `$cron::service_manage`
  - `$cron::service_ensure`
  - `$cron::service_enable`

### Changed
- Create an empty `/etc/cron.allow` by default.
- `cron::job` input is stricter:
  - `command` does not accept newlines
  - `user` accepts strings of at least 1 character
  - all time values have been updated (`\A`, `\z` instead of `^` and `$`)

## [0.4.0] - 2018-03-05
### Added
- Acceptance testing on Ubuntu 18.04.
- Acceptance tests for `cron::job`.
- `REFERENCE.md` generated using puppet-strings.

### Changed
- Travis configuration prettified.
- Documentation cleanups.
- Acceptance tests split up into multiple spec files.

### Fixed
- Removal order that led to (through a chain of other events) a non-working `ensure => absent` on Ubuntu 18.04.
- Proper trailing newline handling for `/etc/cron.allow` and `/etc/cron.deny`.

## [0.3.0] - 2017-12-21
### Added
- The Changelog.
- `$::cron::purge_noop` parameter that disables crontab purging (but you'll still see noop notices).
- `$::cron::allowed_users` and `$::cron::denied_users` parameters that manage users thru `cron.allow` and `cron.deny` files.

### Changed
- A few more acceptance tests.
- Idempotence tests refactored.
- Adding/removing cron entries does not reload the cron service anymore.
- `Cron::Minute` and `Cron::Hour` now accept ranges and patterns like `*/2` inside an array.
- Because of the previous change, `cron::prep4cron` function doesn't sort the array
  anymore, it simply throws away repeated values.
- All `Cron::` types accept a minimum of 2 array elements instead of 1.
- Updated tests for `Cron::` types as rspec-puppet now supports these natively. w00h00!
- Added `require ::cron` to the `cron::job` define. It is now not necessary to include it.
  Beware though, that this might break if you don't have any cron jobs defined. No purging for you then!

### Fixed
- Updated documentation for `cron::prep4cron()` function.

## [0.2.0] - 2017-02-10
### Added
- This is the first clean release of the cron module.

### Changed
- Removed all incron references (this used to be cron + incron module).

## [0.1.0] - 2017-02-08 [YANKED]
### Added
- This used to be cron + incron module. After reading lots of suggestions about single-purposeness of modules,
  I decided to split this module into two and make this a pure cron-only one.
- [This](https://github.com/pegasd/puppet-cron/tree/bfa2055056abe6dc056ca08d7cb6afa508d57dd5) is the last
  point where you can check the previous approach.
- Doesn't seem feasible to release this, hence the [YANKED] tag.
