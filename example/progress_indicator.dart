import 'dart:io';

import 'package:neoansi/neoansi.dart';

void main() {
  final console = AnsiWriter.from(stdout)..writeln('Loading...');

  for (var i = 0; i < 100; i++) {
    sleep(const Duration(milliseconds: 10));
    final width = (i + 1) ~/ 4;
    final bar = '[${'#' * width}${' ' * (25 - width)}]';
    console
      ..moveCursorLeft(1000)
      ..write(bar);
  }

  console.writeln('\nDone!');
}
