import 'package:flutter/material.dart';
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';
import 'package:flutter_onscreen_keyboard/src/constants/action_key_type.dart';

/// Standard Kazakh (Cyrillic) desktop keyboard layout.
///
/// The layout follows the standard Kazakh keyboard arrangement based on ЙЦУКЕН
/// with all 9 additional Kazakh characters (`ә`, `і`, `ң`, `ғ`, `ү`, `ұ`, `қ`, `ө`, `һ`)
/// accessible via Shift on the number row (keys 1-9).
/// Includes a globe key mapped to [ActionKeyType.language] for quick language
/// toggling, positioned to the left of the space bar.
class DesktopKazakhKeyboardLayout extends KeyboardLayout {
  /// Creates a [DesktopKazakhKeyboardLayout] instance.
  const DesktopKazakhKeyboardLayout();

  @override
  double get aspectRatio => 5 / 2;

  @override
  Map<String, KeyboardMode> get modes => {
        'default': KeyboardMode(rows: _defaultMode),
      };

  List<KeyboardRow> get _defaultMode => [
        const KeyboardRow(
          keys: [
            OnscreenKeyboardKey.text(primary: 'ё', secondary: 'Ё'),
            OnscreenKeyboardKey.text(primary: '1', secondary: 'ә'),
            OnscreenKeyboardKey.text(primary: '2', secondary: 'і'),
            OnscreenKeyboardKey.text(primary: '3', secondary: 'ң'),
            OnscreenKeyboardKey.text(primary: '4', secondary: 'ғ'),
            OnscreenKeyboardKey.text(primary: '5', secondary: 'ү'),
            OnscreenKeyboardKey.text(primary: '6', secondary: 'ұ'),
            OnscreenKeyboardKey.text(primary: '7', secondary: 'қ'),
            OnscreenKeyboardKey.text(primary: '8', secondary: 'ө'),
            OnscreenKeyboardKey.text(primary: '9', secondary: 'һ'),
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
            ...['й', 'ц', 'у', 'к', 'е', 'н', 'г', 'ш', 'щ', 'з', 'х', 'ъ']
                .map((key) => OnscreenKeyboardKey.text(primary: key)),
            const OnscreenKeyboardKey.text(primary: r'\', secondary: '/'),
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
            ...['ф', 'ы', 'в', 'а', 'п', 'р', 'о', 'л', 'д', 'ж', 'э']
                .map((key) => OnscreenKeyboardKey.text(primary: key)),
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
            ...['я', 'ч', 'с', 'м', 'и', 'т', 'ь', 'б', 'ю']
                .map((key) => OnscreenKeyboardKey.text(primary: key)),
            const OnscreenKeyboardKey.text(primary: '.', secondary: ','),
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
