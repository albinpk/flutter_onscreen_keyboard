import 'package:flutter/widgets.dart';
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';
import 'package:flutter_onscreen_keyboard/src/theme/onscreen_keyboard_theme.dart';

/// Extension on [BuildContext] to simplify access to
/// [OnscreenKeyboardThemeData].
extension ContextExt on BuildContext {
  /// Returns the [OnscreenKeyboardThemeData] from the nearest
  /// [OnscreenKeyboardTheme] ancestor.
  OnscreenKeyboardThemeData get theme => OnscreenKeyboardTheme.of(this);
}

/// Extension on [Color] to easily adjust opacity.
extension ColorExt on Color {
  /// Returns a new color with the given [alpha] applied.
  ///
  /// Defaults to 0.5 opacity.
  Color fade([double alpha = 0.5]) => withValues(alpha: alpha);
}
