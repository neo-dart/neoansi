// ignore_for_file: prefer_const_constructors

import 'package:neoansi/neoansi.dart';
import 'package:test/test.dart';

void main() {
  group('AnsiWriter', () {
    late StringBuffer buffer;
    late AnsiWriter ioSink;

    String readEscaped() {
      final result = buffer.toString().replaceAll('\u001b', r'\u001b');
      buffer.clear();
      return result;
    }

    setUp(() {
      buffer = StringBuffer();
      ioSink = AnsiWriter.from(buffer);
    });

    test('should write the escape sequence for clearing the screen', () {
      ioSink.clearScreen();
      expect(readEscaped(), r'\u001b[2J');

      ioSink.clearScreenBefore();
      expect(readEscaped(), r'\u001b[1J');

      ioSink.clearScreenAfter();
      expect(readEscaped(), r'\u001b[0J');
    });

    test('should write the escape sequence for clearing the line', () {
      ioSink.clearLine();
      expect(readEscaped(), r'\u001b[2K');

      ioSink.clearLineBefore();
      expect(readEscaped(), r'\u001b[1K');

      ioSink.clearLineAfter();
      expect(readEscaped(), r'\u001b[0K');
    });

    test('should write the escape sequence for resetting styles', () {
      ioSink.resetStyles();
      expect(readEscaped(), r'\u001b[0m');
    });

    test('should write the escape sequence for 1-bit foreground color', () {
      ioSink.setForegroundColor1(Ansi1BitColor.red);
      expect(readEscaped(), r'\u001b[31m');

      ioSink.setForegroundColor1(Ansi1BitColor.red, bright: true);
      expect(readEscaped(), r'\u001b[91m');
    });

    test('should write the escape sequence for 1-bit background color', () {
      ioSink.setBackgroundColor1(Ansi1BitColor.red);
      expect(readEscaped(), r'\u001b[41m');

      ioSink.setBackgroundColor1(Ansi1BitColor.red, bright: true);
      expect(readEscaped(), r'\u001b[101m');
    });

    test('should write the escape sequence for 8-bit foreground color', () {
      ioSink.setForegroundColor8(Ansi8BitColor.darkOliveGreen1);
      expect(readEscaped(), r'\u001b[38;5;191m');
    });

    test('should write the escape sequence for 8-bit background color', () {
      ioSink.setBackgroundColor8(Ansi8BitColor.cadetBlue);
      expect(readEscaped(), r'\u001b[48;5;72m');
    });

    test('should write the escape sequence for 24-bit foreground color', () {
      ioSink.setForegroundColor24(Color.fromRGB(0xAA, 0xBB, 0xCC));
      expect(readEscaped(), r'\u001b[38;2;170;187;204m');
    });

    test('should write the escape sequence for 24-bit background color', () {
      ioSink.setBackgroundColor24(Color.fromRGB(0xAA, 0xBB, 0xCC));
      expect(readEscaped(), r'\u001b[48;2;170;187;204m');
    });

    test('should write the escape sequence for set/clear bold', () {
      ioSink.setBold();
      expect(readEscaped(), r'\u001b[1m');

      ioSink.clearBold();
      expect(readEscaped(), r'\u001b[22m');
    });

    test('should write the escape sequence for set/clear underlined', () {
      ioSink.setUnderlined();
      expect(readEscaped(), r'\u001b[4m');

      ioSink.setDoubleUnderlined();
      expect(readEscaped(), r'\u001b[21m');

      ioSink.clearUnderlined();
      expect(readEscaped(), r'\u001b[24m');
    });

    test('should write the escape sequence for reversing colors', () {
      ioSink.reverseColors();
      expect(readEscaped(), r'\u001b[7m');
    });

    test('should write the escape sequence for cursor movement', () {
      expect(() => ioSink.moveCursorUp(-1), throwsArgumentError);
      ioSink.moveCursorUp();
      expect(readEscaped(), r'\u001b[1A');

      expect(() => ioSink.moveCursorDown(-1), throwsArgumentError);
      ioSink.moveCursorDown(2);
      expect(readEscaped(), r'\u001b[2B');

      expect(() => ioSink.moveCursorRight(-1), throwsArgumentError);
      ioSink.moveCursorRight(3);
      expect(readEscaped(), r'\u001b[3C');

      expect(() => ioSink.moveCursorLeft(-1), throwsArgumentError);
      ioSink.moveCursorLeft(4);
      expect(readEscaped(), r'\u001b[4D');

      expect(() => ioSink.moveCursorNextLine(-1), throwsArgumentError);
      ioSink.moveCursorNextLine();
      expect(readEscaped(), r'\u001b[1E');

      expect(() => ioSink.moveCursorNextLine(-1), throwsArgumentError);
      ioSink.moveCursorPreviousLine(2);
      expect(readEscaped(), r'\u001b[2F');

      expect(() => ioSink.setCursorX(-1), throwsArgumentError);
      ioSink.setCursorX(12);
      expect(readEscaped(), r'\u001b[12G');

      expect(() => ioSink.setCursorY(-1), throwsArgumentError);
      ioSink.setCursorY(13);
      expect(readEscaped(), r'\u001b[13H');
    });

    test('should write the escape sequence for save/restore cursor', () {
      ioSink.saveCursor();
      expect(readEscaped(), r'\u001b[s');

      ioSink.restoreCursor();
      expect(readEscaped(), r'\u001b[r');
    });

    test('should write the escape sequence for show/hide cursor', () {
      ioSink.showCursor();
      expect(readEscaped(), r'\u001b[25h');

      ioSink.hideCursor();
      expect(readEscaped(), r'\u001b[25l');
    });

    group('.from should support the standard sink interface', () {
      test('write', () {
        ioSink.write('Hello');
        expect(readEscaped(), 'Hello');
      });

      test('writeAll', () {
        ioSink.writeAll([1, 2, 3], ' ');
        expect(readEscaped(), '1 2 3');
      });

      test('writeCharCode', () {
        ioSink.writeCharCode('M'.codeUnitAt(0));
        expect(readEscaped(), 'M');
      });

      test('writeln', () {
        ioSink.writeln('Hello');
        expect(readEscaped(), 'Hello\n');
      });
    });
  });
}
