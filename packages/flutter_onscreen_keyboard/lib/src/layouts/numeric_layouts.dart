import 'package:flutter/material.dart';
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';
import 'package:flutter_onscreen_keyboard/src/constants/action_key_type.dart';

/// A numeric keyboard layout for number input (like a calculator or phone dial pad).
///
/// This layout provides a compact numeric keypad with:
/// - Number keys 0-9
/// - Decimal point (.)
/// - Backspace key
/// - Enter key
/// - Optional negative sign (-)
///
/// Perfect for:
/// - Price/amount input
/// - Phone number entry
/// - PIN/password input
/// - Calculator-style interfaces
class NumericKeyboardLayout extends KeyboardLayout {
  /// Creates a [NumericKeyboardLayout].
  ///
  /// [showDecimal] - If true, shows decimal point key (default: true)
  /// [showNegative] - If true, shows negative sign key (default: false)
  const NumericKeyboardLayout({
    this.showDecimal = true,
    this.showNegative = false,
  });

  /// Whether to show the decimal point (.) key.
  final bool showDecimal;

  /// Whether to show the negative sign (-) key.
  final bool showNegative;

  @override
  double get aspectRatio => 3 / 4; // Taller layout for numeric pad

  @override
  Map<String, KeyboardMode> get modes {
    return {
      'numeric': KeyboardMode(rows: _numericMode),
    };
  }

  /// Numeric keypad layout (calculator/phone style).
  List<KeyboardRow> get _numericMode => [
        // Row 1: 7 8 9
        const KeyboardRow(
          keys: [
            OnscreenKeyboardKey.text(primary: '7', flex: 33),
            OnscreenKeyboardKey.text(primary: '8', flex: 33),
            OnscreenKeyboardKey.text(primary: '9', flex: 33),
          ],
        ),

        // Row 2: 4 5 6
        const KeyboardRow(
          keys: [
            OnscreenKeyboardKey.text(primary: '4', flex: 33),
            OnscreenKeyboardKey.text(primary: '5', flex: 33),
            OnscreenKeyboardKey.text(primary: '6', flex: 33),
          ],
        ),

        // Row 3: 1 2 3
        const KeyboardRow(
          keys: [
            OnscreenKeyboardKey.text(primary: '1', flex: 33),
            OnscreenKeyboardKey.text(primary: '2', flex: 33),
            OnscreenKeyboardKey.text(primary: '3', flex: 33),
          ],
        ),

        // Row 4: -/. 0 backspace
        KeyboardRow(
          keys: [
            if (showNegative)
              const OnscreenKeyboardKey.text(primary: '-', flex: 33)
            else if (showDecimal)
              const OnscreenKeyboardKey.text(primary: '.', flex: 33)
            else
              const OnscreenKeyboardKey.text(
                primary: '',
                flex: 33,
              ), // Empty space
            const OnscreenKeyboardKey.text(primary: '0', flex: 33),
            const OnscreenKeyboardKey.action(
              name: ActionKeyType.backspace,
              child: Icon(Icons.backspace_outlined),
              flex: 33,
            ),
          ],
        ),

        // Row 5: Enter (full width)
        const KeyboardRow(
          keys: [
            OnscreenKeyboardKey.action(
              name: ActionKeyType.enter,
              label: 'Done',
              flex: 100,
            ),
          ],
        ),
      ];
}

/// A numeric keyboard layout with additional decimal and negative sign support.
///
/// This layout is optimized for decimal number input (prices, measurements, etc.)
class DecimalNumericKeyboardLayout extends KeyboardLayout {
  /// Creates a [DecimalNumericKeyboardLayout].
  const DecimalNumericKeyboardLayout();

  @override
  double get aspectRatio => 3 / 4;

  @override
  Map<String, KeyboardMode> get modes {
    return {
      'numeric': KeyboardMode(rows: _numericMode),
    };
  }

  List<KeyboardRow> get _numericMode => [
        // Row 1: 7 8 9
        const KeyboardRow(
          keys: [
            OnscreenKeyboardKey.text(primary: '7', flex: 33),
            OnscreenKeyboardKey.text(primary: '8', flex: 33),
            OnscreenKeyboardKey.text(primary: '9', flex: 33),
          ],
        ),

        // Row 2: 4 5 6
        const KeyboardRow(
          keys: [
            OnscreenKeyboardKey.text(primary: '4', flex: 33),
            OnscreenKeyboardKey.text(primary: '5', flex: 33),
            OnscreenKeyboardKey.text(primary: '6', flex: 33),
          ],
        ),

        // Row 3: 1 2 3
        const KeyboardRow(
          keys: [
            OnscreenKeyboardKey.text(primary: '1', flex: 33),
            OnscreenKeyboardKey.text(primary: '2', flex: 33),
            OnscreenKeyboardKey.text(primary: '3', flex: 33),
          ],
        ),

        // Row 4: - 0 .
        const KeyboardRow(
          keys: [
            OnscreenKeyboardKey.text(primary: '-', flex: 33),
            OnscreenKeyboardKey.text(primary: '0', flex: 33),
            OnscreenKeyboardKey.text(primary: '.', flex: 33),
          ],
        ),

        // Row 5: Backspace and Enter
        const KeyboardRow(
          keys: [
            OnscreenKeyboardKey.action(
              name: ActionKeyType.backspace,
              child: Icon(Icons.backspace_outlined),
              flex: 50,
            ),
            OnscreenKeyboardKey.action(
              name: ActionKeyType.enter,
              label: 'Done',
              flex: 50,
            ),
          ],
        ),
      ];
}

/// A phone-style numeric keyboard layout (like phone dial pad).
///
/// Numbers arranged in phone keypad style with letters (ABC, DEF, etc.)
class PhoneNumericKeyboardLayout extends KeyboardLayout {
  /// Creates a [PhoneNumericKeyboardLayout].
  const PhoneNumericKeyboardLayout();

  @override
  double get aspectRatio => 3 / 4;

  @override
  Map<String, KeyboardMode> get modes {
    return {
      'phone': KeyboardMode(rows: _phoneMode),
    };
  }

  List<KeyboardRow> get _phoneMode => [
        // Row 1: 1 2 3
        const KeyboardRow(
          keys: [
            OnscreenKeyboardKey.text(primary: '1', flex: 33),
            OnscreenKeyboardKey.text(primary: '2', secondary: 'ABC', flex: 33),
            OnscreenKeyboardKey.text(primary: '3', secondary: 'DEF', flex: 33),
          ],
        ),

        // Row 2: 4 5 6
        const KeyboardRow(
          keys: [
            OnscreenKeyboardKey.text(primary: '4', secondary: 'GHI', flex: 33),
            OnscreenKeyboardKey.text(primary: '5', secondary: 'JKL', flex: 33),
            OnscreenKeyboardKey.text(primary: '6', secondary: 'MNO', flex: 33),
          ],
        ),

        // Row 3: 7 8 9
        const KeyboardRow(
          keys: [
            OnscreenKeyboardKey.text(primary: '7', secondary: 'PQRS', flex: 33),
            OnscreenKeyboardKey.text(primary: '8', secondary: 'TUV', flex: 33),
            OnscreenKeyboardKey.text(primary: '9', secondary: 'WXYZ', flex: 33),
          ],
        ),

        // Row 4: * 0 #
        const KeyboardRow(
          keys: [
            OnscreenKeyboardKey.text(primary: '*', flex: 33),
            OnscreenKeyboardKey.text(primary: '0', secondary: '+', flex: 33),
            OnscreenKeyboardKey.text(primary: '#', flex: 33),
          ],
        ),

        // Row 5: Backspace
        const KeyboardRow(
          keys: [
            OnscreenKeyboardKey.action(
              name: ActionKeyType.backspace,
              child: Icon(Icons.backspace_outlined),
              flex: 100,
            ),
          ],
        ),
      ];
}
