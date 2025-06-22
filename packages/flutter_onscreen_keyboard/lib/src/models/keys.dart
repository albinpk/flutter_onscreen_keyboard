import 'package:flutter/widgets.dart';
import 'package:flutter_onscreen_keyboard/src/types.dart';

/// Base class for keys used in the on-screen keyboard.
///
/// This is a sealed class, which can either be a [TextKey] or an [ActionKey].
///
/// You can customize the visual size of each key using [flex],
/// and handle user interaction using [onTap], [onTapDown], and [onTapUp].
sealed class OnscreenKeyboardKey {
  /// Creates an [OnscreenKeyboardKey].
  const OnscreenKeyboardKey({
    this.flex = _flex,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
  });

  /// Creates a [TextKey], which represents a key with a printable character.
  ///
  /// [primary] is the main character.
  /// [secondary] is an optional alternate character (e.g., Shifted version).
  /// [child] can be used to override the visual of the key.
  const factory OnscreenKeyboardKey.text({
    required String primary,
    String? secondary,
    Widget? child,
    int flex,
    CallbackWithContext? onTap,
    CallbackWithContext? onTapDown,
    CallbackWithContext? onTapUp,
  }) = TextKey._;

  /// Creates an [ActionKey], which represents non-character keys
  /// such as "Enter", "Backspace", "Shift", etc.
  ///
  /// [name] is a unique identifier for the action.
  /// [label] is the visible text, and [child] is a custom widget to display.
  /// [canHold] indicates whether the key can be held down (e.g., CapsLock).
  const factory OnscreenKeyboardKey.action({
    required String name,
    String? label,
    Widget? child,
    bool canHold,
    int flex,
    CallbackWithContext? onTap,
    CallbackWithContext? onTapDown,
    CallbackWithContext? onTapUp,
  }) = ActionKey._;

  /// The default `flex` value for a key.
  static const _flex = 20;

  /// Determines how much space the key occupies within a [Row].
  ///
  /// Keys with a larger [flex] take up more space, and keys with a smaller
  /// value take up less space. The default is `20`.
  final int flex;

  /// Callback when the key is tapped (pressed and released).
  final CallbackWithContext? onTap;

  /// Callback when the key is pressed down.
  final CallbackWithContext? onTapDown;

  /// Callback when the key is released.
  final CallbackWithContext? onTapUp;
}

/// A key representing a text input character, such as letters,
/// digits, or symbols.
///
/// Common examples: `A`, `1`, `!`, `@`, etc.
class TextKey extends OnscreenKeyboardKey {
  /// Creates a [TextKey].
  const TextKey._({
    required this.primary,
    this.secondary,
    this.child,
    super.flex,
    super.onTap,
    super.onTapDown,
    super.onTapUp,
  });

  /// The primary character this key represents.
  final String primary;

  /// The optional secondary character (e.g., Shifted version).
  final String? secondary;

  /// A custom widget to display inside the key instead of plain text.
  final Widget? child;

  /// Returns the key’s text based on the [secondary] state.
  ///
  /// If [secondary] is true and a secondary value is provided, it returns that.
  /// If [secondary] is true and a secondary value is not provided,
  /// it returns uppercase version of [primary].
  /// Otherwise returns [primary].
  String getText({bool secondary = false}) =>
      secondary ? this.secondary ?? primary.toUpperCase() : primary;

  @override
  String toString() =>
      'TextKey('
      '"$primary", '
      'secondary: ${secondary != null ? '"$secondary"' : null})';
}

/// A key representing an action such as "Enter", "Backspace", or "Shift".
///
/// This key does not produce text input but rather triggers an action.
class ActionKey extends OnscreenKeyboardKey {
  /// Creates an [ActionKey].
  const ActionKey._({
    required this.name,
    this.label,
    this.child,
    this.canHold = false,
    super.flex,
    super.onTap,
    super.onTapDown,
    super.onTapUp,
  });

  /// The unique action name (e.g., "backspace", "enter", "shift").
  final String name;

  /// Optional visible label to show on the key.
  final String? label;

  /// Optional custom widget to render inside the key.
  final Widget? child;

  /// Whether the key can be held down for repeated action.
  final bool canHold;

  @override
  String toString() => 'ActionKey($name)';
}
