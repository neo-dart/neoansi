# neoansi

ANSI escape sequences and styling micro-library written in fluent/modern Dart.

[![On pub.dev][pub_img]][pub_url]
[![Code coverage][cov_img]][cov_url]
[![Github action status][gha_img]][gha_url]
[![Dartdocs][doc_img]][doc_url]
[![Style guide][sty_img]][sty_url]

[pub_url]: https://pub.dartlang.org/packages/neoansi
[pub_img]: https://img.shields.io/pub/v/neoansi.svg
[gha_url]: https://github.com/neo-dart/neoansi/actions
[gha_img]: https://github.com/neo-dart/neoansi/workflows/Dart/badge.svg
[cov_url]: https://codecov.io/gh/neo-dart/neoansi
[cov_img]: https://codecov.io/gh/neo-dart/neoansi/branch/main/graph/badge.svg
[doc_url]: https://www.dartdocs.org/documentation/neoansi/latest
[doc_img]: https://img.shields.io/badge/Documentation-neoansi-blue.svg
[sty_url]: https://pub.dev/packages/neodart
[sty_img]: https://img.shields.io/badge/style-neodart-9cf.svg

This library provides minimal [ANSI escape sequences][ansi] and helpers for
working with [ANSI text terminals and terminal emulators][wiki], in which
escape characters and embedded values are interpreted as commands.

[ansi]: https://www.lihaoyi.com/post/BuildyourownCommandLinewithANSIescapecodes.html#16-colors
[wiki]: https://en.wikipedia.org/wiki/ANSI_escape_code

## Usage

```dart
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
```

## Contributing

**This package welcomes [new issues][issues] and [pull requests][fork].**

[issues]: https://github.com/neo-dart/neoansi/issues/new
[fork]: https://github.com/neo-dart/neouuid/fork

Changes or requests that do not match the following criteria will be rejected:

1. Common decency as described by the [Contributor Covenant][code-of-conduct].
2. Making this library brittle/extensible by other libraries.
3. Adding platform-specific functionality.
4. A somewhat arbitrary bar of "complexity", everything should be _easy to use_.

[code-of-conduct]: https://www.contributor-covenant.org/version/1/4/code-of-conduct/

## Resources

<!-- When adding resources, create a backup PDF and store in the doc/ folder -->

- [ANSI escape code][wiki] ([PDF][wiki-pdf])
- [Build your own Command Line with ANSI escape codes][ansi] ([PDF][ansi-pdf]).

[ansi-pdf]: doc/build-ansi-escape-codes.pdf
[wiki-pdf]: doc/wiki-ansi-escape.pdf

### Inspiration

Some inspiration/motivational sources elsewhere in pub (Dart) packages:

- [`ansicolor`](https://pub.dev/packages/ansicolor)
- [`ansi_escapes`](https://pub.dev/packages/ansi_escapes)
- [`ansi_styles`](https://pub.dev/packages/ansi_styles)
- [`dart_console`](https://pub.dev/packages/dart_console)

> **Note from Matan**: Many of these packages do an adequate job, but none of
> them had quite the API I wanted, so like many before them, this library was
> created. Use whatever makes the most sense to you!
