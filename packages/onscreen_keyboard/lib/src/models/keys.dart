import 'package:flutter/widgets.dart';

sealed class OnscreenKeyboardKey {
  const OnscreenKeyboardKey({
    this.flex = _flex,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
  });

  const factory OnscreenKeyboardKey.text({
    required String primary,
    String? secondary,
    Widget? child,
    int flex,
    VoidCallback? onTap,
    VoidCallback? onTapDown,
    VoidCallback? onTapUp,
  }) = TextKey._;

  const factory OnscreenKeyboardKey.action({
    required String name,
    String? label,
    Widget? child,
    bool canHold,
    int flex,
    VoidCallback? onTap,
    VoidCallback? onTapDown,
    VoidCallback? onTapUp,
  }) = ActionKey._;

  static const _flex = 20;

  final int flex;
  final VoidCallback? onTap;
  final VoidCallback? onTapDown;
  final VoidCallback? onTapUp;
}

class TextKey extends OnscreenKeyboardKey {
  const TextKey._({
    required this.primary,
    this.secondary,
    this.child,
    super.flex,
    super.onTap,
    super.onTapDown,
    super.onTapUp,
  });

  final String primary;
  final String? secondary;
  final Widget? child;

  String getText({bool secondary = false}) =>
      secondary ? this.secondary ?? primary.toUpperCase() : primary;
}

class ActionKey extends OnscreenKeyboardKey {
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

  final String name;
  final String? label;
  final Widget? child;
  final bool canHold;
}
