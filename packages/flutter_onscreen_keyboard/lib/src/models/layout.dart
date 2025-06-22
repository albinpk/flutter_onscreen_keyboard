import 'package:flutter/widgets.dart';
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';

/// Abstract base class for defining keyboard layouts.
///
/// Extend this class to provide custom arrangements of keyboard rows and keys.
/// A layout is composed of multiple [KeyboardRow]s grouped under different
/// [modes] (e.g., letters, symbols, numbers), which allow dynamic layout
/// switching (commonly used in mobile keyboards).
///
/// You can use the [KeyboardLayout.custom] constructor to define your
/// own layout without needing to extend this class directly.
abstract class KeyboardLayout {
  /// Creates a keyboard layout.
  const KeyboardLayout();

  /// Creates a custom keyboard layout with multiple modes.
  ///
  /// [aspectRatio] controls the width-to-height ratio of the keyboard.
  ///
  /// [modes] is a map of layout modes (like 'letters', 'symbols', etc.)
  /// to their corresponding rows.
  const factory KeyboardLayout.custom({
    required double aspectRatio,
    required Map<String, List<KeyboardRow>> modes,
  }) = _CustomKeyboardLayout;

  /// {@template keyboardLayout.aspectRatio}
  /// The aspect ratio of the keyboard layout.
  ///
  /// For example, a 16:9 width:height aspect ratio would have a value of 16.0/9.0.
  /// {@endtemplate}
  double get aspectRatio;

  /// A map of layout modes to their rows.
  ///
  /// Each mode (e.g., `'letters'`, `'symbols'`, `'numbers'`) contains a list
  /// of rows that define what keys should be shown.
  ///
  /// This is especially useful for mobile keyboards where pressing keys like
  /// Shift or Symbol toggles the layout.
  Map<String, List<KeyboardRow>> get modes;
}

/// Represents a single row in a keyboard layout.
///
/// Each row contains a list of [OnscreenKeyboardKey]s
/// which will be rendered horizontally.
class KeyboardRow {
  /// Creates a keyboard row with a list of keys.
  ///
  /// The [keys] parameter defines the keys rendered in this row.
  ///
  /// Use [leading] and [trailing] widgets to add widgets at the start or end
  /// of the row (e.g., padding, arrows, labels).
  const KeyboardRow({
    required this.keys,
    this.leading,
    this.trailing,
  });

  /// The list of keys displayed in this row.
  final List<OnscreenKeyboardKey> keys;

  /// Optional widget shown at the beginning of the row.
  final Widget? leading;

  /// Optional widget shown at the end of the row.
  final Widget? trailing;
}

/// Internal implementation of a custom [KeyboardLayout].
class _CustomKeyboardLayout extends KeyboardLayout {
  const _CustomKeyboardLayout({
    required this.aspectRatio,
    required this.modes,
  });

  @override
  final double aspectRatio;

  @override
  final Map<String, List<KeyboardRow>> modes;
}
