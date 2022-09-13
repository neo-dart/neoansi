# CHANGELOG

## 0.3.2+1

- Bug fix: `AnsiReader` captures and invokes `<AnsiListener>.resetStyes()`.

## 0.3.2

- Export `Color` (from `package:neocolor`).

## 0.3.1

- Added `AnsiReader`, an ANSI escape parser, i.e. for a terminal emulator.
- Added `AnsiListener`, a base interface for `AnsiReader` and `AnsiWriter`.
- Renamed `AnsiSink` to `AnsiWriter` (`AnsiSink` is deprecated).

## 0.3.0

- Added a dependency on [`package:neocolor`](https://pub.dev/packages/neocolor).
- Added `setForegroundColor1` and `setBackgroundColor1` (for 1-bit colors).
- Added `setForegroundColor24` and `setBackgroundColor24` (for 24-bit colors).

### Breaking Changes

- Removed `setForegroundColor` and `setBackgroundColor`.
- Removed `Ansi{1,8}BitColors` (use `Ansi{1,8}BitColor` instead).

## 0.2.1

- Added to `AnsiSink`:
  - `hideCursor`
  - `showCursor`
  - `setDoubleUnderlined`
  - `clearBold`
  - `clearUnderlined`
  - `setForegroundColor24` and `setBackgroundColor24` (for 24-bit RGB color).
- Renamed `Ansi1BitColors` to `Ansi1BitColor` (`Ansi1BitColors` is deprecated).
- Renamed `Ansi8BitColors` to `Ansi8BitColor` (`Ansi8BitColors` is deprecated).

## 0.2.0

- Fixed the generation of members on `Ansi8BitColors`.

## 0.1.0

- Initial release.
