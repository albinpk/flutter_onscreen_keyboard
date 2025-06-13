import 'package:flutter/widgets.dart';
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';

/// An [InheritedWidget] that provides [OnscreenKeyboardThemeData] to
/// its descendants.
///
/// Use this widget to apply consistent theming to all onscreen keyboard
/// widgets within its subtree. You can access the theme data
/// using [OnscreenKeyboardTheme.of].
class OnscreenKeyboardTheme extends InheritedWidget {
  /// Creates an [OnscreenKeyboardTheme].
  ///
  /// The [data] parameter holds the theme configuration,
  /// and [child] is the subtree that will receive the theme.
  const OnscreenKeyboardTheme({
    required this.data,
    required super.child,
    super.key,
  });

  /// The theme data that will be propagated to all descendants.
  final OnscreenKeyboardThemeData data;

  @override
  bool updateShouldNotify(OnscreenKeyboardTheme oldWidget) =>
      data != oldWidget.data;

  /// Retrieves the nearest [OnscreenKeyboardThemeData] up the widget tree.
  ///
  /// This allows any descendant widget to access the keyboard theme data using:
  /// ```dart
  /// final theme = OnscreenKeyboardTheme.of(context);
  /// ```
  static OnscreenKeyboardThemeData of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<OnscreenKeyboardTheme>()!
        .data;
  }
}
