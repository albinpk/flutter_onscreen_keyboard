import 'package:flutter/material.dart';
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';
import 'package:flutter_onscreen_keyboard/src/utils/extensions.dart';

/// A widget that visually represents a [TextKey] on the onscreen keyboard.
///
/// This widget handles the visual rendering, tap interactions,
/// and optionally displays a secondary symbol.
///
/// The [onTapDown] and [onTapUp] callbacks are triggered when
/// the key is pressed and released.
class TextKeyWidget extends StatelessWidget {
  /// Constructs a [TextKeyWidget] with the given parameters.
  const TextKeyWidget({
    required this.textKey,
    required this.onTapDown,
    required this.onTapUp,
    this.showSecondary = false,
    super.key,
  });

  /// The [TextKey] to be rendered.
  final TextKey textKey;

  /// Callback when the key is pressed.
  final VoidCallback onTapDown;

  /// Callback when the key is released or cancelled.
  final VoidCallback onTapUp;

  /// If true, shows the secondary text from the key (like shifted version).
  final bool showSecondary;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final keyTheme = context.theme.textKeyThemeData;
    return DecoratedBox(
      decoration: keyTheme.decoration ?? BoxDecoration(color: colors.surface),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTapDown: (_) => onTapDown(),
          onTapUp: (_) => onTapUp(),
          onTapCancel: onTapUp,
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: switch (textKey.child) {
                Icon() => Padding(
                  padding: const EdgeInsets.all(28),
                  child: textKey.child,
                ),
                Widget() => textKey.child,
                null => Text(
                  textKey.getText(secondary: showSecondary),
                  style: keyTheme.textStyle,
                ),
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// A widget that visually represents an [ActionKey] on the onscreen keyboard.
///
/// This widget changes its appearance when pressed and handles
/// press/release interactions using the given callbacks.
class ActionKeyWidget extends StatelessWidget {
  /// Constructs an [ActionKeyWidget] with the given parameters.
  const ActionKeyWidget({
    required this.actionKey,
    required this.pressed,
    required this.onTapDown,
    required this.onTapUp,
    super.key,
  });

  /// The [ActionKey] to be rendered.
  final ActionKey actionKey;

  /// Whether the key is currently in a pressed state.
  final bool pressed;

  /// Callback when the key is pressed.
  final VoidCallback onTapDown;

  /// Callback when the key is released or cancelled.
  final VoidCallback onTapUp;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final keyTheme = context.theme.actionKeyThemeData;
    return DecoratedBox(
      decoration:
          keyTheme.decoration ??
          BoxDecoration(
            color: pressed ? colors.primary : colors.surfaceContainer,
          ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTapDown: (_) => onTapDown(),
          onTapUp: (_) => onTapUp(),
          onTapCancel: onTapUp,
          child: IconTheme(
            data: IconThemeData(
              color: pressed ? colors.onPrimary : colors.onSurface,
            ),
            child: FittedBox(
              child: switch (actionKey.child) {
                Icon() => Padding(
                  padding: const EdgeInsets.all(28),
                  child: actionKey.child,
                ),
                Widget() => actionKey.child,
                null => Text(actionKey.label ?? actionKey.name),
              },
            ),
          ),
        ),
      ),
    );
  }
}
