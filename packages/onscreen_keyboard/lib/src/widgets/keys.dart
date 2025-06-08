import 'package:flutter/material.dart';
import 'package:onscreen_keyboard/src/models/keys.dart';
import 'package:onscreen_keyboard/src/utils/extensions.dart';

class TextKeyWidget extends StatelessWidget {
  const TextKeyWidget({
    required this.textKey,
    required this.onTapDown,
    required this.onTapUp,
    this.showSecondary = false,
    super.key,
  });

  final TextKey textKey;
  final VoidCallback onTapDown;
  final VoidCallback onTapUp;
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
                null => Text(textKey.getText(secondary: showSecondary)),
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ActionKeyWidget extends StatelessWidget {
  const ActionKeyWidget({
    required this.actionKey,
    required this.pressed,
    required this.onTapDown,
    required this.onTapUp,
    super.key,
  });

  final ActionKey actionKey;
  final bool pressed;
  final VoidCallback onTapDown;
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
