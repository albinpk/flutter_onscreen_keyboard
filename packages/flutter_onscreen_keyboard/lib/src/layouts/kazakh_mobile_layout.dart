import 'package:flutter/material.dart';
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';
import 'package:flutter_onscreen_keyboard/src/constants/action_key_type.dart';
import 'package:flutter_onscreen_keyboard/src/utils/extensions.dart';

/// A predefined [KeyboardLayout] implementation optimized for mobile devices
/// with Kazakh keyboard layout.
///
/// This layout features a compact design with support for multiple input modes,
/// including alphabets (with 9 additional Kazakh letters: ә, і, ң, ғ, ү, ұ, қ, ө, һ
/// accessible via Shift on keys 1-9) and symbols.
/// It handles dynamic layout switching (e.g., switching between letters and symbols)
/// using a `mode_switch` action key.
class KazakhMobileKeyboardLayout extends KeyboardLayout {
  /// Creates an instance of [KazakhMobileKeyboardLayout].
  const KazakhMobileKeyboardLayout();

  @override
  double get aspectRatio => 4 / 3;

  @override
  Map<String, KeyboardMode> get modes {
    return {
      'alphabets': KeyboardMode(rows: _alphabetsMode),
      'symbols': KeyboardMode(rows: _symbolsMode, verticalSpacing: 20),
      'emojis': KeyboardMode(
        rows: _emojisMode,
        theme: (context) {
          final theme = context.theme;
          return theme.copyWith(
            actionKeyThemeData: theme.actionKeyThemeData.copyWith(
              padding: const EdgeInsets.all(10),
            ),
            textKeyThemeData: theme.textKeyThemeData.copyWith(
              backgroundColor: Colors.transparent,
              boxShadow: [],
              // fix for: https://github.com/flutter/flutter/issues/119623
              padding: const EdgeInsets.only(left: 3),
            ),
          );
        },
      ),
    };
  }

  /// Default alphabetic keyboard layout with Kazakh letters.
  /// Kazakh-specific letters (ә, і, ң, ғ, ү, ұ, қ, ө, һ) are accessible
  /// via Shift on the number row (keys 1-9).
  List<KeyboardRow> get _alphabetsMode => [
    _buildRowWithSecondary([
      ('1', 'ә'),
      ('2', 'і'),
      ('3', 'ң'),
      ('4', 'ғ'),
      ('5', 'ү'),
      ('6', 'ұ'),
      ('7', 'қ'),
      ('8', 'ө'),
      ('9', 'һ'),
      ('0', ')'),
    ]),

    _buildRow(['й', 'ц', 'у', 'к', 'е', 'н', 'г', 'ш', 'щ', 'з', 'х', 'ъ']),

    KeyboardRow(
      leading: const Expanded(flex: 10, child: SizedBox.shrink()),
      keys: [
        'ф',
        'ы',
        'в',
        'а',
        'п',
        'р',
        'о',
        'л',
        'д',
        'ж',
        'э',
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
        ...['я', 'ч', 'с', 'м', 'и', 'т', 'ь', 'б', 'ю'].map(_buildKey),
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
        const OnscreenKeyboardKey.action(
          name: ActionKeyType.language,
          child: Icon(Icons.language_rounded),
          flex: 25,
        ),
        const OnscreenKeyboardKey.text(
          primary: ' ',
          child: Icon(Icons.space_bar_rounded),
          flex: 20 * 4,
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
        const OnscreenKeyboardKey.action(
          name: ActionKeyType.language,
          child: Icon(Icons.language_rounded),
          flex: 25,
        ),
        const OnscreenKeyboardKey.text(
          primary: ' ',
          child: Icon(Icons.space_bar_rounded),
          flex: 20 * 4,
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

  /// Emoji keyboard layout.
  List<KeyboardRow> get _emojisMode => [
    ...const [
      ['😂', '❤️', '😍', '😭', '😊', '🔥', '🤣', '👍', '🥰', '😘'],
      ['😅', '🙏', '💕', '😭', '🤔', '😁', '🥲', '😎', '😢', '😋'],
      ['👏', '😮', '😳', '🤗', '🎉', '💔', '😴', '🙄', '😡', '🤩'],
    ].map(_buildRow),

    KeyboardRow(
      keys: [
        ...['😬', '😐', '😇', '🤤', '🤪', '👀', '😷', '😌', '🙈'].map(
          _buildKey,
        ),
        const OnscreenKeyboardKey.action(
          name: ActionKeyType.backspace,
          child: Icon(Icons.backspace_outlined),
        ),
      ],
    ),

    KeyboardRow(
      keys: [
        OnscreenKeyboardKey.action(
          name: 'mode_switch',
          child: const Icon(Icons.swap_horiz_rounded),
          onTap: (context) => context.controller.switchMode(),
        ),
        const OnscreenKeyboardKey.action(
          name: ActionKeyType.language,
          child: Icon(Icons.language_rounded),
        ),
        ...['🌹', '🎂', '🤯', '🥺', '💀', '💩', '🫶'].map(_buildKey),
        const OnscreenKeyboardKey.action(
          name: ActionKeyType.enter,
          child: Icon(Icons.keyboard_return_rounded),
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
