# Numeric Keyboard Layouts

This document describes the numeric keyboard layouts available in the flutter_onscreen_keyboard package.

## Available Numeric Layouts

The package includes three specialized numeric keyboard layouts:

### 1. NumericKeyboardLayout

Basic numeric keyboard perfect for simple number input.

**Features:**
- Numbers 0-9
- Optional decimal point (.)
- Optional negative sign (-)
- Backspace key
- Done/Enter key
- 3:4 aspect ratio (compact)

**Layout:**
```
┌─────┬─────┬─────┐
│  7  │  8  │  9  │
├─────┼─────┼─────┤
│  4  │  5  │  6  │
├─────┼─────┼─────┤
│  1  │  2  │  3  │
├─────┼─────┼─────┤
│  .  │  0  │  ⌫  │
├─────┴─────┴─────┤
│      Done       │
└─────────────────┘
```

**Usage:**
```dart
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';

MaterialApp(
  builder: OnscreenKeyboard.builder(
    layout: (context) => const NumericKeyboardLayout(),
    // OR with options:
    // layout: (context) => const NumericKeyboardLayout(
    //   showDecimal: true,   // Show decimal point (default: true)
    //   showNegative: false, // Show negative sign (default: false)
    // ),
  ),
  home: MyApp(),
)
```

**Parameters:**
- `showDecimal` (bool) - Show decimal point key (default: true)
- `showNegative` (bool) - Show negative sign key (default: false)

---

### 2. DecimalNumericKeyboardLayout

Optimized for decimal number input (prices, measurements, etc.)

**Features:**
- Numbers 0-9
- Decimal point (.)
- Negative sign (-)
- Backspace key
- Done/Enter key
- Better layout for decimal input

**Layout:**
```
┌─────┬─────┬─────┐
│  7  │  8  │  9  │
├─────┼─────┼─────┤
│  4  │  5  │  6  │
├─────┼─────┼─────┤
│  1  │  2  │  3  │
├─────┼─────┼─────┤
│  -  │  0  │  .  │
├─────┴─────┼─────┤
│     ⌫     │Done │
└───────────┴─────┘
```

**Usage:**
```dart
MaterialApp(
  builder: OnscreenKeyboard.builder(
    layout: (context) => const DecimalNumericKeyboardLayout(),
  ),
  home: MyApp(),
)
```

**Perfect for:**
- Price input (e.g., $19.99)
- Weight/measurement input (e.g., 75.5 kg)
- Rating/score input (e.g., 4.5 stars)

---

### 3. PhoneNumericKeyboardLayout

Phone-style dial pad with letters (like mobile phone keypad)

**Features:**
- Numbers 0-9
- Letters on number keys (ABC, DEF, etc.)
- Star (*) and hash (#) keys
- Plus (+) on 0 key (for international dialing)
- Backspace key

**Layout:**
```
┌─────┬─────┬─────┐
│  1  │  2  │  3  │
│     │ ABC │ DEF │
├─────┼─────┼─────┤
│  4  │  5  │  6  │
│ GHI │ JKL │ MNO │
├─────┼─────┼─────┤
│  7  │  8  │  9  │
│PQRS │ TUV │WXYZ │
├─────┼─────┼─────┤
│  *  │  0  │  #  │
│     │  +  │     │
├─────┴─────┴─────┤
│        ⌫        │
└─────────────────┘
```

**Usage:**
```dart
MaterialApp(
  builder: OnscreenKeyboard.builder(
    layout: (context) => const PhoneNumericKeyboardLayout(),
  ),
  home: MyApp(),
)
```

**Perfect for:**
- Phone number entry
- PIN/password input
- Extension/code input
- OTP/verification code

---

## Complete Example

### Dynamic Layout Based on TextField Type

```dart
import 'package:flutter/material.dart';
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  KeyboardLayout _currentLayout = const MobileKeyboardLayout();

  void _setNumericLayout() {
    setState(() {
      _currentLayout = const NumericKeyboardLayout();
    });
  }

  void _setDecimalLayout() {
    setState(() {
      _currentLayout = const DecimalNumericKeyboardLayout();
    });
  }

  void _setPhoneLayout() {
    setState(() {
      _currentLayout = const PhoneNumericKeyboardLayout();
    });
  }

  void _setTextLayout() {
    setState(() {
      _currentLayout = const MobileKeyboardLayout();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: OnscreenKeyboard.builder(
        key: ValueKey(_currentLayout.runtimeType),
        layout: (context) => _currentLayout,
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Integer input (age, quantity, etc.)
              OnscreenKeyboardTextField(
                decoration: const InputDecoration(labelText: 'Age'),
                onTap: _setNumericLayout,
              ),

              // Decimal input (price, weight, etc.)
              OnscreenKeyboardTextField(
                decoration: const InputDecoration(labelText: 'Price'),
                onTap: _setDecimalLayout,
              ),

              // Phone number input
              OnscreenKeyboardTextField(
                decoration: const InputDecoration(labelText: 'Phone'),
                onTap: _setPhoneLayout,
              ),

              // Text input
              OnscreenKeyboardTextField(
                decoration: const InputDecoration(labelText: 'Name'),
                onTap: _setTextLayout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## Using with OnscreenKeyboardTextField

You can automatically switch to numeric layout when a specific field is focused:

```dart
class NumericInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OnscreenKeyboardTextField(
      decoration: const InputDecoration(
        labelText: 'Amount',
        prefixText: '\$',
      ),
      onTap: () {
        // Switch to numeric keyboard when this field is tapped
        // You'll need to implement layout switching in your app
      },
    );
  }
}
```

---

## Creating Custom Numeric Layout

You can also create a fully custom numeric layout using `KeyboardLayout.custom()`:

```dart
final customNumericLayout = KeyboardLayout.custom(
  aspectRatio: 3 / 4,
  modes: {
    'numbers': KeyboardMode(
      rows: [
        KeyboardRow(
          keys: [
            const OnscreenKeyboardKey.text(primary: '1'),
            const OnscreenKeyboardKey.text(primary: '2'),
            const OnscreenKeyboardKey.text(primary: '3'),
          ],
        ),
        // ... more rows
      ],
    ),
  },
);
```

---

## Customization

All numeric layouts support standard customization:

### Theme Customization
```dart
OnscreenKeyboard.builder(
  layout: (context) => const NumericKeyboardLayout(),
  theme: OnscreenKeyboardThemeData(
    textKeyThemeData: TextKeyThemeData(
      backgroundColor: Colors.blue.shade100,
      textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ),
  ),
)
```

### Width and Aspect Ratio
```dart
OnscreenKeyboard.builder(
  layout: (context) => const NumericKeyboardLayout(),
  width: (context) => 300,  // Fixed width
  // aspectRatio is already set in the layout (3:4)
)
```

---

## Best Practices

### 1. Choose the Right Layout

- **NumericKeyboardLayout** - Simple integer input (age, quantity)
- **DecimalNumericKeyboardLayout** - Decimal numbers (prices, measurements)
- **PhoneNumericKeyboardLayout** - Phone numbers, PINs, codes

### 2. Use ValueKey for Layout Switching

Always use `ValueKey` when switching layouts dynamically:

```dart
OnscreenKeyboard.builder(
  key: ValueKey(_currentLayout.runtimeType),  // ← Important!
  layout: (context) => _currentLayout,
)
```

### 3. Input Validation

Combine with TextInputFormatter for proper validation:

```dart
OnscreenKeyboardTextField(
  inputFormatters: [
    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
  ],
  decoration: const InputDecoration(labelText: 'Price'),
)
```

---

## Comparison Table

| Feature | Numeric | Decimal | Phone |
|---------|---------|---------|-------|
| Numbers 0-9 | ✅ | ✅ | ✅ |
| Decimal point | Optional | ✅ | ❌ |
| Negative sign | Optional | ✅ | ❌ |
| * and # keys | ❌ | ❌ | ✅ |
| + key | ❌ | ❌ | ✅ |
| Letters on keys | ❌ | ❌ | ✅ |
| Backspace | ✅ | ✅ | ✅ |
| Enter/Done | ✅ | ✅ | ❌ |
| Aspect Ratio | 3:4 | 3:4 | 3:4 |

---

## Migration from Text Keyboard

If you're currently using full keyboard for numeric input:

**Before:**
```dart
OnscreenKeyboard.builder(
  layout: (context) => const MobileKeyboardLayout(),
)
```

**After:**
```dart
OnscreenKeyboard.builder(
  layout: (context) => const NumericKeyboardLayout(),
)
```

Or dynamically:
```dart
layout: (context) => _isNumericField
    ? const NumericKeyboardLayout()
    : const MobileKeyboardLayout(),
```

---

## FAQs

**Q: Can I add more buttons to the numeric keyboard?**
A: Yes! Extend the class or use `KeyboardLayout.custom()` to create your own layout.

**Q: How do I switch between numeric and text keyboard?**
A: Store the current layout in state and update it based on focused field. Use `ValueKey` to force rebuild.

**Q: Can I change the button colors?**
A: Yes, use `theme` parameter in `OnscreenKeyboard.builder()`.

**Q: Does it work on both mobile and desktop?**
A: Yes! All numeric layouts work on all platforms.

---

## See Also

- [Main Documentation](README.md)
- [Language Support](LANGUAGE_SUPPORT.md)
- [API Documentation](https://pub.dev/documentation/flutter_onscreen_keyboard/latest/)
