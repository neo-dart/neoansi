import 'dart:io';

import 'package:neoansi/neoansi.dart';

/// Draws a 4x4 table showing all 16 background color options.
void main() {
  // In this case, directly writes to stdout, but this could also take a buffer.
  final console = AnsiSink.from(stdout);

  // Write a table of 1-bit sample colors.
  _write1BitSamples(console);

  // Restore console styling.
  console.resetStyles();
}

void _write1BitSamples(AnsiSink console) {
  // Write fancy formatted text!
  _write1BitSample(
    console,
    Ansi1BitColor.black,
    Ansi1BitColor.red,
    Ansi1BitColor.green,
    Ansi1BitColor.yellow,
  );

  _write1BitSample(
    console,
    Ansi1BitColor.blue,
    Ansi1BitColor.magenta,
    Ansi1BitColor.cyan,
    Ansi1BitColor.white,
  );

  _write1BitSample(
    console,
    Ansi1BitColor.black,
    Ansi1BitColor.red,
    Ansi1BitColor.green,
    Ansi1BitColor.yellow,
    bright: true,
  );

  _write1BitSample(
    console,
    Ansi1BitColor.blue,
    Ansi1BitColor.magenta,
    Ansi1BitColor.cyan,
    Ansi1BitColor.white,
    bright: true,
  );
}

/// With the provided colors, sets the background color and writes some text.
void _write1BitSample(
  AnsiSink console,
  Ansi1BitColor a,
  Ansi1BitColor b,
  Ansi1BitColor c,
  Ansi1BitColor d, {
  bool bright = false,
}) {
  console
    ..setBackgroundColor1(a, bright: bright)
    ..write(' A ')
    ..setBackgroundColor1(b, bright: bright)
    ..write(' B ')
    ..setBackgroundColor1(c, bright: bright)
    ..write(' C ')
    ..setBackgroundColor1(d, bright: bright)
    ..write(' D ')
    ..writeln();
}
