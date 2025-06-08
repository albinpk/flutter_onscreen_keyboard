import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';

abstract class KeyboardLayout {
  const KeyboardLayout();

  abstract final List<KeyboardRow> rows;
}

class KeyboardRow {
  const KeyboardRow({required this.keys});

  final List<OnscreenKeyboardKey> keys;
}
