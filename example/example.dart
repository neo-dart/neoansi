import 'dart:io';

import 'package:neoansi/neoansi.dart';

void main() {
  AnsiSink.from(stdout)
    ..setForegroundColor1(Ansi1BitColor.red)
    ..write('Hello ')
    ..setForegroundColor1(Ansi1BitColor.green)
    ..setUnderlined()
    ..write('World')
    ..resetStyles()
    ..writeln('!');
}
