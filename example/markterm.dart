import 'package:neoansi/neoansi.dart';

/// A silly "terminal emulator" example that converst ANSI -> Markdown.
///
/// As-written, only **bold** font is supported/recognized.
void main() {
  final output = StringBuffer();
  final reader = AnsiReader(_AnsiToMarkdown(output));

  final input = StringBuffer();
  final writer = AnsiWriter.from(input);

  // Simulates an ANSI terminal being written to.
  writer
    ..setBold()
    ..write('Hello')
    ..clearBold()
    ..write(' World!');

  // Feed what was "written to" to our parser.
  reader.read(input.toString());

  // Prints: **Hello** World!
  print(output.toString());
}

class _AnsiToMarkdown extends AnsiListener {
  final StringSink _output;

  var _bold = false;

  _AnsiToMarkdown(this._output);

  @override
  void write(String text) {
    if (_bold) {
      _output
        ..write('**')
        ..write(text)
        ..write('**');
    } else {
      _output.write(text);
    }
  }

  @override
  void setBold() {
    _bold = true;
  }

  @override
  void clearBold() {
    _bold = false;
  }

  @override
  void resetStyles() {
    _bold = false;
  }
}
