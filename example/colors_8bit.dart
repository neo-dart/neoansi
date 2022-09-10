import 'dart:io';

import 'package:neoansi/neoansi.dart';

/// Draws a 16x16 table showing all 256 background color options.
void main() {
  // In this case, directly writes to stdout, but this could also take a buffer.
  final console = AnsiSink.from(stdout);

  // Write a table of 8-bit sample colors.
  _write8BitSamples(console);

  // Restore console styling.
  console.resetStyles();
}

void _write8BitSamples(AnsiSink console) {
  for (var i = 0; i < 16; i++) {
    for (var j = 0; j < 16; j++) {
      final code = i * 16 + j;
      console
        ..setBackgroundColor8(Ansi8BitColor.values[code])
        ..write(' ')
        ..write(code.toString().padLeft(4))
        ..resetStyles();
    }
    console.writeln();
  }
}
