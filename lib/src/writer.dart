part of '/neoansi.dart';

/// An output string sink that assumes the effect of ANSI escape codes.
///
/// **Deprecated**: see [AnsiWriter].
@Deprecated('Renamed AnsiWriter')
typedef AnsiSink = AnsiWriter;

/// An output string sink that assumes the effect of ANSI escape codes.
///
/// What this means in practice is that it acts a _translation_ layer from Dart
/// APIs (i.e. [setForegroundColor1]) and adds equivalent ANSI escape sequence
/// codes to the output buffer.
abstract class AnsiWriter implements AnsiListener, StringSink {
  /// Creates an [AnsiWriter] that wraps and writes to the provided [sink].
  const factory AnsiWriter.from(StringSink sink) = _AnsiStringSink;

  // ignore: public_member_api_docs
  const AnsiWriter();

  /// Writes an ANSI escape sequence of [object] with the provided [suffix].
  ///
  /// Converts [object] to a string using `object.toString()`.
  ///
  /// **NOTE**: In practice, this emits the string: `\u001b[{object}{suffix}`.
  void _writeEscape(Object object, String suffix) {
    const ansiEscapePrefix = '\u001b[';
    write('$ansiEscapePrefix$object$suffix');
  }

  @override
  void clearScreen() => _writeEscape('2', 'J');

  @override
  void clearScreenAfter() => _writeEscape('0', 'J');

  @override
  void clearScreenBefore() => _writeEscape('1', 'J');

  @override
  void clearLine() => _writeEscape('2', 'K');

  @override
  void clearLineAfter() => _writeEscape('0', 'K');

  @override
  void clearLineBefore() => _writeEscape('1', 'K');

  @override
  void resetStyles() => _writeEscape('0', 'm');

  @override
  void setForegroundColor1(Ansi1BitColor color, {bool bright = false}) {
    final code = bright ? color.brightForeground : color.foreground;
    _writeEscape(code, 'm');
  }

  @override
  void setBackgroundColor1(Ansi1BitColor color, {bool bright = false}) {
    final code = bright ? color.brightBackground : color.background;
    _writeEscape(code, 'm');
  }

  @override
  void setForegroundColor8(Ansi8BitColor color) {
    final code = color.index;
    _writeEscape('38;5;$code', 'm');
  }

  @override
  void setBackgroundColor8(Ansi8BitColor color) {
    final code = color.index;
    _writeEscape('48;5;$code', 'm');
  }

  @override
  void setForegroundColor24(Color color) {
    final r = color.red;
    final g = color.green;
    final b = color.blue;
    _writeEscape('38;2;$r;$g;$b', 'm');
  }

  @override
  void setBackgroundColor24(Color color) {
    final r = color.red;
    final g = color.green;
    final b = color.blue;
    _writeEscape('48;2;$r;$g;$b', 'm');
  }

  @override
  void setBold() => _writeEscape('1', 'm');

  @override
  void setUnderlined() => _writeEscape('4', 'm');

  @override
  void setDoubleUnderlined() => _writeEscape('21', 'm');

  @override
  void clearBold() => _writeEscape('22', 'm');

  @override
  void clearUnderlined() => _writeEscape('24', 'm');

  @override
  void reverseColors() => _writeEscape('7', 'm');

  @override
  void moveCursorUp([int rows = 1]) {
    _writeEscape(RangeError.checkNotNegative(rows), 'A');
  }

  @override
  void moveCursorDown([int rows = 1]) {
    _writeEscape(RangeError.checkNotNegative(rows), 'B');
  }

  @override
  void moveCursorRight([int columns = 1]) {
    _writeEscape(RangeError.checkNotNegative(columns), 'C');
  }

  @override
  void moveCursorLeft([int columns = 1]) {
    _writeEscape(RangeError.checkNotNegative(columns), 'D');
  }

  @override
  void moveCursorNextLine([int lines = 1]) {
    _writeEscape(RangeError.checkNotNegative(lines), 'E');
  }

  @override
  void moveCursorPreviousLine([int lines = 1]) {
    _writeEscape(RangeError.checkNotNegative(lines), 'F');
  }

  @override
  void setCursorX(int column) {
    _writeEscape(RangeError.checkNotNegative(column), 'G');
  }

  @override
  void setCursorY(int row) {
    _writeEscape(RangeError.checkNotNegative(row), 'H');
  }

  @override
  void saveCursor() => _writeEscape('s', '');

  @override
  void restoreCursor() => _writeEscape('r', '');

  @override
  void showCursor() => _writeEscape('25', 'h');

  @override
  void hideCursor() => _writeEscape('25', 'l');
}

@sealed
class _AnsiStringSink extends AnsiWriter {
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
