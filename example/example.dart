import 'dart:io';

import 'package:neoansi/neoansi.dart';

void main() {
  AnsiSink.from(stdout)
    ..setForegroundColor(Ansi1BitColors.red)
    ..write('Hello ')
    ..setForegroundColor(Ansi1BitColors.green)
    ..setUnderlined()
    ..write('World')
    ..resetStyles()
    ..writeln('!');
}
