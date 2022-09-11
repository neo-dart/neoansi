import 'dart:io';

import 'package:neoansi/neoansi.dart';

void main() {
  AnsiWriter.from(stdout)
    ..setForegroundColor1(Ansi1BitColor.red)
    ..write('Hello ')
    ..setForegroundColor1(Ansi1BitColor.green)
    ..setUnderlined()
    ..write('World')
    ..resetStyles()
    ..writeln('!');
}
