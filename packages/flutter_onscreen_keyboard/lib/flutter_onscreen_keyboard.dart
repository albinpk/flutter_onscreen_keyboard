/// A fully customizable on-screen keyboard widget for Flutter.
///
/// The `flutter_onscreen_keyboard` package provides both a high-level keyboard
/// interface (`OnscreenKeyboard`) and a low-level stateless version
/// for building embedded or floating virtual keyboards.
///
/// Features:
/// - Text and action keys with customizable layout
/// - Shift/CapsLock support with smart secondary character switching
/// - Dedicated [OnscreenKeyboardTextField] for ease of use
/// - Movable/floating keyboard with drag support
/// - Theming and layout customization
///
/// Ideal for POS interfaces, desktop apps, or accessibility tools.
///
/// See also:
/// - [RawOnscreenKeyboard] - a low-level keyboard widget
/// - [OnscreenKeyboardTextField] - dedicated text field widget
/// - [OnscreenKeyboardController] - interface for controlling the keyboard
library;

import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart'
    show
        OnscreenKeyboardController,
        OnscreenKeyboardTextField,
        RawOnscreenKeyboard;

export 'src/layouts/layouts.dart';
export 'src/models/keys.dart';
export 'src/models/layout.dart';
export 'src/onscreen_keyboard.dart'
    show
        OnscreenKeyboard,
        OnscreenKeyboardController,
        OnscreenKeyboardTextField,
        OnscreenKeyboardTextFormField;
export 'src/raw_onscreen_keyboard.dart' show RawOnscreenKeyboard;
export 'src/theme/onscreen_keyboard_theme_data.dart';
