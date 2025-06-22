import 'package:flutter_onscreen_keyboard/src/models/keys.dart';

/// Defines action key type constants used in [ActionKey] widgets.
///
/// These strings are used to uniquely identify action buttons
/// such as "backspace", "enter", and "shift" within the keyboard logic.
abstract class ActionKeyType {
  /// Identifier for the Backspace or Delete key.
  static const backspace = 'backspace';

  /// Identifier for the Tab key.
  static const tab = 'tab';

  /// Identifier for the Caps Lock key.
  static const capslock = 'capslock';

  /// Identifier for the Enter or Return key.
  static const enter = 'enter';

  /// Identifier for the Shift key.
  static const shift = 'shift';
}
