import 'dart:io';

import 'package:neoansi/neoansi.dart';

/// Draws a 16x16 table showing all 256 background color options.
void main() {
  // In this case, directly writes to stdout, but this could also take a buffer.
  final console = AnsiSink.from(stdout);

  // Clear the console to make it easier to read.
  console.clearScreen();

  // Write a table of 7-bit sample colors.
  write1BitSamples(console);

  // Restore console styling.
  console.resetStyles();
}

void write1BitSamples(AnsiSink console) {
  for (var i = 0; i < 16; i++) {
    for (var j = 0; j < 16; j++) {
      final code = i * 16 + j;
      console
        ..setBackgroundColor8(Ansi8BitColors.values[code])
        ..write(' ')
        ..write(code.toString().padLeft(4));
    }
    console.writeln();
  }
}

/// With the provided colors, sets the background color and writes some text.
void write1BitSample(
  AnsiSink console,
  Ansi1BitColors a,
  Ansi1BitColors b,
  Ansi1BitColors c,
  Ansi1BitColors d, {
  bool bright = false,
}) {
  console
    ..setBackgroundColor(a, bright: bright)
    ..write(' A ')
    ..setBackgroundColor(b, bright: bright)
    ..write(' B ')
    ..setBackgroundColor(c, bright: bright)
    ..write(' C ')
    ..setBackgroundColor(d, bright: bright)
    ..write(' D ')
    ..writeln();
}
