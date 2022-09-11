part of '/neoansi.dart';

/// A synchronous reader that matches and parses ANSI escape codes.
///
/// This class could be useful to implement a temrinal emulator or debugger.
///
/// Upon invoking the [read] method, any matching/understood ANSI escape codes
/// are handled. For the default implementation [AnsiReader.new], the
/// cooresponding method on [AnsiListener] is invoked.
@immutable
@sealed
abstract class AnsiReader {
  /// Creates a reader that, upon parsing output, invokes [listener].
  const factory AnsiReader(AnsiListener listener) = _AnsiReader;

  /// Reads [text], parsing ANSI escape codes along the way.
  ///
  /// This method is intentionally vague on what happens next. In the default
  /// implementation (i.e. [AnsiReader.new]), the provided [AnsiListener] is
  /// invoked.
  void read(String text);
}

class _AnsiReader implements AnsiReader {
  // Copied from https://github.com/chalk/ansi-regex/blob/main/index.js.
  static final _isAnsiEscape = RegExp(
      '[\\u001B\\u009B][[\\]()#;?]*(?:(?:(?:(?:;[-a-zA-Z\\d\\/#&.:=?%@~_]+)*|'
      '[a-zA-Z\\d]+(?:;[-a-zA-Z\\d\\/#&.:=?%@~_]*)*)?\\u0007)|'
      '(?:(?:\\d{1,4}(?:;\\d{0,4})*)?[\\dA-PR-TZcf-nq-uy=><~]))');

  static final _ansiMatchParts = RegExp(
    '([\\u001B]\\[)(.*)(\\w\$)',
  );

  final AnsiListener _listener;

  const _AnsiReader(this._listener);

  @override
  void read(String text) {
    text.splitMapJoin(
      _isAnsiEscape,
      onMatch: (match) {
        match = _ansiMatchParts.matchAsPrefix(match.group(0)!)!;
        _onParse(match.group(2)!, match.group(3)!);
        return '';
      },
      onNonMatch: (string) {
        if (string.isNotEmpty) {
          _listener.write(string);
        }
        return '';
      },
    );
  }

  void _onParse(String value, String suffix) {
    switch (suffix) {
      case 'A':
        return _listener.moveCursorUp(int.parse(value));
      case 'B':
        return _listener.moveCursorDown(int.parse(value));
      case 'C':
        return _listener.moveCursorRight(int.parse(value));
      case 'D':
        return _listener.moveCursorLeft(int.parse(value));
      case 'E':
        return _listener.moveCursorNextLine(int.parse(value));
      case 'F':
        return _listener.moveCursorPreviousLine(int.parse(value));
      case 'G':
        return _listener.setCursorX(int.parse(value));
      case 'H':
        return _listener.setCursorY(int.parse(value));
      case 'J':
        switch (value) {
          case '0':
            return _listener.clearScreenBefore();
          case '1':
            return _listener.clearScreenAfter();
          case '2':
            return _listener.clearScreen();
        }
        break;
      case 'K':
        switch (value) {
          case '0':
            return _listener.clearLineBefore();
          case '1':
            return _listener.clearLineAfter();
          case '2':
            return _listener.clearLine();
        }
        break;
      case 'h':
        if (value == '25') {
          return _listener.showCursor();
        }
        break;
      case 'l':
        if (value == '25') {
          return _listener.hideCursor();
        }
        break;
      case 'm':
        switch (value) {
          case '1':
            return _listener.setBold();
          case '4':
            return _listener.setUnderlined();
          case '7':
            return _listener.reverseColors();
          case '21':
            return _listener.setDoubleUnderlined();
          case '22':
            return _listener.clearBold();
          case '24':
            return _listener.clearUnderlined();
        }
        if (value.startsWith('38;5;')) {
          return _listener.setForegroundColor8(_parse8Bit(value));
        } else if (value.startsWith('48;5;')) {
          return _listener.setBackgroundColor8(_parse8Bit(value));
        } else if (value.startsWith('38;2;')) {
          return _listener.setForegroundColor24(_parse24Bit(value));
        } else if (value.startsWith('48;2;')) {
          return _listener.setBackgroundColor24(_parse24Bit(value));
        } else {
          return _maybeParse1Bit(value);
        }
      case 's':
        return _listener.saveCursor();
      case 'r':
        return _listener.restoreCursor();
    }
  }

  void _maybeParse1Bit(String value) {
    final code = int.tryParse(value);
    if (code == null) {
      return;
    }
    for (final color in Ansi1BitColor.values) {
      if (color.foreground == code) {
        return _listener.setForegroundColor1(color);
      } else if (color.brightForeground == code) {
        return _listener.setForegroundColor1(color, bright: true);
      } else if (color.background == code) {
        return _listener.setBackgroundColor1(color);
      } else if (color.brightBackground == code) {
        return _listener.setBackgroundColor1(color, bright: true);
      }
    }
  }

  static Ansi8BitColor _parse8Bit(String value) {
    final parts = value.split(';');
    return Ansi8BitColor.values[int.parse(parts[2])];
  }

  static Color _parse24Bit(String value) {
    final parts = value.split(';');
    return Color.fromRGB(
      int.parse(parts[2]),
      int.parse(parts[3]),
      int.parse(parts[4]),
    );
  }
}
