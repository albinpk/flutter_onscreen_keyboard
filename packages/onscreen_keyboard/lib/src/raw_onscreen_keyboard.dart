import 'package:flutter/material.dart';
import 'package:onscreen_keyboard/src/models/keys.dart';
import 'package:onscreen_keyboard/src/models/layout.dart';
import 'package:onscreen_keyboard/src/widgets/keys.dart';

class RawOnscreenKeyboard extends StatelessWidget {
  const RawOnscreenKeyboard({
    required this.onKeyDown,
    required this.onKeyUp,
    required this.layout,
    this.showSecondary = false,
    super.key,
    this.pressedActionKeys = const {},
  });

  final ValueChanged<OnscreenKeyboardKey> onKeyDown;
  final ValueChanged<OnscreenKeyboardKey> onKeyUp;
  final KeyboardLayout layout;
  final Set<String> pressedActionKeys;
  final bool showSecondary;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5 / 2,
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          children: [
            for (final row in layout.rows)
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
