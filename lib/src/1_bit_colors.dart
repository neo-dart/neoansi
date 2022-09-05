part of '/neoansi.dart';

/// 1-bit ANSI supported [foreground] and [background] colors on most terminals.
///
/// This enum may be used to constrain possible colors in an API, i.e.:
/// ```
/// void drawText(String message, {Ansi1BitColors? color}) { /* ... */ }
/// ```
///
/// On platforms where 8 more colors are available (called "bright", or "high
/// intensity") you may additionally use [brightForeground] or
/// [brightBackground].
///
/// Where possible, members describe their colors using [xterm][]'s RGB value.
///
/// [xterm]: https://en.wikipedia.org/wiki/Xterm#/media/File:Xterm_256color_chart.svg
enum Ansi1BitColors {
  // As tempting as it might be, do **not** alphabetically sort the members.
  // Each .index value is used to represent an absolute value, just to be
  // memory efficeint (over allocating another field per instance).

  /// Represents "black", `(0, 0, 0)` in xterm RGB and varies elsewhere.
  ///
  /// When bright, `(127, 127, 127)`.
  black,

  /// Represents "red", `(205, 0, 0)` in xterm RGB and varies elsewhere.
  ///
  /// When bright, `(255, 0, 0)`.
  red,

  /// Represents "green", `(0, 205, 0)` in xterm RGB and varies elsewhere.
  ///
  /// When bright, `(0, 255, 0)`.
  green,

  /// Represents "yellow", `(205, 205, 0)` in xterm RGB and varies elsewhere.
  ///
  /// When bright, `(255, 255, 0)`.
  yellow,

  /// Represents "blue", `(0, 0, 238)` in xterm RGB and varies elsewhere.
  ///
  /// When bright, `(92, 92, 255)`.
  blue,

  /// Represents "magenta", `(205, 0, 205)` in xterm RGB and varies elsewhere.
  ///
  /// When bright, `(255, 0, 255)`.
  magenta,

  /// Represents "cyan", `(0, 205, 205)` in xterm RGB and varies elsewhere.
  ///
  /// When bright, `(0, 255, 255)`.
  cyan,

  /// Represents "white", `(229, 229, 229)` in xterm RGB and varies elsewhere.
  ///
  /// When bright, `(255, 255, 255)`.
  white;

  // See https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit.
  static const _offsetToForegroundColors = 30;
  static const _offsetToBackgroundColors = 40;
  static const _offsetToBrightForegroundColors = 90;
  static const _offsetToBrightBackgroundColors = 100;

  /// Escape sequence value representing this color as foreground color.
  ///
  /// ```dart
  /// import 'dart:io';
  ///
  /// void main() {
  ///   example(Ansi1BitColors.red, 'Hello World');
  /// }
  ///
  /// void example(Ansi1BitColors color, String message) {
  ///   stdout.write('\u001b[${color.foreground}m');
  ///   stdout.write(message);
  /// }
  /// ```
  int get foreground => index + _offsetToForegroundColors;

  /// Escape sequence value representing this color as bright foreground color.
  ///
  /// /// ```dart
  /// import 'dart:io';
  ///
  /// void main() {
  ///   example(Ansi1BitColors.red, 'Hello World');
  /// }
  ///
  /// void example(Ansi1BitColors color, String message) {
  ///   stdout.write('\u001b[${color.brightForeground}m');
  ///   stdout.write(message);
  /// }
  /// ```
  int get brightForeground => index + _offsetToBrightForegroundColors;

  /// Escape sequence value representing this color as background color.
  ///
  /// ```dart
  /// import 'dart:io';
  ///
  /// void main() {
  ///   example(Ansi1BitColors.red, 'Hello World');
  /// }
  ///
  /// void example(Ansi1BitColors color, String message) {
  ///   stdout.write('\u001b[${color.background}m');
  ///   stdout.write(message);
  /// }
  /// ```
  int get background => index + _offsetToBackgroundColors;

  /// Escape sequence value representing this color as bright background color.
  ///
  /// ```dart
  /// import 'dart:io';
  ///
  /// void main() {
  ///   example(Ansi1BitColors.red, 'Hello World');
  /// }
  ///
  /// void example(Ansi1BitColors color, String message) {
  ///   stdout.write('\u001b[${color.brightBackground}m');
  ///   stdout.write(message);
  /// }
  /// ```
  ///
  /// **NOTE**: Bright versions of the background colors do not change the
  /// background, but rather make the _foreground_ text brighter. This is
  /// unintuitive but that's just the way it works.
  int get brightBackground => index + _offsetToBrightBackgroundColors;
}
