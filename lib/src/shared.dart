part of '/neoansi.dart';

/// A generic interface with typed methods for known ANSI escape codes.
///
/// To implement every method (recommended): `implements AnsiListener`.
///
/// To implement some methods you care about: `extends AnsiListener`:
/// ```
/// class MyListener extends AnsiListener {
///   @override
///   void setBold() {
///     /* ... */
///   }
///
///   @override
///   void clearBold() {
///     /* ... */
///   }
/// }
/// ```
abstract class AnsiListener {
  // ignore: public_member_api_docs
  const AnsiListener();

  /// Writes a non-escape coded [text].
  void write(String text) {}

  /// Clears the entire output screen.
  void clearScreen() {}

  /// Clears the entire output screen _before_ the cursor location.
  void clearScreenBefore() {}

  /// Clears the entire output screen _after_ the cursor location.
  void clearScreenAfter() {}

  /// Clears the current cline.
  void clearLine() {}

  /// Clears the current line _before_ the cursor location.
  void clearLineBefore() {}

  /// Clears the current line _after_ the cursor location.
  void clearLineAfter() {}

  /// Resets all styling to the default.
  void resetStyles() {}

  /// Sets subsequent text's foreground as a 1-bit [color].
  void setForegroundColor1(Ansi1BitColor color, {bool bright = false}) {}

  /// Sets subequent text's background as a 1-bit [color].
  void setBackgroundColor1(Ansi1BitColor color, {bool bright = false}) {}

  /// Sets subsequent text's foreground as a 8-bit [color].
  void setForegroundColor8(Ansi8BitColor color) {}

  /// Sets subsequent text's background as a 8-bit [color].
  void setBackgroundColor8(Ansi8BitColor color) {}

  /// Sets subsequent text's foreground as a 24-bit [color].
  ///
  /// **NOTE**: The 8-bit alpha channel ([Color.alpha]) is ignored.
  void setForegroundColor24(Color color) {}

  /// Sets subsequent text's background as a 24-bit [color].
  ///
  /// **NOTE**: The 8-bit alpha channel ([Color.alpha]) is ignored.
  void setBackgroundColor24(Color color) {}

  /// Sets text decoration style to include **bold**.
  void setBold() {}

  /// Sets text decoration style to include <u>underlined</u>.
  void setUnderlined() {}

  /// Sets text decoration style to include _double_ <u>underlined</u>.
  void setDoubleUnderlined() {}

  /// Clears text decoration style to exclude **bold**.
  void clearBold() {}

  /// Clears text decoration style to exclude single/double <u>underlined</u>.
  void clearUnderlined() {}

  /// Reverses the foreground and background colors.
  void reverseColors() {}

  /// Moves the cursor up [rows].
  void moveCursorUp([int rows = 1]) {}

  /// Moves the cursor down [rows].
  void moveCursorDown([int rows = 1]) {}

  /// Moves the cursor right [columns].
  void moveCursorRight([int columns = 1]) {}

  /// Moves the cursor left [columns].
  void moveCursorLeft([int columns = 1]) {}

  /// Moves the cursor to the beginning of the next [lines].
  void moveCursorNextLine([int lines = 1]) {}

  /// Moves the cursor to the beginning of the previous [lines].
  void moveCursorPreviousLine([int lines = 1]) {}

  /// Moves the cursor to [column].
  void setCursorX(int column) {}

  /// Moves the cursor to [row].
  void setCursorY(int row) {}

  /// Saves the current cursor position.
  void saveCursor() {}

  /// Restores the current cursor position from a previously saved position.
  void restoreCursor() {}

  /// Shows the cursor.
  void showCursor() {}

  /// Hides the cursor.
  void hideCursor() {}
}
