import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';
import 'package:flutter_onscreen_keyboard/src/constants/action_key_type.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('OnscreenKeyboard', () {
    testWidgets('should not be visible by default', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          builder: OnscreenKeyboard.builder(),
          home: const Scaffold(
            body: Text('Home'),
          ),
        ),
      );
      expect(find.byType(RawOnscreenKeyboard), findsNothing);
    });

    group('OnscreenKeyboardController', () {
      testWidgets(
        'controller should be available when using the builder',
        (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              builder: OnscreenKeyboard.builder(),
              home: const Scaffold(),
            ),
          );

          expect(
            OnscreenKeyboard.of(tester.element(find.byType(Scaffold))),
            isA<OnscreenKeyboardController>(),
          );
        },
      );

      testWidgets(
        'controller should be available when using the child param',
        (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              builder: (context, child) {
                return OnscreenKeyboard(child: child!);
              },
              home: const Scaffold(),
            ),
          );

          expect(
            OnscreenKeyboard.of(tester.element(find.byType(Scaffold))),
            isA<OnscreenKeyboardController>(),
          );
        },
      );

      testWidgets('open and close', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            builder: OnscreenKeyboard.builder(width: (_) => 200),
            home: const Scaffold(),
          ),
        );

        final controller = OnscreenKeyboard.of(
          tester.element(find.byType(Scaffold)),
        )..open();
        await tester.pumpAndSettle();
        expect(find.byType(RawOnscreenKeyboard), findsOneWidget);

        controller.close();
        await tester.pumpAndSettle();
        expect(find.byType(RawOnscreenKeyboard), findsNothing);
      });
    });

    group('raw key down listener', () {
      testWidgets(
        'should trigger onKeyDown when a key is pressed',
        (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              builder: OnscreenKeyboard.builder(width: (_) => 200),
              home: const Scaffold(),
            ),
          );

          final controller = OnscreenKeyboard.of(
            tester.element(find.byType(Scaffold)),
          )..open();

          await tester.pumpAndSettle();

          OnscreenKeyboardKey? key;
          controller.addRawKeyDownListener((k) => key = k);

          await tester.tap(find.text('a'));
          expect(key, isA<TextKey>().having((k) => k.primary, 'primary', 'a'));

          await tester.tap(find.text('b'));
          await tester.pump();
          expect(key, isA<TextKey>().having((k) => k.primary, 'primary', 'b'));

          await tester.tap(find.byIcon(Icons.keyboard_capslock_rounded));
          await tester.pump();
          expect(
            key,
            isA<ActionKey>().having(
              (k) => k.name,
              'name',
              ActionKeyType.capslock,
            ),
          );
        },
      );
    });

    group('text input', () {
      testWidgets(
        'should trigger onKeyDown when a key is pressed',
        (tester) async {
          final controller = TextEditingController();
          await tester.pumpWidget(
            MaterialApp(
              builder: OnscreenKeyboard.builder(width: (_) => 200),
              home: Scaffold(
                body: OnscreenKeyboardTextField(controller: controller),
              ),
            ),
          );

          await tester.tap(find.byType(OnscreenKeyboardTextField));
          await tester.pumpAndSettle();

          await tester.tap(find.text('a'));
          await tester.pump();
          expect(controller.text, 'a');

          await tester.tap(find.text('b'));
          await tester.pump();
          expect(controller.text, 'ab');

          await tester.tap(find.text('c'));
          await tester.pump();
          expect(controller.text, 'abc');

          await tester.tap(find.byIcon(Icons.backspace_outlined));
          await tester.pump();
          expect(controller.text, 'ab');
        },
      );
    });

    group('layout', () {
      testWidgets(
        'default layout on desktop platform',
        (tester) async {
          debugDefaultTargetPlatformOverride = TargetPlatform.windows;
          await tester.pumpWidget(
            MaterialApp(
              builder: OnscreenKeyboard.builder(width: (_) => 200),
              home: const Scaffold(),
            ),
          );

          OnscreenKeyboard.of(tester.element(find.byType(Scaffold))).open();
          await tester.pumpAndSettle();

          expect(
            tester
                .widget<RawOnscreenKeyboard>(find.byType(RawOnscreenKeyboard))
                .layout,
            isA<DesktopKeyboardLayout>(),
          );
          debugDefaultTargetPlatformOverride = null;
        },
      );
    });

    group('layout modes', () {
      testWidgets(
        'switchMode()',
        (tester) async {
          const modes = ['a', 'b', 'c'];
          await tester.pumpWidget(
            MaterialApp(
              home: const Scaffold(),
              builder: OnscreenKeyboard.builder(
                width: (_) => 200,
                layout: KeyboardLayout.custom(
                  aspectRatio: 1,
                  modes: {
                    for (final mode in modes)
                      mode: KeyboardMode(
                        rows: [
                          KeyboardRow(
                            keys: [
                              OnscreenKeyboardKey.text(
                                primary: mode.toUpperCase(),
                              ),
                            ],
                          ),
                        ],
                      ),
                  },
                ),
              ),
            ),
          );

          final controller = OnscreenKeyboard.of(
            tester.element(find.byType(Scaffold)),
          )..open();

          await tester.pumpAndSettle();

          // Should cycle through modes
          for (final mode in modes) {
            expect(find.text(mode.toUpperCase()), findsOneWidget);
            controller.switchMode();
            await tester.pumpAndSettle();
          }

          // Should cycle back to first mode
          expect(find.text(modes.first.toUpperCase()), findsOneWidget);
        },
      );

      testWidgets(
        'setModeNamed()',
        (tester) async {
          const modes = ['a', 'b', 'c'];
          await tester.pumpWidget(
            MaterialApp(
              home: const Scaffold(),
              builder: OnscreenKeyboard.builder(
                width: (_) => 200,
                layout: KeyboardLayout.custom(
                  aspectRatio: 1,
                  modes: {
                    for (final mode in modes)
                      mode: KeyboardMode(
                        rows: [
                          KeyboardRow(
                            keys: [
                              OnscreenKeyboardKey.text(
                                primary: mode.toUpperCase(),
                              ),
                            ],
                          ),
                        ],
                      ),
                  },
                ),
              ),
            ),
          );

          final controller = OnscreenKeyboard.of(
            tester.element(find.byType(Scaffold)),
          )..open();
          await tester.pumpAndSettle();

          expect(find.text('A'), findsOneWidget);

          controller.setModeNamed('c');
          await tester.pumpAndSettle();
          expect(find.text('C'), findsOneWidget);

          controller.setModeNamed('a');
          await tester.pumpAndSettle();
          expect(find.text('A'), findsOneWidget);
        },
      );
    });
  });
}
