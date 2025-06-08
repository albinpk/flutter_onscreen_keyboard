import 'package:onscreen_keyboard/src/models/keys.dart';

abstract class KeyboardLayout {
  const KeyboardLayout();

  abstract final List<KeyboardRow> rows;
}

class KeyboardRow {
  const KeyboardRow({required this.keys});

  final List<OnscreenKeyboardKey> keys;
}
