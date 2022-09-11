// ignore_for_file: prefer_const_constructors

import 'package:neoansi/neoansi.dart';
import 'package:neocolor/neocolor.dart';
import 'package:test/test.dart';

void main() {
  group('AnsiReader', () {
    late AnsiReader reader;
    late List<List<Object?>> captured;

    late AnsiWriter writer;
    late StringBuffer output;

    setUp(() {
      reader = AnsiReader(_StubAnsiListener(captured = []));
      writer = AnsiWriter.from(output = StringBuffer());
    });

    List<List<Object?>> capture() {
      reader.read(output.toString());
      final result = List.of(captured);
      output.clear();
      captured.clear();
      return result;
    }

    test('should NOT capture empty text', () {
      writer.write('');

      expect(capture(), isEmpty);
    });
    test('should capture whitespace', () {
      writer.write(' ');

      expect(capture(), [
        [#write, ' '],
      ]);
    });

    test('should capture blank new lines', () {
      writer.write('\n\n\n');

      expect(capture(), [
        [#write, '\n\n\n'],
      ]);
    });

    test('should capture clearScreen', () {
      writer
        ..clearScreen()
        ..clearScreenBefore()
        ..clearScreenAfter();

      expect(capture(), [
        [#clearScreen],
        [#clearScreenBefore],
        [#clearScreenAfter],
      ]);
    });

    test('should capture clearLine', () {
      writer
        ..clearLine()
        ..clearLineBefore()
        ..clearLineAfter();

      expect(capture(), [
        [#clearLine],
        [#clearLineBefore],
        [#clearLineAfter],
      ]);
    });

    test('should capture cursor movement', () {
      writer
        ..moveCursorUp()
        ..moveCursorDown()
        ..moveCursorRight()
        ..moveCursorLeft()
        ..moveCursorNextLine()
        ..moveCursorPreviousLine()
        ..setCursorX(2)
        ..setCursorY(3);

      expect(capture(), [
        [#moveCursorUp, 1],
        [#moveCursorDown, 1],
        [#moveCursorRight, 1],
        [#moveCursorLeft, 1],
        [#moveCursorNextLine, 1],
        [#moveCursorPreviousLine, 1],
        [#setCursorX, 2],
        [#setCursorY, 3],
      ]);
    });

    test('should capture hide/show cursor', () {
      writer
        ..hideCursor()
        ..showCursor();

      expect(capture(), [
        [#hideCursor],
        [#showCursor],
      ]);
    });

    test('should capture save/restore cursor', () {
      writer
        ..saveCursor()
        ..restoreCursor();

      expect(capture(), [
        [#saveCursor],
        [#restoreCursor],
      ]);
    });

    test('should capture text decorations', () {
      writer
        ..setBold()
        ..setUnderlined()
        ..setDoubleUnderlined()
        ..clearBold()
        ..clearUnderlined()
        ..reverseColors();

      expect(capture(), [
        [#setBold],
        [#setUnderlined],
        [#setDoubleUnderlined],
        [#clearBold],
        [#clearUnderlined],
        [#reverseColors],
      ]);
    });

    test('should capture 1-bit color', () {
      writer
        ..setForegroundColor1(Ansi1BitColor.red)
        ..setForegroundColor1(Ansi1BitColor.blue, bright: true)
        ..setBackgroundColor1(Ansi1BitColor.cyan)
        ..setBackgroundColor1(Ansi1BitColor.green, bright: true);

      expect(capture(), [
        [
          #setForegroundColor1,
          Ansi1BitColor.red,
          [#bright, false]
        ],
        [
          #setForegroundColor1,
          Ansi1BitColor.blue,
          [#bright, true]
        ],
        [
          #setBackgroundColor1,
          Ansi1BitColor.cyan,
          [#bright, false]
        ],
        [
          #setBackgroundColor1,
          Ansi1BitColor.green,
          [#bright, true]
        ],
      ]);
    });

    test('should capture 8-bit color', () {
      writer
        ..setForegroundColor8(Ansi8BitColor.orange4)
        ..setBackgroundColor8(Ansi8BitColor.aquamarine3);

      expect(capture(), [
        [#setForegroundColor8, Ansi8BitColor.orange4],
        [#setBackgroundColor8, Ansi8BitColor.aquamarine3],
      ]);
    });

    test('should capture 24-bit color', () {
      writer
        ..setForegroundColor24(Color.fromRGB(0xAA, 0xBB, 0xCC))
        ..setBackgroundColor24(Color.fromRGB(0xDD, 0xEE, 0xFF));

      expect(capture(), [
        [#setForegroundColor24, Color.fromRGB(0xAA, 0xBB, 0xCC)],
        [#setBackgroundColor24, Color.fromRGB(0xDD, 0xEE, 0xFF)],
      ]);
    });
  });
}

class _StubAnsiListener implements AnsiListener {
  final List<List<Object?>> _invocations;

  _StubAnsiListener(this._invocations);

  @override
  void noSuchMethod(Invocation invocation) {
    _invocations.add([
      invocation.memberName,
      ...invocation.positionalArguments.map((a) => a),
      ...invocation.namedArguments.entries.map((e) => [e.key, e.value]),
    ]);
  }
}
