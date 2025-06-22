import 'package:flutter/material.dart';
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';
import 'package:flutter_onscreen_keyboard/src/constants/action_key_type.dart';
import 'package:flutter_onscreen_keyboard/src/utils/extensions.dart';

/// A predefined [KeyboardLayout] implementation optimized for mobile devices.
///
/// This layout features a compact design with support for multiple input modes,
/// including alphabets and symbols. It handles dynamic layout switching
/// (e.g., switching between letters and symbols) using a
/// `mode_switch` action key.
class MobileKeyboardLayout extends KeyboardLayout {
  /// Creates an instance of [MobileKeyboardLayout].
  const MobileKeyboardLayout();

  @override
  double get aspectRatio => 4 / 3;

  @override
  Map<String, List<KeyboardRow>> get modes {
    return {
      'alphabets': _alphabetsMode,
      'symbols': _symbolsMode,
    };
  }

  /// Default alphabetic keyboard layout with support for symbol alternates.
  List<KeyboardRow> get _alphabetsMode => [
    _buildRowWithSecondary([
      ('1', '!'),
      ('2', '@'),
      ('3', '#'),
      ('4', r'$'),
      ('5', '%'),
      ('6', '^'),
      ('7', '&'),
      ('8', '*'),
      ('9', '('),
      ('0', ')'),
    ]),

    _buildRow(['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p']),

    KeyboardRow(
      leading: const Expanded(flex: 10, child: SizedBox.shrink()),
      keys: [
        'a',
        's',
        'd',
        'f',
        'g',
        'h',
        'j',
        'k',
        'l',
      ].map(_buildKey).toList(),
      trailing: const Expanded(flex: 10, child: SizedBox.shrink()),
    ),

    KeyboardRow(
      keys: [
        const OnscreenKeyboardKey.action(
          name: ActionKeyType.capslock,
          child: Icon(Icons.keyboard_capslock_rounded),
          flex: 30,
          canHold: true,
        ),
        ...['z', 'x', 'c', 'v', 'b', 'n', 'm'].map(_buildKey),
        const OnscreenKeyboardKey.action(
          name: ActionKeyType.backspace,
          child: Icon(Icons.backspace_outlined),
          flex: 30,
        ),
      ],
    ),

    KeyboardRow(
      keys: [
        OnscreenKeyboardKey.action(
          name: 'mode_switch',
          child: const Icon(Icons.swap_horiz_rounded),
          onTap: (context) => context.controller.switchMode(),
          flex: 30,
        ),
        const OnscreenKeyboardKey.text(primary: ','),
        const OnscreenKeyboardKey.text(
          primary: ' ',
          child: Icon(Icons.space_bar_rounded),
          flex: 20 * 5,
        ),
        const OnscreenKeyboardKey.text(primary: '.'),
        const OnscreenKeyboardKey.action(
          name: ActionKeyType.enter,
          child: Icon(Icons.keyboard_return_rounded),
          flex: 30,
        ),
      ],
    ),
  ];

  /// Symbol keyboard layout with alternate characters.
  List<KeyboardRow> get _symbolsMode => [
    ...[
      [
        ('1', '~'),
        ('2', '`'),
        ('3', '|'),
        ('4', '•'),
        ('5', '√'),
        ('6', 'π'),
        ('7', '÷'),
        ('8', '×'),
        ('9', '§'),
        ('0', '∆'),
      ],
      [
        ('@', '£'),
        ('#', '¢'),
        (r'$', '€'),
        ('_', '¥'),
        ('&', '^'),
        ('-', '°'),
        ('+', '='),
        ('(', '{'),
        (')', '}'),
        ('/', r'\'),
      ],
    ].map(_buildRowWithSecondary),

    KeyboardRow(
      keys: [
        const OnscreenKeyboardKey.action(
          name: ActionKeyType.capslock,
          child: Icon(Icons.keyboard_capslock_rounded),
          flex: 30,
          canHold: true,
        ),
        ...[
          ('*', '%'),
          ('"', '©'),
          ("'", '®'),
          (':', '™'),
          (';', '✓'),
          ('!', '['),
          ('?', ']'),
        ].map(_buildKeyWithSecondary),
        const OnscreenKeyboardKey.action(
          name: ActionKeyType.backspace,
          child: Icon(Icons.backspace_outlined),
          flex: 30,
        ),
      ],
    ),

    KeyboardRow(
      keys: [
        OnscreenKeyboardKey.action(
          name: 'mode_switch',
          child: const Icon(Icons.swap_horiz_rounded),
          onTap: (context) => context.controller.switchMode(),
          flex: 30,
        ),
        const OnscreenKeyboardKey.text(primary: ',', secondary: '<'),
        const OnscreenKeyboardKey.text(
          primary: ' ',
          child: Icon(Icons.space_bar_rounded),
          flex: 20 * 5,
        ),
        const OnscreenKeyboardKey.text(primary: '.', secondary: '>'),
        const OnscreenKeyboardKey.action(
          name: ActionKeyType.enter,
          child: Icon(Icons.keyboard_return_rounded),
          flex: 30,
        ),
      ],
    ),
  ];

  /// Creates a basic text key from a single character.
  OnscreenKeyboardKey _buildKey(String key) {
    return OnscreenKeyboardKey.text(primary: key);
  }

  /// Creates a row of text keys from a list of characters.
  KeyboardRow _buildRow(List<String> keys) {
    return KeyboardRow(keys: keys.map(_buildKey).toList());
  }

  /// Creates a text key with secondary input (e.g., shift state).
  OnscreenKeyboardKey _buildKeyWithSecondary((String, String) key) {
    return OnscreenKeyboardKey.text(primary: key.$1, secondary: key.$2);
  }

  /// Creates a row of text keys with primary and secondary characters.
  KeyboardRow _buildRowWithSecondary(List<(String, String)> keys) {
    return KeyboardRow(keys: keys.map(_buildKeyWithSecondary).toList());
  }
}
