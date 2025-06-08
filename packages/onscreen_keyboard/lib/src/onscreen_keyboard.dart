import 'dart:developer' as dev;
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/cupertino.dart' show CupertinoThemeData;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onscreen_keyboard/src/layouts/desktop_layout.dart';
import 'package:onscreen_keyboard/src/models/keys.dart';
import 'package:onscreen_keyboard/src/raw_onscreen_keyboard.dart';
import 'package:onscreen_keyboard/src/theme/onscreen_keyboard_theme.dart';
import 'package:onscreen_keyboard/src/theme/onscreen_keyboard_theme_data.dart';
import 'package:onscreen_keyboard/src/utils/extensions.dart';

part 'onscreen_keyboard_controller.dart';
part 'onscreen_keyboard_text_field.dart';

void _l(Object? object, [String prefix = '']) =>
    dev.log('$prefix$object', name: 'onscreen_keyboard');

class OnscreenKeyboard extends StatefulWidget {
  const OnscreenKeyboard({required this.child, super.key});

  final Widget child;

  static TransitionBuilder builder({OnscreenKeyboardThemeData? theme}) {
    return (BuildContext context, Widget? child) {
      return OnscreenKeyboardTheme(
        data: theme ?? const OnscreenKeyboardThemeData(),
        child: OnscreenKeyboard(child: child!),
      );
    };
  }

  static OnscreenKeyboardController of(BuildContext context) {
    return context.findAncestorStateOfType<OnscreenKeyboardState>()!;
  }

  @override
  State<OnscreenKeyboard> createState() => OnscreenKeyboardState();
}

class OnscreenKeyboardState extends State<OnscreenKeyboard>
    implements OnscreenKeyboardController {
  bool get _showSecondary =>
      _pressedActionKeys.contains(ActionKeyType.capslock) ^
      _pressedActionKeys.contains(ActionKeyType.shift);

  final _pressedActionKeys = <String>{};

  void _onKeyDown(OnscreenKeyboardKey key) {
    switch (key) {
      case TextKey():
        _handleTexTextKeyDown(key);
      case ActionKey():
        _handleActionKeyDown(key);
    }
  }

  void _onKeyUp(OnscreenKeyboardKey key) {
    switch (key) {
      case TextKey():
        break;
      case ActionKey():
        _handleActionKeyUp(key);
    }
  }

  void _handleTexTextKeyDown(TextKey key) {
    if (activeTextField == null && _activeController == null) return;
    (activeTextField?.effectiveController ?? _activeController!.controller)
        .text += key.getText(
      secondary: _showSecondary,
    );
  }

  void _handleActionKeyDown(ActionKey key) {
    if (!key.canHold) {
      setState(() => _pressedActionKeys.add(key.name));
    }

    if (activeTextField == null && _activeController == null) return;
    final controller =
        activeTextField?.effectiveController ?? _activeController!.controller;
    // final f =
    //     activeTextField?.effectiveFocusNode ?? _activeController!.focusNode;

    switch (key.name) {
      case ActionKeyType.backspace:
        if (controller.text.isNotEmpty) {
          controller.text = controller.text.substring(
            0,
            controller.text.length - 1,
          );
        }

      case ActionKeyType.tab:
        controller.text += '\t';

      case ActionKeyType.enter:
        controller.text += '\n';

      case ActionKeyType.capslock:
      case ActionKeyType.shift:
    }

    // f?.requestFocus();
  }

  void _handleActionKeyUp(ActionKey key) {
    setState(() {
      if (key.canHold && !_pressedActionKeys.contains(key.name)) {
        _pressedActionKeys.add(key.name);
      } else {
        _pressedActionKeys.remove(key.name);
      }
    });
  }

  bool _visible = false;

  @override
  void open() => setState(() => _visible = true);

  @override
  void close() {
    detachTextField();
    detachTextController();
    setState(() => _visible = false);
  }

  Alignment _alignment = Alignment.bottomCenter;

  @override
  void moveToTop() => setState(() => _alignment = Alignment.topCenter);

  @override
  void moveToBottom() => setState(() => _alignment = Alignment.bottomCenter);

  ({TextEditingController controller, FocusNode? focusNode})? _activeController;

  @override
  void attachTextController(
    TextEditingController controller, {
    FocusNode? focusNode,
  }) {
    detachTextField();
    _activeController = (controller: controller, focusNode: focusNode);
    _l('controller attached');
  }

  @override
  void detachTextController() {
    _activeController = null;
    _l('controller detached');
  }

  @override
  void attachTextField(OnscreenKeyboardTextFieldState state) {
    detachTextController();
    _activeTextField.value = state;
    _l('textfield attached');
  }

  @override
  void detachTextField([OnscreenKeyboardTextFieldState? state]) {
    if (state == null) {
      _activeTextField.value = null;
      _l('textfield detached');
    } else if (state == _activeTextField.value) {
      _activeTextField.value = null;
      _l('textfield detached');
    }
  }

  @override
  final _activeTextController = ValueNotifier<TextEditingController?>(null);

  TextEditingController? get activeTextController =>
      _activeTextController.value;

  @override
  final _activeTextField = ValueNotifier<OnscreenKeyboardTextFieldState?>(null);

  OnscreenKeyboardTextFieldState? get activeTextField => _activeTextField.value;

  @override
  Widget build(BuildContext context) {
    if (!_visible) return widget.child;

    return Stack(
      children: [
        widget.child,

        // keyboard
        Positioned.fill(
          child: Align(
            alignment: _alignment,
            child: Builder(
              builder: (context) {
                final colors = Theme.of(context).colorScheme;
                final theme = context.theme;
                final borderRadius =
                    theme.borderRadius ?? BorderRadius.circular(6);
                return Material(
                  type: MaterialType.transparency,
                  child: Container(
                    margin: theme.margin,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: theme.color,
                      borderRadius: borderRadius,
                    ),
                    foregroundDecoration: BoxDecoration(
                      borderRadius: borderRadius,
                      border: theme.border ?? Border.all(color: colors.outline),
                    ),

                    // ??
                    // BoxDecoration(
                    //   borderRadius: BorderRadius.circular(6),
                    //   border: Border.all(
                    //     color: colors.outline,
                    //   ),
                    // ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const _ControlBar(),
                        // RawOnscreenKeyboard(onKeyPressed: _onKeyPressed),
                        RawOnscreenKeyboard(
                          onKeyDown: _onKeyDown,
                          onKeyUp: _onKeyUp,
                          layout: DesktopKeyboardLayout(),
                          pressedActionKeys: _pressedActionKeys,
                          showSecondary: _showSecondary,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ControlBar extends StatelessWidget {
  const _ControlBar();

  @override
  Widget build(BuildContext context) {
    return IconButtonTheme(
      data: IconButtonThemeData(style: IconButton.styleFrom(iconSize: 16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () => OnscreenKeyboard.of(context).moveToBottom(),
            icon: const Icon(Icons.arrow_downward_rounded),
          ),
          IconButton(
            onPressed: () => OnscreenKeyboard.of(context).moveToTop(),
            icon: const Icon(Icons.arrow_upward_rounded),
          ),
          IconButton(
            onPressed: () => OnscreenKeyboard.of(context).close(),
            icon: const Icon(Icons.close_rounded),
          ),
        ],
      ),
    );
  }
}
