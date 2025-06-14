import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';
import 'package:flutter_onscreen_keyboard/src/layouts/desktop_layout.dart';
import 'package:flutter_onscreen_keyboard/src/theme/onscreen_keyboard_theme.dart';
import 'package:flutter_onscreen_keyboard/src/types.dart';
import 'package:flutter_onscreen_keyboard/src/utils/extensions.dart';
import 'package:flutter_onscreen_keyboard/src/widgets/post_frame_value_listenable_builder.dart';

part 'onscreen_keyboard_controller.dart';
part 'onscreen_keyboard_text_field.dart';

/// A customizable on-screen keyboard widget.
///
/// Wrap your application with this widget to enable the
/// on-screen keyboard functionality.
class OnscreenKeyboard extends StatefulWidget {
  /// Creates an [OnscreenKeyboard].
  const OnscreenKeyboard({
    required this.child,
    super.key,
    this.width,
    this.dragHandle,
    this.aspectRatio,
    this.buildControlBarActions,
  });

  /// The main application child widget.
  final Widget child;

  /// An optional width configuration function for the keyboard.
  final WidthGetter? width;

  /// A widget displayed as a drag handle to move the keyboard.
  final Widget? dragHandle;

  /// {@macro keyboardLayout.aspectRatio}
  final double? aspectRatio;

  /// {@macro controlBar.actions}
  final ActionsBuilder? buildControlBarActions;

  /// A builder to wrap the app with [OnscreenKeyboard].
  ///
  /// Usage:
  /// ```dart
  /// MaterialApp(
  ///   builder: OnscreenKeyboard.builder(),
  ///   home: const HomeScreen(),
  /// );
  /// ```
  static TransitionBuilder builder({
    OnscreenKeyboardThemeData? theme,
    WidthGetter? width,
    Widget? dragHandle,
    double? aspectRatio,
    ActionsBuilder? buildControlBarActions,
  }) => (BuildContext context, Widget? child) {
    return wrap(
      theme: theme,
      width: width,
      dragHandle: dragHandle,
      aspectRatio: aspectRatio,
      buildControlBarActions: buildControlBarActions,
      child: child!,
    );
  };

  /// Wraps a given widget with the on-screen keyboard overlay.
  ///
  /// Usage:
  /// ```dart
  /// MaterialApp(
  ///  builder: (context, child) {
  ///    // your other codes
  ///    child = Builder(builder: (context) => child!);
  ///    // wrap with OnscreenKeyboard.wrap
  ///    return OnscreenKeyboard.wrap(child: child);
  ///  },
  ///  home: const HomeScreen(),
  /// );
  /// ```
  static Widget wrap({
    required Widget child,
    OnscreenKeyboardThemeData? theme,
    WidthGetter? width,
    Widget? dragHandle,
    double? aspectRatio,
    ActionsBuilder? buildControlBarActions,
  }) {
    return Overlay(
      initialEntries: [
        OverlayEntry(
          builder: (context) => OnscreenKeyboardTheme(
            data: theme ?? const OnscreenKeyboardThemeData(),
            child: OnscreenKeyboard(
              width: width,
              dragHandle: dragHandle,
              aspectRatio: aspectRatio,
              buildControlBarActions: buildControlBarActions,
              child: child,
            ),
          ),
        ),
      ],
    );
  }

  /// Gets the nearest [OnscreenKeyboardController] from the widget tree.
  static OnscreenKeyboardController of(BuildContext context) {
    return context.findAncestorStateOfType<_OnscreenKeyboardState>()!;
  }

  @override
  State<OnscreenKeyboard> createState() => _OnscreenKeyboardState();
}

class _OnscreenKeyboardState extends State<OnscreenKeyboard>
    implements OnscreenKeyboardController {
  /// Whether to show the secondary keys.
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

    for (final listener in _rawKeyDownListeners) {
      listener(key);
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

  /// Text selection position.
  int _position = 0;

  void _handleTexTextKeyDown(TextKey key) {
    if (activeTextField == null && _activeController == null) return;

    final controller =
        activeTextField?.effectiveController ?? _activeController!.controller;
    var text = controller.text;
    if (controller.selection.isValid) {
      _position = controller.selection.start;
      if (!controller.selection.isCollapsed) {
        text = text.replaceRange(_position, controller.selection.end, '');
      }
    }
    controller.text = text.replaceRange(
      _position,
      _position++, // update position
      key.getText(secondary: _showSecondary),
    );
  }

  void _handleActionKeyDown(ActionKey key) {
    if (!key.canHold) {
      setState(() => _pressedActionKeys.add(key.name));
    }

    if (activeTextField == null && _activeController == null) return;
    final isTextField = activeTextField != null;
    final controller =
        activeTextField?.effectiveController ?? _activeController!.controller;
    // final f =
    //     activeTextField?.effectiveFocusNode ?? _activeController!.focusNode;

    switch (key.name) {
      case ActionKeyType.backspace:
        if (controller.text.isEmpty) return;
        final selection = controller.selection;
        if (selection.isValid) _position = selection.start;
        if (!selection.isCollapsed) {
          controller.text = controller.text.replaceRange(
            _position,
            selection.end,
            '',
          );
        } else if (_position > 0) {
          controller.text = controller.text.replaceRange(
            _position - 1,
            _position--, // update position
            '',
          );
        }

      case ActionKeyType.tab:
        final selection = controller.selection;
        if (selection.isValid) _position = selection.start;
        if (!selection.isCollapsed) {
          controller.text = controller.text.replaceRange(
            _position,
            selection.end,
            '\t',
          );
        } else {
          controller.text = controller.text.replaceRange(
            _position,
            _position++, // update position
            '\t',
          );
        }

      case ActionKeyType.enter:
        if (isTextField) {
          if (activeTextField!.widget.maxLines == 1) {
            detachTextField();
          } else {
            final selection = controller.selection;
            if (selection.isValid) _position = selection.start;
            if (!selection.isCollapsed) {
              controller.text = controller.text.replaceRange(
                _position++, // update position
                selection.end,
                '\n',
              );
            } else {
              controller.text = controller.text.replaceRange(
                _position,
                _position++, // update position
                '\n',
              );
            }
          }
        }

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

  /// Whether the keyboard is currently visible.
  bool _visible = false;

  @override
  void open() => setState(() => _visible = true);

  @override
  void close() {
    detachTextField();
    detachTextController();
    setState(() => _visible = false);
  }

  @override
  void setAlignment(Alignment alignment) {
    _alignListener.value = ((alignment.x + 1) / 2, (alignment.y + 1) / 2);
  }

  @override
  void moveToTop() => setAlignment(Alignment.topCenter);

  @override
  void moveToBottom() => setAlignment(Alignment.bottomCenter);

  ({TextEditingController controller, FocusNode? focusNode})? _activeController;

  @override
  void attachTextController(
    TextEditingController controller, {
    FocusNode? focusNode,
  }) {
    detachTextField();
    _activeController = (controller: controller, focusNode: focusNode);
  }

  @override
  void detachTextController() {
    _activeController = null;
  }

  @override
  void attachTextField(OnscreenKeyboardTextFieldState state) {
    detachTextController();
    _activeTextField.value = state;
  }

  @override
  void detachTextField([OnscreenKeyboardTextFieldState? state]) {
    if (state == null) {
      _activeTextField.value = null;
    } else if (state == _activeTextField.value) {
      _activeTextField.value = null;
    }
  }

  // @override
  // final _activeTextController = ValueNotifier<TextEditingController?>(null);

  // TextEditingController? get activeTextController =>
  //     _activeTextController.value;

  @override
  final _activeTextField = ValueNotifier<OnscreenKeyboardTextFieldState?>(null);

  OnscreenKeyboardTextFieldState? get activeTextField => _activeTextField.value;

  /// List of raw key down listeners.
  final _rawKeyDownListeners = ObserverList<OnscreenKeyboardListener>();

  @override
  void addRawKeyDownListener(OnscreenKeyboardListener listener) {
    _rawKeyDownListeners.add(listener);
  }

  @override
  void removeRawKeyDownListener(OnscreenKeyboardListener listener) {
    _rawKeyDownListeners.remove(listener);
  }

  final GlobalKey _keyboardKey = GlobalKey();

  /// Alignment of the keyboard
  final ValueNotifier<(double, double)> _alignListener = ValueNotifier((.5, 1));

  /// Whether the keyboard is currently being dragged.
  final ValueNotifier<bool> _draggingListener = ValueNotifier(false);

  @override
  void dispose() {
    _alignListener.dispose();
    _draggingListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) return widget.child;

    return Stack(
      children: [
        widget.child,

        // keyboard
        Positioned.fill(
          child: Builder(
            builder: (context) {
              // drag handle keyboard widget
              final dragHandle = GestureDetector(
                onPanStart: (_) => _draggingListener.value = true,
                onPanCancel: () => _draggingListener.value = false,
                onPanDown: (_) => _draggingListener.value = true,
                onPanEnd: (_) => _draggingListener.value = false,
                onPanUpdate: (details) {
                  final keyboardSize = _keyboardKey.currentContext!.size!;
                  _alignListener.value = (
                    (_alignListener.value.$1 +
                            details.delta.dx /
                                (context.size!.width - keyboardSize.width))
                        .clamp(0.0, 1.0),
                    (_alignListener.value.$2 +
                            details.delta.dy /
                                (context.size!.height - keyboardSize.height))
                        .clamp(0.0, 1.0),
                  );
                },
                child: ValueListenableBuilder(
                  valueListenable: _draggingListener,
                  builder: (context, value, child) {
                    // user defined drag handle
                    if (child != null) return child;
                    return IconButton(
                      mouseCursor: value
                          ? SystemMouseCursors.grabbing
                          : SystemMouseCursors.grab,
                      onPressed: null,
                      icon: Icon(
                        Icons.drag_handle_rounded,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    );
                  },
                  child: widget.dragHandle,
                ),
              );

              // keyboard widget
              final keyboard = Builder(
                key: _keyboardKey,
                builder: (context) {
                  final colors = Theme.of(context).colorScheme;
                  final theme = context.theme;
                  final borderRadius =
                      theme.borderRadius ?? BorderRadius.circular(6);
                  return Material(
                    type: MaterialType.transparency,
                    child: Container(
                      width: widget.width?.call(context),
                      margin: theme.margin,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: theme.color,
                        borderRadius: borderRadius,
                        gradient: theme.gradient,
                        boxShadow:
                            theme.boxShadow ??
                            [
                              BoxShadow(
                                color: colors.shadow.fade(0.05),
                                spreadRadius: 5,
                                blurRadius: 5,
                              ),
                            ],
                      ),
                      foregroundDecoration: BoxDecoration(
                        borderRadius: borderRadius,
                        border:
                            theme.border ??
                            Border.all(color: colors.outline.fade()),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _ControlBar(
                            dragHandle: dragHandle,
                            actions: widget.buildControlBarActions?.call(
                              context,
                            ),
                          ),
                          RawOnscreenKeyboard(
                            aspectRatio: widget.aspectRatio,
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
              );

              return AnimatedBuilder(
                animation: _alignListener,
                builder: (context, child) {
                  return Align(
                    alignment: Alignment(
                      _alignListener.value.$1 * 2 - 1,
                      _alignListener.value.$2 * 2 - 1,
                    ),
                    child: child,
                  );
                },
                child: keyboard,
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Default control bar widget used in the on-screen keyboard.
///
/// This bar typically appears at the top of the keyboard and provides:
class _ControlBar extends StatelessWidget {
  /// Creates a control bar for the on-screen keyboard.
  const _ControlBar({
    required this.dragHandle,
    this.actions,
  });

  /// A widget used for dragging the keyboard.
  final Widget dragHandle;

  /// {@template controlBar.actions}
  /// Optional custom action widgets shown on the right side of the control bar.
  ///
  /// If not provided or is empty, default actions are shown:
  /// - Move to bottom
  /// - Move to top
  /// - Close keyboard
  /// {@endtemplate}
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final Widget trailing;
    if (actions != null && actions!.isNotEmpty) {
      trailing = Row(
        mainAxisSize: MainAxisSize.min,
        children: actions!,
      );
    } else {
      trailing = Flexible(
        child: FittedBox(
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  OnscreenKeyboard.of(context).moveToBottom();
                },
                icon: const Icon(Icons.arrow_downward_rounded),
                tooltip: 'Move to bottom',
              ),
              IconButton(
                onPressed: () {
                  OnscreenKeyboard.of(context).moveToTop();
                },
                icon: const Icon(Icons.arrow_upward_rounded),
                tooltip: 'Move to top',
              ),
              IconButton(
                onPressed: () {
                  OnscreenKeyboard.of(context).close();
                },
                icon: const Icon(Icons.close_rounded),
                tooltip: 'Close',
              ),
            ],
          ),
        ),
      );
    }

    return Material(
      color: colors.surfaceContainer,
      child: IconButtonTheme(
        data: IconButtonThemeData(style: IconButton.styleFrom(iconSize: 16)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            dragHandle,
            trailing,
          ],
        ),
      ),
    );
  }
}
