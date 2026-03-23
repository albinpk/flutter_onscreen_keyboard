import 'package:flutter/material.dart';
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnscreenKeyboardThemeData', () {
    test('copyWith', () async {
      const themeData = OnscreenKeyboardThemeData();
      expect(themeData.color, isNull);
      expect(themeData.copyWith(color: Colors.red).color, Colors.red);
    });

    group('TextKeyThemeData', () {
      test('copyWith', () async {
        const themeData = TextKeyThemeData();
        expect(themeData.backgroundColor, isNull);
        expect(
          themeData.copyWith(backgroundColor: Colors.red).backgroundColor,
          Colors.red,
        );
      });
    });

    group('ActionKeyThemeData', () {
      test('copyWith', () async {
        const themeData = ActionKeyThemeData();
        expect(themeData.backgroundColor, isNull);
        expect(
          themeData.copyWith(backgroundColor: Colors.red).backgroundColor,
          Colors.red,
        );
      });
    });
  });
}
