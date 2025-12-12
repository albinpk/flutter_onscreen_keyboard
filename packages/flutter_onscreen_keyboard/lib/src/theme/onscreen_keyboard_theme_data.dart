// ignore_for_file: sort_constructors_first

import 'package:flutter/material.dart';
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
    this.margin,
    this.padding,
    this.textKeyThemeData = const TextKeyThemeData(),
    this.actionKeyThemeData = const ActionKeyThemeData(),
    this.controlBarColor,
    this.useSafeArea,
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

  /// The outer margin around the keyboard container.
  final EdgeInsetsGeometry? margin;

  /// The inner padding of the keyboard container.
  final EdgeInsetsGeometry? padding;

  /// Theme data for styling individual text keys (e.g., A-Z, 0-9, symbols).
  final TextKeyThemeData textKeyThemeData;

  /// Theme data for styling action keys (e.g., Enter, Backspace, Shift).
  final ActionKeyThemeData actionKeyThemeData;

  /// The background color of the control bar.
  final Color? controlBarColor;

  /// Whether to wrap the keyboard in a [SafeArea] widget. Defaults to `true`.
  final bool? useSafeArea;

  /// Copies the current [OnscreenKeyboardThemeData] with the provided changes.
  OnscreenKeyboardThemeData copyWith({
    Color? color,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    TextKeyThemeData? textKeyThemeData,
    ActionKeyThemeData? actionKeyThemeData,
    Color? controlBarColor,
    bool? useSafeArea,
  }) {
    return OnscreenKeyboardThemeData(
      color: color ?? this.color,
      border: border ?? this.border,
      borderRadius: borderRadius ?? this.borderRadius,
      boxShadow: boxShadow ?? this.boxShadow,
      gradient: gradient ?? this.gradient,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      textKeyThemeData: textKeyThemeData ?? this.textKeyThemeData,
      actionKeyThemeData: actionKeyThemeData ?? this.actionKeyThemeData,
      controlBarColor: controlBarColor ?? this.controlBarColor,
      useSafeArea: useSafeArea ?? this.useSafeArea,
    );
  }

  // predefined themes

  /// Google Gboard theme.
  factory OnscreenKeyboardThemeData.gBoard({Color? primary}) {
    final color = primary ?? Colors.blue;
    return OnscreenKeyboardThemeData(
      color: Color.lerp(color, Colors.white, 0.8),
      controlBarColor: Color.lerp(color, Colors.white, 0.8),
      padding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 14),
      boxShadow: [],
      border: const Border.fromBorderSide(BorderSide.none),
      borderRadius: BorderRadius.zero,
      textKeyThemeData: TextKeyThemeData(
        backgroundColor: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
        borderRadius: BorderRadius.circular(6),
      ),
      actionKeyThemeData: ActionKeyThemeData(
        backgroundColor: Color.lerp(color, Colors.white, 0.5),
        pressedBackgroundColor: color,
        margin: const EdgeInsets.symmetric(
          horizontal: 2,
          vertical: 4,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }

  /// iOS theme data.
  factory OnscreenKeyboardThemeData.ios() {
    return OnscreenKeyboardThemeData(
      color: const Color(0xFFD3D3D3),
      controlBarColor: const Color(0xFFD3D3D3),
      padding: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 14),
      boxShadow: [],
      border: const Border.fromBorderSide(BorderSide.none),
      borderRadius: BorderRadius.zero,
      textKeyThemeData: TextKeyThemeData(
        backgroundColor: Colors.white,
        boxShadow: [
          const BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 0.2,
            color: Colors.black45,
          ),
        ],
        margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
        borderRadius: BorderRadius.circular(6),
      ),
      actionKeyThemeData: ActionKeyThemeData(
        backgroundColor: const Color(0xFFADADAD),
        boxShadow: [
          const BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 0.2,
            color: Colors.black45,
          ),
        ],
        margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

/// Base class for customizing the visual appearance and layout of keys.
///
/// This abstract class defines common styling properties shared by both
/// [TextKeyThemeData] and [ActionKeyThemeData]. Use it to control padding,
/// margins, colors, borders, and other visual aspects of key widgets.
///
/// See also:
/// - [TextKeyThemeData] for styling alphanumeric and symbol keys.
/// - [ActionKeyThemeData] for styling functional keys like Enter, Tab, etc.
abstract class KeyThemeData {
  /// Creates a base key theme configuration.
  const KeyThemeData({
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

  /// Copies the current [TextKeyThemeData] with the provided changes.
  TextKeyThemeData copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    bool? fitChild,
    BorderRadiusGeometry? borderRadius,
    BoxBorder? border,
    double? iconSize,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    TextStyle? textStyle,
  }) {
    return TextKeyThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      fitChild: fitChild ?? this.fitChild,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      iconSize: iconSize ?? this.iconSize,
      boxShadow: boxShadow ?? this.boxShadow,
      gradient: gradient ?? this.gradient,
      textStyle: textStyle ?? this.textStyle,
    );
  }
}

/// Theme customization for [ActionKey] widgets.
class ActionKeyThemeData extends KeyThemeData {
  /// Creates an instance of [ActionKeyThemeData].
  const ActionKeyThemeData({
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

  /// Copies the current [ActionKeyThemeData] with the provided changes.
  ActionKeyThemeData copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    bool? fitChild,
    BorderRadiusGeometry? borderRadius,
    BoxBorder? border,
    double? iconSize,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    Color? pressedBackgroundColor,
    Color? pressedForegroundColor,
  }) {
    return ActionKeyThemeData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      fitChild: fitChild ?? this.fitChild,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      iconSize: iconSize ?? this.iconSize,
      boxShadow: boxShadow ?? this.boxShadow,
      gradient: gradient ?? this.gradient,
      pressedBackgroundColor:
          pressedBackgroundColor ?? this.pressedBackgroundColor,
      pressedForegroundColor:
          pressedForegroundColor ?? this.pressedForegroundColor,
    );
  }
}
