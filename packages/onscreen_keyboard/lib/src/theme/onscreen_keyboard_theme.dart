import 'package:flutter/widgets.dart';
import 'package:onscreen_keyboard/src/theme/onscreen_keyboard_theme_data.dart';

class OnscreenKeyboardTheme extends InheritedWidget {
  const OnscreenKeyboardTheme({
    required this.data,
    required super.child,
    super.key,
  });

  final OnscreenKeyboardThemeData data;

  @override
  bool updateShouldNotify(OnscreenKeyboardTheme oldWidget) =>
      data != oldWidget.data;

  static OnscreenKeyboardThemeData of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<OnscreenKeyboardTheme>()!
        .data;
  }
}
