import 'package:flutter/widgets.dart';
import 'package:onscreen_keyboard/src/widgets/onscreen_keyboard_theme.dart';

extension ContextExt on BuildContext {
  OnscreenKeyboardThemeData get theme => OnscreenKeyboardTheme.of(this);
}
