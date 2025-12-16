import 'package:flutter/material.dart';
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';
import 'package:flutter_onscreen_keyboard/src/constants/action_key_type.dart';

/// Standard English desktop keyboard layout (QWERTY).
///
/// This layout mirrors the common Windows/macOS hardware layout.
/// Includes a globe key mapped to [ActionKeyType.language] for quick language
/// toggling, positioned to the left of the space bar.
class DesktopEnglishKeyboardLayout extends KeyboardLayout {
  /// Creates a [DesktopEnglishKeyboardLayout] instance.
  const DesktopEnglishKeyboardLayout();

  @override
  double get aspectRatio => 5 / 2;

  @override
  Map<String, KeyboardMode> get modes => {
        'default': KeyboardMode(rows: _defaultMode),
      };

  List<KeyboardRow> get _defaultMode => [
        const KeyboardRow(
          keys: [
            OnscreenKeyboardKey.text(primary: '`', secondary: '~'),
            OnscreenKeyboardKey.text(primary: '1', secondary: '!'),
            OnscreenKeyboardKey.text(primary: '2', secondary: '@'),
            OnscreenKeyboardKey.text(primary: '3', secondary: '#'),
            OnscreenKeyboardKey.text(primary: '4', secondary: r'$'),
            OnscreenKeyboardKey.text(primary: '5', secondary: '%'),
            OnscreenKeyboardKey.text(primary: '6', secondary: '^'),
            OnscreenKeyboardKey.text(primary: '7', secondary: '&'),
            OnscreenKeyboardKey.text(primary: '8', secondary: '*'),
            OnscreenKeyboardKey.text(primary: '9', secondary: '('),
            OnscreenKeyboardKey.text(primary: '0', secondary: ')'),
            OnscreenKeyboardKey.text(primary: '-', secondary: '_'),
            OnscreenKeyboardKey.text(primary: '=', secondary: '+'),
            OnscreenKeyboardKey.action(
              name: ActionKeyType.backspace,
              child: Icon(Icons.backspace_outlined),
              flex: 25,
            ),
          ],
        ),
        KeyboardRow(
          keys: [
            const OnscreenKeyboardKey.action(
              name: ActionKeyType.tab,
              child: Icon(Icons.keyboard_tab_rounded),
              flex: 25,
            ),
            ...['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p']
                .map((key) => OnscreenKeyboardKey.text(primary: key)),
            const OnscreenKeyboardKey.text(primary: '[', secondary: '{'),
            const OnscreenKeyboardKey.text(primary: ']', secondary: '}'),
            const OnscreenKeyboardKey.text(primary: r'\', secondary: '|'),
          ],
        ),
        KeyboardRow(
          keys: [
            const OnscreenKeyboardKey.action(
              name: ActionKeyType.capslock,
              child: Icon(Icons.keyboard_capslock_rounded),
              flex: 30,
              canHold: true,
            ),
            ...['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l']
                .map((key) => OnscreenKeyboardKey.text(primary: key)),
            const OnscreenKeyboardKey.text(primary: ';', secondary: ':'),
            const OnscreenKeyboardKey.text(primary: "'", secondary: '"'),
            const OnscreenKeyboardKey.action(
              name: ActionKeyType.enter,
              child: Icon(Icons.keyboard_return_rounded),
              flex: 30,
            ),
          ],
        ),
        KeyboardRow(
          keys: [
            const OnscreenKeyboardKey.action(
              name: ActionKeyType.shift,
              child: Icon(Icons.arrow_upward_rounded),
              flex: 35,
            ),
            ...['z', 'x', 'c', 'v', 'b', 'n', 'm']
                .map((key) => OnscreenKeyboardKey.text(primary: key)),
            const OnscreenKeyboardKey.text(primary: ',', secondary: '<'),
            const OnscreenKeyboardKey.text(primary: '.', secondary: '>'),
            const OnscreenKeyboardKey.text(primary: '/', secondary: '?'),
            const OnscreenKeyboardKey.action(
              name: ActionKeyType.shift,
              child: Icon(Icons.arrow_upward_rounded),
              flex: 35,
            ),
          ],
        ),
        const KeyboardRow(
          keys: [
            OnscreenKeyboardKey.action(
              name: ActionKeyType.language,
              child: Icon(Icons.language_rounded),
              flex: 25,
            ),
            OnscreenKeyboardKey.text(
              primary: ' ',
              child: Icon(Icons.space_bar_rounded),
              flex: 120,
            ),
          ],
        ),
      ];
}
