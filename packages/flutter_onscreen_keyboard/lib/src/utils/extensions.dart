import 'dart:developer';

import 'package:flutter/foundation.dart';
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

/// Extension to easily log any value to the console.
///
/// For debugging purposes only.
extension LoggerExt<T> on T {
  /// Logs the value to the console with the given [name].
  @Deprecated('Should not used in production')
  T logger([String? name]) {
    if (kDebugMode) log(toString(), name: name ?? 'flutter_onscreen_keyboard');
    return this;
  }
}
