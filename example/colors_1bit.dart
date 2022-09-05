import 'dart:io';

import 'package:neoansi/neoansi.dart';

/// Draws a 4x4 table showing all 16 background color options.
void main() {
  // In this case, directly writes to stdout, but this could also take a buffer.
  final console = AnsiSink.from(stdout);

  // Clear the console to make it easier to read.
  console.clearScreen();

  // Write a table of 1-bit sample colors.
  write1BitSamples(console);

  // Restore console styling.
  console.resetStyles();
}

void write1BitSamples(AnsiSink console) {
  // Write fancy formatted text!
  write1BitSample(
    console,
    Ansi1BitColors.black,
    Ansi1BitColors.red,
    Ansi1BitColors.green,
    Ansi1BitColors.yellow,
  );

  write1BitSample(
    console,
    Ansi1BitColors.blue,
    Ansi1BitColors.magenta,
    Ansi1BitColors.cyan,
    Ansi1BitColors.white,
  );

  write1BitSample(
    console,
    Ansi1BitColors.black,
    Ansi1BitColors.red,
    Ansi1BitColors.green,
    Ansi1BitColors.yellow,
    bright: true,
  );

  write1BitSample(
    console,
    Ansi1BitColors.blue,
    Ansi1BitColors.magenta,
    Ansi1BitColors.cyan,
    Ansi1BitColors.white,
    bright: true,
  );
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
