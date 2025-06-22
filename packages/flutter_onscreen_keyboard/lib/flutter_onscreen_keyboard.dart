/// A fully customizable on-screen keyboard widget for Flutter.
///
/// The `flutter_onscreen_keyboard` package provides both a high-level keyboard
/// interface (`OnscreenKeyboard`) and a low-level stateless version
/// for building embedded or floating virtual keyboards.
///
/// Features:
/// - Text and action keys with customizable layout
/// - Shift/CapsLock support with smart secondary character switching
/// - TextField and controller attachment with cursor and selection handling
/// - Movable/floating keyboard with drag support
/// - Theming and layout customization
///
/// Ideal for POS interfaces, desktop apps, or accessibility tools.
///
/// See also:
/// - [RawOnscreenKeyboard]
library;

import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart'
    show RawOnscreenKeyboard;

export 'src/layouts/layouts.dart';
export 'src/models/keys.dart';
export 'src/models/layout.dart';
export 'src/onscreen_keyboard.dart'
    show
        OnscreenKeyboard,
        OnscreenKeyboardController,
        OnscreenKeyboardTextField;
export 'src/raw_onscreen_keyboard.dart' show RawOnscreenKeyboard;
export 'src/theme/onscreen_keyboard_theme_data.dart';
