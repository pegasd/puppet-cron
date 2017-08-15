# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- The Changelog.

### Changed
- A few more acceptance tests.
- Idempotence tests refactored.
- Adding/removing cron entries does not reload the cron service anymore.
- `Cron::Minute` and `Cron::Hour` now accept ranges and patterns like `*/2`
  inside an array.
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
