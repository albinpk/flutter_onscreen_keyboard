import 'package:flutter/widgets.dart';
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';
import 'package:flutter_onscreen_keyboard/src/theme/onscreen_keyboard_theme.dart';

extension ContextExt on BuildContext {
  OnscreenKeyboardThemeData get theme => OnscreenKeyboardTheme.of(this);
}

extension ColorExt on Color {
  Color fade([double alpha = 0.5]) => withValues(alpha: alpha);
}
