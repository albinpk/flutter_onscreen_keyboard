import 'package:flutter/material.dart';
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnscreenKeyboardTextField', () {
    testWidgets('should open keyboard on focus', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: OnscreenKeyboard.builder(width: (_) => 200),
          home: const Scaffold(body: OnscreenKeyboardTextField()),
        ),
      );

      expect(find.byType(RawOnscreenKeyboard), findsNothing);
      await tester.tap(find.byType(OnscreenKeyboardTextField));
      await tester.pumpAndSettle();
      expect(find.byType(RawOnscreenKeyboard), findsOneWidget);
    });

    testWidgets(
      'should not open keyboard on focus if enableOnscreenKeyboard is false',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            builder: OnscreenKeyboard.builder(width: (_) => 200),
            home: const Scaffold(
              body: OnscreenKeyboardTextField(enableOnscreenKeyboard: false),
            ),
          ),
        );

        expect(find.byType(RawOnscreenKeyboard), findsNothing);
        await tester.tap(find.byType(OnscreenKeyboardTextField));
        await tester.pumpAndSettle();
        expect(find.byType(RawOnscreenKeyboard), findsNothing);
      },
    );
  });
}
