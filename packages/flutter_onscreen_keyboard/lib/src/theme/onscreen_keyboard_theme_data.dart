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

/// Base class for customizing the visual appearance and layout of keys.
///
/// This abstract class defines common styling properties shared by both
/// [TextKeyThemeData] and [ActionKeyThemeData]. Use it to control padding,
/// margins, colors, borders, and other visual aspects of key widgets.
///
/// If [decoration] is provided, it overrides most of the other styling
/// properties. However, using the more granular individual fields is preferred
/// for consistency and flexibility.
///
/// See also:
/// - [TextKeyThemeData] for styling alphanumeric and symbol keys.
/// - [ActionKeyThemeData] for styling functional keys like Enter, Tab, etc.
abstract class KeyThemeData {
  /// Creates a base key theme configuration.
  const KeyThemeData({
    @Deprecated('Use individual styling properties instead') this.decoration,
    this.backgroundColor,
    this.foregroundColor,
    this.margin,
    this.padding,
    this.fitChild = true,
    this.borderRadius,
    this.border,
    this.iconSize,
    this.boxShadow,
    this.gradient,
  });

  /// A complete [BoxDecoration] applied directly to the key background.
  ///
  /// **Deprecated**: Prefer using the more specific properties like
  /// [backgroundColor], [border], and [gradient] for better flexibility.
  @Deprecated('Use individual styling properties instead')
  final BoxDecoration? decoration;

  /// Background color of the key when not pressed.
  final Color? backgroundColor;

  /// Text or icon color of the key when not pressed.
  final Color? foregroundColor;

  /// Outer margin around the key.
  final EdgeInsetsGeometry? margin;

  /// Inner padding inside the key.
  final EdgeInsetsGeometry? padding;

  /// Whether the child widget should shrink to fit the available space.
  ///
  /// Defaults to `true`.
  final bool fitChild;

  /// Border radius to round the corners of the key.
  final BorderRadiusGeometry? borderRadius;

  /// Border applied to the key.
  final BoxBorder? border;

  /// Icon size used inside the key, if applicable.
  final double? iconSize;

  /// A list of shadows to apply behind the key.
  final List<BoxShadow>? boxShadow;

  /// A gradient to use as the key’s background.
  ///
  /// If provided, this takes precedence over [backgroundColor].
  final Gradient? gradient;
}

/// Theme customization for [TextKey] widgets.
class TextKeyThemeData extends KeyThemeData {
  /// Creates an instance of [TextKeyThemeData].
  const TextKeyThemeData({
    @Deprecated('Use individual styling properties instead') super.decoration,
    super.backgroundColor,
    super.foregroundColor,
    super.margin,
    super.padding,
    super.fitChild = true,
    super.borderRadius,
    super.border,
    super.iconSize,
    super.boxShadow,
    super.gradient,
    this.textStyle,
  });

  /// The text style used for rendering key labels.
  final TextStyle? textStyle;
}

/// Theme customization for [ActionKey] widgets.
class ActionKeyThemeData extends KeyThemeData {
  /// Creates an instance of [ActionKeyThemeData].
  const ActionKeyThemeData({
    @Deprecated('Use individual styling properties instead') super.decoration,
    super.backgroundColor,
    this.pressedBackgroundColor,
    super.foregroundColor,
    this.pressedForegroundColor,
    super.margin,
    super.padding,
    super.fitChild = true,
    super.borderRadius,
    super.border,
    super.iconSize,
    super.boxShadow,
    super.gradient,
  });

  /// Background color of the key when pressed.
  final Color? pressedBackgroundColor;

  /// Text or icon color of the key when pressed.
  final Color? pressedForegroundColor;
}
