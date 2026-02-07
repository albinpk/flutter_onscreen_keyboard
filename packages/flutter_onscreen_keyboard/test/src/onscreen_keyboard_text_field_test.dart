import 'package:flutter/material.dart';
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';
import 'package:flutter_onscreen_keyboard/src/onscreen_keyboard.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnscreenKeyboardTextField', () {
    late TextEditingController controller;
    late FocusNode focusNode;

    setUp(() {
      controller = TextEditingController();
      focusNode = FocusNode();
    });

    tearDown(() {
      controller.dispose();
      focusNode.dispose();
    });

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
      'by default keyboardType should be "TextInputType.none"',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            builder: OnscreenKeyboard.builder(width: (_) => 200),
            home: const Scaffold(
              body: OnscreenKeyboardTextField(
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),
        );
        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.keyboardType, TextInputType.none);
      },
    );

    testWidgets(
      'keyboardType should be applied when "enableOnscreenKeyboard=false"',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            builder: OnscreenKeyboard.builder(width: (_) => 200),
            home: const Scaffold(
              body: OnscreenKeyboardTextField(
                enableOnscreenKeyboard: false,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
          ),
        );
        final textField = tester.widget<TextField>(find.byType(TextField));
        expect(textField.keyboardType, TextInputType.emailAddress);
      },
    );

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

    testWidgets(
      'properties of OnscreenKeyboardFieldState',
      (tester) async {
        final key = GlobalKey();
        await tester.pumpWidget(
          MaterialApp(
            builder: OnscreenKeyboard.builder(width: (_) => 200),
            home: Scaffold(
              body: OnscreenKeyboardTextField(
                key: key,
                controller: controller,
                focusNode: focusNode,
                maxLines: 3,
              ),
            ),
          ),
        );

        final state = key.currentState! as OnscreenKeyboardFieldState;
        expect(state.controller, controller);
        expect(state.focusNode, focusNode);
        expect(state.maxLines, 3);
      },
    );
    testWidgets(
      'should switch to defaultMode when focused',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            builder: OnscreenKeyboard.builder(
              width: (_) => 200,
              layout: const MobileKeyboardLayout(),
            ),
            home: const Scaffold(
              body: OnscreenKeyboardTextField(
                defaultMode: 'symbols',
              ),
            ),
          ),
        );

        await tester.tap(find.byType(OnscreenKeyboardTextField));
        await tester.pumpAndSettle();

        // Check if the keyboard is in symbols mode by finding a key unique to that mode
        // '@' is the primary character of a key in symbols mode, but secondary in alphabets mode
        expect(find.text('@'), findsOneWidget);
        // 'q' is in the alphabets mode, so it should not be found
        expect(find.text('q'), findsNothing);
      },
    );
  });
}
