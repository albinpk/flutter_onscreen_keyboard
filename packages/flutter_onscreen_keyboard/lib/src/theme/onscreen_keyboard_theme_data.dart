import 'package:flutter/widgets.dart';

class OnscreenKeyboardThemeData {
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

  final Color? color;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  final EdgeInsetsGeometry margin;
  final TextKeyThemeData textKeyThemeData;
  final ActionKeyThemeData actionKeyThemeData;
}

class TextKeyThemeData {
  const TextKeyThemeData({
    this.decoration,
  });

  final BoxDecoration? decoration;
}

class ActionKeyThemeData {
  const ActionKeyThemeData({
    this.decoration,
  });

  final BoxDecoration? decoration;
}
