# Multi-Language Keyboard Support

This document describes the comprehensive multi-language keyboard support for the flutter_onscreen_keyboard package.

## Supported Languages

The package now includes complete keyboard layouts for the following languages in both **Desktop** and **Mobile** versions:

1. **English** (QWERTY)
2. **Russian** (ЙЦУКЕН)
3. **Kazakh** (ЙЦУКЕН + special characters)

## Language Switching

All layouts include a **globe key** (🌐) positioned to the left of the Space bar that allows **cyclic language switching**:

```
English → Russian → Kazakh → English → ...
```

Simply click/tap the 🌐 key on the keyboard to switch between languages.

---

## Desktop Layouts (5:2 aspect ratio)

### 1. English Desktop Layout

**Class:** `DesktopEnglishKeyboardLayout`

**Features:**
- Standard QWERTY layout
- Full number row with symbols (`~!@#$%^&*()_+`)
- Tab, CapsLock, Shift (×2), Enter, Backspace
- Language switch key (🌐) left of Space bar

**Structure:**
```
Row 1: ` 1 2 3 4 5 6 7 8 9 0 - = [Backspace]
Row 2: [Tab] Q W E R T Y U I O P [ ] \
Row 3: [Caps] A S D F G H J K L ; ' [Enter]
Row 4: [Shift] Z X C V B N M , . / [Shift]
Row 5: [🌐] [___________Space___________]
```

### 2. Russian Desktop Layout

**Class:** `DesktopRussianKeyboardLayout`

**Features:**
- Standard ЙЦУКЕН layout
- Includes Ё (yo) key in top-left position
- Russian-specific punctuation: № (numero sign), Russian quotes, etc.
- Language switch key (🌐) left of Space bar

**Structure:**
```
Row 1: Ё 1 2 3 4 5 6 7 8 9 0 - = [Backspace]
Row 2: [Tab] Й Ц У К Е Н Г Ш Щ З Х Ъ \
Row 3: [Caps] Ф Ы В А П Р О Л Д Ж Э [Enter]
Row 4: [Shift] Я Ч С М И Т Ь Б Ю . [Shift]
Row 5: [🌐] [___________Space___________]
```

**Number row Shift characters:**
```
1→! 2→" 3→№ 4→; 5→% 6→: 7→? 8→* 9→( 0→)
```

### 3. Kazakh Desktop Layout

**Class:** `DesktopKazakhKeyboardLayout`

**Features:**
- ЙЦУКЕН base layout
- 9 Kazakh-specific letters accessible via **Shift on number keys 1-9**:
  - `1+Shift` → ә
  - `2+Shift` → і
  - `3+Shift` → ң
  - `4+Shift` → ғ
  - `5+Shift` → ү
  - `6+Shift` → ұ
  - `7+Shift` → қ
  - `8+Shift` → ө
  - `9+Shift` → һ
- Language switch key (🌐) left of Space bar

**Structure:**
```
Row 1: Ё 1 2 3 4 5 6 7 8 9 0 - = [Backspace]
       (Shift: ә і ң ғ ү ұ қ ө һ)
Row 2: [Tab] Й Ц У К Е Н Г Ш Щ З Х Ъ \
Row 3: [Caps] Ф Ы В А П Р О Л Д Ж Э [Enter]
Row 4: [Shift] Я Ч С М И Т Ь Б Ю . [Shift]
Row 5: [🌐] [___________Space___________]
```

---

## Mobile Layouts (4:3 aspect ratio)

### 1. English Mobile Layout

**Class:** `MobileKeyboardLayout`

**Features:**
- Compact QWERTY layout
- 3 modes: alphabets, symbols, emojis
- Mode switch key (⇄) for switching between modes
- Language switch key (🌐) left of Space bar

**Alphabets Mode:**
```
Row 1: 1 2 3 4 5 6 7 8 9 0 (Shift: ! @ # $ % ^ & * ( ))
Row 2: Q W E R T Y U I O P
Row 3:   A S D F G H J K L
Row 4: [⇪] Z X C V B N M [⌫]
Row 5: [⇄] [🌐] [_______Space_______] . [↵]
```

**Symbols Mode:** Special characters and currency symbols
**Emojis Mode:** 30+ popular emoji characters

### 2. Russian Mobile Layout

**Class:** `RussianMobileKeyboardLayout`

**Features:**
- Compact ЙЦУКЕН layout
- 3 modes: alphabets, symbols, emojis
- Language switch key (🌐) left of Space bar
- Russian punctuation in symbols mode

**Alphabets Mode:**
```
Row 1: 1 2 3 4 5 6 7 8 9 0 (Shift: ! " № ; % : ? * ( ))
Row 2: Й Ц У К Е Н Г Ш Щ З Х Ъ
Row 3:   Ф Ы В А П Р О Л Д Ж Э
Row 4: [⇪] Я Ч С М И Т Ь Б Ю [⌫]
Row 5: [⇄] [🌐] [_______Space_______] . [↵]
```

### 3. Kazakh Mobile Layout

**Class:** `KazakhMobileKeyboardLayout`

**Features:**
- Compact ЙЦУКЕН layout
- 9 Kazakh-specific letters accessible via **Shift on number keys 1-9**
- 3 modes: alphabets, symbols, emojis
- Language switch key (🌐) left of Space bar

**Alphabets Mode:**
```
Row 1: 1 2 3 4 5 6 7 8 9 0
       (Shift: ә і ң ғ ү ұ қ ө һ)
Row 2: Й Ц У К Е Н Г Ш Щ З Х Ъ
Row 3:   Ф Ы В А П Р О Л Д Ж Э
Row 4: [⇪] Я Ч С М И Т Ь Б Ю [⌫]
Row 5: [⇄] [🌐] [_______Space_______] . [↵]
```

**Note:** To type Kazakh-specific letters (ә, і, ң, ғ, ү, ұ, қ, ө, һ), press Shift/CapsLock and then the corresponding number key 1-9.

---

## Usage

### Automatic Platform Detection

The example app automatically detects the platform and selects the appropriate layout:

```dart
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

bool get isDesktop {
  if (kIsWeb) return false;
  return Platform.isMacOS || Platform.isWindows || Platform.isLinux;
}
```

### Basic Implementation

```dart
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';

enum KeyboardLanguage { english, russian, kazakh }

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  KeyboardLanguage _currentLanguage = KeyboardLanguage.english;

  KeyboardLayout _getLayout(bool isDesktop) {
    if (isDesktop) {
      return switch (_currentLanguage) {
        KeyboardLanguage.english => const DesktopEnglishKeyboardLayout(),
        KeyboardLanguage.russian => const DesktopRussianKeyboardLayout(),
        KeyboardLanguage.kazakh => const DesktopKazakhKeyboardLayout(),
      };
    } else {
      return switch (_currentLanguage) {
        KeyboardLanguage.english => const MobileKeyboardLayout(),
        KeyboardLanguage.russian => const RussianMobileKeyboardLayout(),
        KeyboardLanguage.kazakh => const KazakhMobileKeyboardLayout(),
      };
    }
  }

  void _switchLanguage() {
    setState(() {
      _currentLanguage = switch (_currentLanguage) {
        KeyboardLanguage.english => KeyboardLanguage.russian,
        KeyboardLanguage.russian => KeyboardLanguage.kazakh,
        KeyboardLanguage.kazakh => KeyboardLanguage.english,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: OnscreenKeyboard.builder(
        key: ValueKey(_currentLanguage), // Force rebuild on language change
        layout: (context) => _getLayout(isDesktop),
      ),
      home: MyHomePage(onLanguageSwitch: _switchLanguage),
    );
  }
}
```

### Handling Language Switch Key

Listen to the language switch action key in your screen:

```dart
class _MyScreenState extends State<MyScreen> {
  late final keyboard = OnscreenKeyboard.of(context);

  @override
  void initState() {
    super.initState();
    keyboard.addRawKeyDownListener(_listener);
  }

  void _listener(OnscreenKeyboardKey key) {
    if (key is ActionKey && key.name == ActionKeyType.language) {
      widget.onLanguageSwitch(); // Call your language switch function
    }
  }

  @override
  void dispose() {
    keyboard.removeRawKeyDownListener(_listener);
    super.dispose();
  }
}
```

---

## Technical Details

### Action Key Type

A new action key type has been added:

```dart
// lib/src/constants/action_key_type.dart
static const language = 'language';
```

### Language Switch Flow

1. User clicks/taps the 🌐 key on keyboard
2. `ActionKeyType.language` event is fired
3. Raw key down listener catches the event
4. App state updates to next language
5. Keyboard rebuilds with new layout via `ValueKey`

### Kazakh Letter Mapping

The 9 Kazakh-specific letters are mapped to number keys 1-9:

| Number Key | Kazakh Letter | Unicode |
|------------|---------------|---------|
| 1 | ә | U+04D9 |
| 2 | і | U+0456 |
| 3 | ң | U+04A3 |
| 4 | ғ | U+0493 |
| 5 | ү | U+04AF |
| 6 | ұ | U+04B1 |
| 7 | қ | U+049B |
| 8 | ө | U+04E9 |
| 9 | һ | U+04BB |

These letters are accessible as **secondary characters** when Shift or CapsLock is active.

---

## Files Structure

### Desktop Layouts
- `lib/src/layouts/desktop_english_layout.dart`
- `lib/src/layouts/desktop_russian_layout.dart`
- `lib/src/layouts/desktop_kazakh_layout.dart`

### Mobile Layouts
- `lib/src/layouts/mobile_layout.dart` (English)
- `lib/src/layouts/russian_mobile_layout.dart`
- `lib/src/layouts/kazakh_mobile_layout.dart`

### Core Files
- `lib/src/constants/action_key_type.dart` - Added `language` constant
- `lib/src/layouts/layouts.dart` - Exports all layouts
- `example/lib/main.dart` - Complete implementation example

---

## Customization

All layouts support full customization via:
- `OnscreenKeyboardThemeData` for styling
- Custom key `flex` values for sizing
- Custom callbacks (`onTap`, `onTapDown`, `onTapUp`)
- Custom visual widgets using `child` parameter

### Example: Custom Language Indicator

```dart
Card(
  child: Row(
    children: [
      Text(_getLanguageEmoji()), // 🇬🇧 🇷🇺 🇰🇿
      Text(_getLanguageName()),  // English, Russian, Kazakh
    ],
  ),
)
```

---

## Best Practices

1. **Always use `ValueKey`** when changing languages to force keyboard rebuild
2. **Listen to `ActionKeyType.language`** in raw key listener for language switching
3. **Detect platform** to choose appropriate layout (desktop vs mobile)
4. **Provide visual feedback** showing current language to users
5. **Test Kazakh input** by verifying Shift+Number produces correct characters

---

## Migration from Old Layouts

### Old Mobile Layouts (without language key)

If you were using:
- `RussianMobileKeyboardLayout` - No changes needed, now includes 🌐 key
- `KazakhMobileKeyboardLayout` - Updated: Kazakh letters now on number row (not separate row)

### Desktop Layouts

New classes have been added:
- `DesktopEnglishKeyboardLayout` - New
- `DesktopRussianKeyboardLayout` - New
- `DesktopKazakhKeyboardLayout` - New

The original `DesktopKeyboardLayout` (English-only, without 🌐) remains unchanged for backward compatibility.

---

## Contributing

To add support for additional languages:

1. Create desktop layout: `desktop_LANGUAGE_layout.dart`
2. Create mobile layout: `LANGUAGE_mobile_layout.dart`
3. Include language switch key (🌐) in bottom row
4. Export layouts in `layouts.dart`
5. Update example app to include new language in enum
6. Document layout structure and special characters

---

## License

Same as the main package license (MIT).

## See Also

- [Main Package README](packages/flutter_onscreen_keyboard/README.md)
- [Example App](packages/flutter_onscreen_keyboard/example/)
- [API Documentation](https://pub.dev/documentation/flutter_onscreen_keyboard/latest/)
