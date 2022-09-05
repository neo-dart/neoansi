part of '/neoansi.dart';

/// An output string sink that assumes the effect of ANSI escape codes.
///
/// What this means in practice is that it acts a _translation_ layer from Dart
/// APIs (i.e. [setForegroundColor]) and adds equivalent ANSI escape sequence
/// codes to the output buffer.
abstract class AnsiSink implements StringSink {
  /// Creates an [AnsiSink] that wraps and writes to the provided [sink].
  const factory AnsiSink.from(StringSink sink) = _AnsiStringSink;

  // ignore: public_member_api_docs
  const AnsiSink();

  /// Writes an ANSI escape sequence of [object] with the provided [suffix].
  ///
  /// Converts [object] to a string using `object.toString()`.
  ///
  /// **NOTE**: In practice, this emits the string: `\u001b[{object}{suffix}`.
  void _writeEscape(Object object, String suffix) {
    const ansiEscapePrefix = '\u001b[';
    write('$ansiEscapePrefix$object$suffix');
  }

  /// Clears the entire output screen.
  void clearScreen() => _writeEscape('2', 'J');

  /// Clears the entire output screen _before_ the cursor location.
  void clearScreenBefore() => _writeEscape('0', 'J');

  /// Clears the entire output screen _after_ the cursor location.
  void clearScreenAfter() => _writeEscape('1', 'J');

  /// Clears the current cline.
  void clearLine() => _writeEscape('2', 'K');

  /// Clears the current line _before_ the cursor location.
  void clearLineBefore() => _writeEscape('0', 'K');

  /// Clears the current line _after_ the cursor location.
  void clearLineAfter() => _writeEscape('1', 'K');

  /// Resets all styling to the default.
  void resetStyles() => _writeEscape('0', 'm');

  /// Sets subsequent text's foreground color.
  void setForegroundColor(Ansi1BitColors color, {bool bright = false}) {
    final code = bright ? color.brightForeground : color.foreground;
    _writeEscape(code, 'm');
  }

  /// Sets subsequent text's foreground color.
  void setForegroundColor8(Ansi8BitColors color) {
    final code = color.index;
    _writeEscape('38;5;$code', 'm');
  }

  /// Sets subequent text's background color.
  void setBackgroundColor(Ansi1BitColors color, {bool bright = false}) {
    final code = bright ? color.brightBackground : color.background;
    _writeEscape(code, 'm');
  }

  /// Sets subsequent text's background color.
  void setBackgroundColor8(Ansi8BitColors color) {
    final code = color.index;
    _writeEscape('48;5;$code', 'm');
  }

  /// Sets text decoration style to include **bold**.
  void setBold() => _writeEscape('1', 'm');

  /// Sets text decoration style to include <u>underlined</u>.
  void setUnderlined() => _writeEscape('4', 'm');

  /// Reverses the foreground and background colors.
  void reverseColors() => _writeEscape('7', 'm');

  /// Moves the cursor up [rows].
  void moveCursorUp([int rows = 1]) {
    _writeEscape(RangeError.checkNotNegative(rows), 'A');
  }

  /// Moves the cursor down [rows].
  void moveCursorDown([int rows = 1]) {
    _writeEscape(RangeError.checkNotNegative(rows), 'B');
  }

  /// Moves the cursor right [columns].
  void moveCursorRight([int columns = 1]) {
    _writeEscape(RangeError.checkNotNegative(columns), 'C');
  }

  /// Moves the cursor left [columns].
  void moveCursorLeft([int columns = 1]) {
    _writeEscape(RangeError.checkNotNegative(columns), 'D');
  }

  /// Moves the cursor to the beginning of the next [lines].
  void moveCursorNextLine([int lines = 1]) {
    _writeEscape(RangeError.checkNotNegative(lines), 'E');
  }

  /// Moves the cursor to the beginning of the previous [lines].
  void moveCursorPreviousLine([int lines = 1]) {
    _writeEscape(RangeError.checkNotNegative(lines), 'F');
  }

  /// Moves the cursor to [column].
  void setCursorX(int column) {
    _writeEscape(RangeError.checkNotNegative(column), 'G');
  }

  /// Moves the cursor to [row].
  void setCursorY(int row) {
    _writeEscape(RangeError.checkNotNegative(row), 'H');
  }

  /// Saves the current cursor position.
  void saveCursor() => _writeEscape('s', '');

  /// Restores the current cursor position from a previously saved position.
  void restoreCursor() => _writeEscape('r', '');
}

@sealed
class _AnsiStringSink extends AnsiSink {
  final StringSink _sink;

  const _AnsiStringSink(this._sink);

  @override
  void write(Object? object) => _sink.write(object);

  @override
  void writeAll(Iterable<Object?> objects, [String separator = '']) {
    _sink.writeAll(objects, separator);
  }

  @override
  void writeCharCode(int charCode) => _sink.writeCharCode(charCode);

  @override
  void writeln([Object? object = '']) => _sink.writeln(object);
}
