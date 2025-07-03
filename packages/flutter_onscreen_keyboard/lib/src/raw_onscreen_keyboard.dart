import 'package:flutter/material.dart';
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';
import 'package:flutter_onscreen_keyboard/src/widgets/keys.dart';

/// A low-level on-screen keyboard widget that displays keys
/// based on the given [KeyboardLayout].
///
/// It handles key rendering, layout structure, and interaction callbacks
/// for key presses. This widget is useful for embedding the keyboard UI
/// inside another widget and controlling its behavior externally.
class RawOnscreenKeyboard extends StatelessWidget {
  /// Creates a [RawOnscreenKeyboard] widget.
  const RawOnscreenKeyboard({
    required this.layout,
    required this.onKeyDown,
    required this.onKeyUp,
    required this.mode,
    super.key,
    this.aspectRatio,
    this.pressedActionKeys = const {},
    this.showSecondary = false,
  });

  /// The keyboard layout that defines rows and keys to render.
  final KeyboardLayout layout;

  /// {@macro keyboardLayout.aspectRatio}
  ///
  /// Defaults to the aspect ratio of [layout].
  final double? aspectRatio;

  /// Callback when a key is pressed down.
  final ValueChanged<OnscreenKeyboardKey> onKeyDown;

  /// Callback when a key is released.
  final ValueChanged<OnscreenKeyboardKey> onKeyUp;

  /// A set of currently pressed action key names (e.g., shift, capslock).
  ///
  /// Used to visually indicate active keys like modifiers.
  final Set<String> pressedActionKeys;

  /// Whether to show the secondary value for each [TextKey] (e.g., uppercase).
  final bool showSecondary;

  /// The currently active keyboard mode to render from the layout.
  ///
  /// Must match one of the keys defined in [KeyboardLayout.modes].
  final String mode;

  @override
  Widget build(BuildContext context) {
    final activeMode = layout.modes[mode]!;
    return AspectRatio(
      aspectRatio: aspectRatio ?? layout.aspectRatio,
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          spacing: activeMode.verticalSpacing,
          children: [
            for (final row in activeMode.rows)
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ?row.leading,
                    for (final k in row.keys)
                      Expanded(
                        flex: k.flex,
                        child: switch (k) {
                          TextKey() => TextKeyWidget(
                            textKey: k,
                            showSecondary: showSecondary,
                            onTapDown: () => onKeyDown(k),
                            onTapUp: () => onKeyUp(k),
                          ),
                          ActionKey() => ActionKeyWidget(
                            actionKey: k,
                            pressed: pressedActionKeys.contains(k.name),
                            onTapDown: () => onKeyDown(k),
                            onTapUp: () => onKeyUp(k),
                          ),
                        },
                      ),
                    ?row.trailing,
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
