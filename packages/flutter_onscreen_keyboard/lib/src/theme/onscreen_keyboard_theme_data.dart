import 'package:flutter/widgets.dart';
import 'package:flutter_onscreen_keyboard/src/models/keys.dart';

/// Defines the visual styling for the onscreen keyboard widget.
///
/// This class allows full customization of the keyboard’s appearance,
/// including colors, borders, padding, and specific styling for
/// text and action keys.
class OnscreenKeyboardThemeData {
  /// Creates an instance of [OnscreenKeyboardThemeData].
  const OnscreenKeyboardThemeData({
    this.color,
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.gradient,
    this.margin = const EdgeInsets.all(12),
    this.textKeyThemeData = const TextKeyThemeData(),
    this.actionKeyThemeData = const ActionKeyThemeData(),
  });

  /// The background color of the keyboard.
  final Color? color;

  /// The border style of the keyboard.
  final BoxBorder? border;

  /// The border radius of the keyboard.
  final BorderRadiusGeometry? borderRadius;

  /// The list of box shadows applied to the keyboard container.
  final List<BoxShadow>? boxShadow;

  /// The background gradient of the keyboard.
  final Gradient? gradient;

  /// The outer margin around the keyboard. Defaults to `EdgeInsets.all(12)`.
  final EdgeInsetsGeometry margin;

  /// Theme data for styling individual text keys (e.g., A-Z, 0-9, symbols).
  final TextKeyThemeData textKeyThemeData;

  /// Theme data for styling action keys (e.g., Enter, Backspace, Shift).
  final ActionKeyThemeData actionKeyThemeData;
}

/// Theme customization for [TextKey] widgets.
///
/// Use this class to customize the appearance of alphanumeric and symbol keys.
class TextKeyThemeData {
  /// Creates an instance of [TextKeyThemeData].
  const TextKeyThemeData({
    this.decoration,
  });

  /// The [BoxDecoration] applied to each text key.
  final BoxDecoration? decoration;
}

/// Theme customization for [ActionKey] widgets.
///
/// Use this class to customize the appearance of functional keys
/// like Enter, Backspace, Tab, Shift, etc.
class ActionKeyThemeData {
  /// Creates an instance of [ActionKeyThemeData].
  const ActionKeyThemeData({
    this.decoration,
  });

  /// The [BoxDecoration] applied to each action key.
  final BoxDecoration? decoration;
}
