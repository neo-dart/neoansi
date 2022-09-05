import 'dart:io';

import 'package:neoansi/neoansi.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

import '../tool/src/colors.dart';

void main() {
  group('Ansi1BitColors', () {
    (const {
      Ansi1BitColors.black: [30, 40, 90, 100],
      Ansi1BitColors.red: [31, 41, 91, 101],
      Ansi1BitColors.green: [32, 42, 92, 102],
      Ansi1BitColors.yellow: [33, 43, 93, 103],
      Ansi1BitColors.blue: [34, 44, 94, 104],
      Ansi1BitColors.magenta: [35, 45, 95, 105],
      Ansi1BitColors.cyan: [36, 46, 96, 106],
      Ansi1BitColors.white: [37, 47, 97, 107],
    }).forEach((color, values) {
      final expectedForeground = values[0];
      final expectedBackground = values[1];
      final expectedBrightForeground = values[2];
      final expectedBrightBackground = values[3];

      test('$color should have expected ANSI escape code values', () {
        expect(color.foreground, expectedForeground);
        expect(color.background, expectedBackground);
        expect(color.brightForeground, expectedBrightForeground);
        expect(color.brightBackground, expectedBrightBackground);
      });
    });
  });

  group('Ansi8BitColors', () {
    late final List<ColorDefinition> colors;

    setUpAll(() {
      colors = decodeJsonColors(
        File(path.join('tool', '256-colors.json')).readAsStringSync(),
      );
    });

    for (final value in Ansi8BitColors.values) {
      test('.$value', () {
        expect(
          value.name.toLowerCase(),
          contains(colors[value.index].name.toLowerCase()),
        );
      });
    }
  });
}
