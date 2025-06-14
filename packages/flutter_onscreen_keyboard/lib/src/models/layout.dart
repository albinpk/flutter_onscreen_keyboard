import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';

/// Abstract base class for defining keyboard layouts.
///
/// Extend this class to provide custom arrangements of keyboard rows and keys.
/// A layout is composed of multiple [KeyboardRow]s, and each row contains
/// a list of [OnscreenKeyboardKey]s.
abstract class KeyboardLayout {
  /// Creates a keyboard layout.
  const KeyboardLayout();

  /// {@template keyboardLayout.aspectRatio}
  /// The aspect ratio of the keyboard layout.
  ///
  /// For example, a 16:9 width:height aspect ratio would have a value of 16.0/9.0.
  /// {@endtemplate}
  abstract final double aspectRatio;

  /// The rows of keys that define the layout structure.
  ///
  /// Each [KeyboardRow] represents a horizontal group of keys,
  /// which are rendered in order on the screen.
  abstract final List<KeyboardRow> rows;
}

/// Represents a single row in a keyboard layout.
///
/// Each row contains a list of [OnscreenKeyboardKey]s
/// which will be rendered horizontally.
class KeyboardRow {
  /// Creates a keyboard row with a list of keys.
  ///
  /// The [keys] parameter defines the sequence of keys in this row.
  const KeyboardRow({required this.keys});

  /// The keys in this row of the keyboard.
  final List<OnscreenKeyboardKey> keys;
}
