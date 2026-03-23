import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnscreenKeyboardKey', () {
    group('text key', () {
      test('toString()', () async {
        const key = OnscreenKeyboardKey.text(primary: 'a');
        expect(key.toString(), 'TextKey("a", secondary: null)');
      });

      test('toString() with secondary', () async {
        const key = OnscreenKeyboardKey.text(primary: 'a', secondary: 'A');
        expect(key.toString(), 'TextKey("a", secondary: "A")');
      });
    });

    group('action key', () {
      test('toString()', () async {
        const key = OnscreenKeyboardKey.action(name: 'backspace');
        expect(key.toString(), 'ActionKey(backspace)');
      });
    });
  });
}
