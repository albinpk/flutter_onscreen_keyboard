# Multi-Language Keyboard Support

This document describes the multi-language keyboard support added to the flutter_onscreen_keyboard package.

## Supported Languages

The package now includes keyboard layouts for the following languages:

1. **English** (QWERTY) - `MobileKeyboardLayout` / `DesktopKeyboardLayout`
2. **Russian** (ЙЦУКЕН) - `RussianMobileKeyboardLayout`
3. **Kazakh** (ЙЦУКЕН + 9 special letters) - `KazakhMobileKeyboardLayout`

## Russian Keyboard Layout

The Russian layout (`RussianMobileKeyboardLayout`) implements the standard ЙЦУКЕН keyboard layout used in Russian-speaking countries.

### Features:
- Standard ЙЦУКЕН letter arrangement
- Number row with Russian-specific symbols (№ sign on 3, etc.)
- Symbols mode with special characters
- Emoji mode (same as English layout)
- Shift/CapsLock support for uppercase letters

### Layout Structure:

**Row 1 (Numbers):**
```
1! 2" 3№ 4; 5% 6: 7? 8* 9( 0)
```

**Row 2 (First letter row):**
```
й ц у к е н г ш щ з х ъ
```

**Row 3 (Second letter row):**
```
ф ы в а п р о л д ж э
```

**Row 4 (Third letter row):**
```
[CapsLock] я ч с м и т ь б ю [Backspace]
```

**Row 5 (Bottom row):**
```
[Mode] / [Space] . [Enter]
```

## Kazakh Keyboard Layout

The Kazakh layout (`KazakhMobileKeyboardLayout`) extends the Russian ЙЦУКЕН layout with 9 additional Kazakh-specific letters.

### Features:
- Standard ЙЦУКЕН letter arrangement
- Additional row with 9 Kazakh-specific letters: **ә і ң ғ ү ұ қ ө һ**
- Number row with symbols
- Symbols mode with special characters
- Emoji mode
- Shift/CapsLock support

### Layout Structure:

**Row 1 (Numbers):**
```
1! 2" 3№ 4; 5% 6: 7? 8* 9( 0)
```

**Row 2 (First letter row):**
```
й ц у к е н г ш щ з х ъ
```

**Row 3 (Second letter row):**
```
ф ы в а п р о л д ж э
```

**Row 4 (Third letter row):**
```
[CapsLock] я ч с м и т ь б ю [Backspace]
```

**Row 5 (Kazakh-specific letters):**
```
ә і ң ғ ү ұ қ ө һ
```

**Row 6 (Bottom row):**
```
[Mode] / [Space] . [Enter]
```

## Usage

### Basic Usage

#### Using Russian Layout:

```dart
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';

MaterialApp(
  builder: OnscreenKeyboard.builder(
    layout: (context) => RussianMobileKeyboardLayout(),
  ),
  home: MyHomePage(),
)
```

#### Using Kazakh Layout:

```dart
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';

MaterialApp(
  builder: OnscreenKeyboard.builder(
    layout: (context) => KazakhMobileKeyboardLayout(),
  ),
  home: MyHomePage(),
)
```

### Dynamic Language Switching

You can implement dynamic language switching by managing the layout state at the app level:

```dart
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  KeyboardLayout _currentLayout = const MobileKeyboardLayout();

  void _changeLanguage(String language) {
    setState(() {
      _currentLayout = switch (language) {
        'ru' => const RussianMobileKeyboardLayout(),
        'kk' => const KazakhMobileKeyboardLayout(),
        _ => const MobileKeyboardLayout(), // English
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: OnscreenKeyboard.builder(
        layout: (context) => _currentLayout,
      ),
      home: MyHomePage(onLanguageChange: _changeLanguage),
    );
  }
}
```

### Complete Example

See the [example app](packages/flutter_onscreen_keyboard/example/lib/main.dart) for a complete implementation with language switching using `SegmentedButton`.

## Creating Custom Language Layouts

To add support for additional languages, follow this pattern:

1. Create a new layout file in `lib/src/layouts/`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';

class YourLanguageMobileKeyboardLayout extends KeyboardLayout {
  const YourLanguageMobileKeyboardLayout();

  @override
  double get aspectRatio => 4 / 3;

  @override
  Map<String, KeyboardMode> get modes {
    return {
      'alphabets': KeyboardMode(rows: _alphabetsMode),
      'symbols': KeyboardMode(rows: _symbolsMode),
    };
  }

  List<KeyboardRow> get _alphabetsMode => [
    // Define your keyboard rows here
    _buildRow(['a', 'b', 'c', ...]),
  ];

  // Helper methods for building keys and rows
  OnscreenKeyboardKey _buildKey(String key) {
    return OnscreenKeyboardKey.text(primary: key);
  }

  KeyboardRow _buildRow(List<String> keys) {
    return KeyboardRow(keys: keys.map(_buildKey).toList());
  }
}
```

2. Export your layout in `lib/src/layouts/layouts.dart`:

```dart
export 'your_language_mobile_layout.dart';
```

3. Use your layout in your app as shown above.

## Technical Details

### Key Types

- **TextKey**: Represents printable characters with primary and optional secondary (shift) values
- **ActionKey**: Represents non-character keys like Backspace, Enter, CapsLock, etc.

### Modes

Each layout can have multiple modes (e.g., 'alphabets', 'symbols', 'emojis'). Users can switch between modes using the mode switch key (typically showing ⇄ icon).

### Customization

All layouts support:
- Custom theming via `OnscreenKeyboardThemeData`
- Custom key widths using the `flex` parameter
- Custom key callbacks (`onTap`, `onTapDown`, `onTapUp`)
- Custom visual widgets for keys using the `child` parameter

## Files Added/Modified

### New Files:
- `lib/src/layouts/russian_mobile_layout.dart` - Russian keyboard layout
- `lib/src/layouts/kazakh_mobile_layout.dart` - Kazakh keyboard layout
- `LANGUAGE_SUPPORT.md` - This documentation file

### Modified Files:
- `lib/src/layouts/layouts.dart` - Added exports for new layouts
- `example/lib/main.dart` - Added language switching demonstration

## Contributing

To contribute additional language layouts:

1. Create a new layout class following the pattern above
2. Add comprehensive documentation
3. Update this file with your language details
4. Submit a pull request

## License

Same as the main package license.
