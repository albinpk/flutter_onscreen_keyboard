import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';
import 'package:flutter_onscreen_keyboard/src/constants/action_key_type.dart';
import 'package:flutter_onscreen_keyboard/src/theme/onscreen_keyboard_theme.dart';
import 'package:flutter_onscreen_keyboard/src/types.dart';
import 'package:flutter_onscreen_keyboard/src/utils/extensions.dart';

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
    this.layout,
    this.theme,
    this.width,
    this.dragHandle,
    this.aspectRatio,
    this.showControlBar = true,
    this.buildControlBarActions,
  });

  /// The main application child widget.
  final Widget child;

  /// The layout configuration for the keyboard.
  ///
  /// If not provided, a default layout will be selected automatically
  /// based on the current [defaultTargetPlatform] — a [MobileKeyboardLayout]
  /// for Android/iOS/Fuchsia and a [DesktopKeyboardLayout] for
  /// macOS/Windows/Linux.
  final KeyboardLayout? layout;

  /// Custom theme for the on-screen keyboard UI.
  ///
  /// If not provided, a default theme based on
  /// the current [ThemeData] will be used.
  final OnscreenKeyboardThemeData? theme;

  /// An optional width configuration function for the keyboard.
  final WidthGetter? width;

  /// A widget displayed as a drag handle to move the keyboard.
  final Widget? dragHandle;

  /// {@macro keyboardLayout.aspectRatio}
  final double? aspectRatio;

  /// Whether to show the control bar at the top of the keyboard.
  /// Defaults to `true`.
  final bool showControlBar;

  /// {@macro controlBar.actions}
  final ActionsBuilder? buildControlBarActions;

  /// A builder to wrap the app with [OnscreenKeyboard].
  ///
  /// This provides a convenient way to globally integrate the
  /// on-screen keyboard into your app by setting it as the
  /// `builder` of your [MaterialApp] or [WidgetsApp].
  ///
  /// ### Example
  /// ```dart
  /// MaterialApp(
  ///   builder: OnscreenKeyboard.builder(
  ///     width: (context) => 600,
  ///     aspectRatio: 5 / 2,
  ///     // ...more options
  ///   ),
  ///   home: const HomeScreen(),
  /// );
  /// ```
  ///
  /// - [theme]: Custom theme configuration for the keyboard, such as color,
  ///   shadow, border, margin, and shape. If null, defaults will be applied.
  /// - [layout]: Keyboard layout to render. Falls back to default layout
  ///   if not set.
  /// - [width]: A function that returns the keyboard's width.
  /// - [showControlBar]: Whether to show the control bar at the top of the
  ///   keyboard. Defaults to `true`.
  /// - [dragHandle]: A widget to show as the drag handle above the keyboard.
  ///   If null, a default handle is shown.
  /// - [aspectRatio]: Determines the width-to-height ratio of the
  ///   keyboard widget.
  /// - [buildControlBarActions]: A callback that builds trailing action widgets
  ///   (e.g., move, close) in the keyboard's control bar. If omitted, default
  ///   actions are shown.
  ///
  /// Returns a [TransitionBuilder] to be passed to [MaterialApp.builder].
  ///
  /// See also:
  ///  - [OnscreenKeyboard.new], which creates an [OnscreenKeyboard] widget.
  static TransitionBuilder builder({
    OnscreenKeyboardThemeData? theme,
    KeyboardLayout? layout,
    WidthGetter? width,
    bool showControlBar = true,
    Widget? dragHandle,
    double? aspectRatio,
    ActionsBuilder? buildControlBarActions,
  }) => (BuildContext context, Widget? child) {
    return OnscreenKeyboard(
      theme: theme,
      layout: layout,
      width: width,
      showControlBar: showControlBar,
      dragHandle: dragHandle,
      aspectRatio: aspectRatio,
      buildControlBarActions: buildControlBarActions,
      child: child!,
    );
  };

  /// Gets the nearest [OnscreenKeyboardController] from the widget tree.
  static OnscreenKeyboardController of(BuildContext context) {
    final provider = context
        .getInheritedWidgetOfExactType<_OnscreenKeyboardProvider>();
    assert(
      provider != null,
      '''
No OnscreenKeyboard found in context. Did you wrap your app with OnscreenKeyboard?

    MaterialApp(
      builder: OnscreenKeyboard.builder(),  // <- add this line
      home: const App(),
    )
    ''',
    );
    return provider!.state;
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

  void _handleTexTextKeyDown(TextKey key) {
    if (activeTextField?.effectiveController case final controller?
        when controller.selection.isValid) {
      final keyText = key.getText(secondary: _showSecondary);
      final newText = controller.text.replaceRange(
        controller.start,
        controller.end,
        keyText,
      );
      controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: controller.start + keyText.length,
        ),
      );
    }
  }

  void _handleActionKeyDown(ActionKey key) {
    if (!key.canHold) {
      setState(() => _pressedActionKeys.add(key.name));
    }

    if (activeTextField?.effectiveController case final controller?
        when controller.selection.isValid) {
      switch (key.name) {
        case ActionKeyType.backspace:
          if (controller.text.isEmpty) return;
          String? newText;
          int? offset;
          if (!controller.selection.isCollapsed) {
            newText = controller.text.replaceRange(
              controller.start,
              controller.end,
              '',
            );
            offset = controller.start;
          } else if (controller.start > 0) {
            // handling emojis
            final leftSide = controller.text
                .substring(0, controller.start)
                .characters
                .toList();
            final rightSide = controller.text.substring(controller.start);
            offset = controller.start - leftSide.removeLast().length;
            newText = leftSide.join() + rightSide;
          }
          if (newText != null && offset != null) {
            controller.value = TextEditingValue(
              text: newText,
              selection: TextSelection.collapsed(offset: offset),
            );
          }

        case ActionKeyType.tab:
          if (!controller.selection.isValid) return;
          final newText = controller.text.replaceRange(
            controller.start,
            controller.end,
            '\t',
          );
          controller.value = TextEditingValue(
            text: newText,
            selection: TextSelection.collapsed(offset: controller.start + 1),
          );

        case ActionKeyType.enter:
          if (!controller.selection.isValid) return;
          if (activeTextField!.widget.maxLines == 1) {
            // if a single line field
            activeTextField!.effectiveFocusNode.unfocus();
            // close();
          } else {
            // if a multi line field
            final newText = controller.text.replaceRange(
              controller.start,
              controller.end,
              '\n',
            );
            controller.value = TextEditingValue(
              text: newText,
              selection: TextSelection.collapsed(offset: controller.start + 1),
            );
          }

        case ActionKeyType.capslock:
          break;
        case ActionKeyType.shift:
          break;
      }
    }
  }

  void _handleActionKeyUp(ActionKey key) {
    _safeSetState(() {
      if (key.canHold && !_pressedActionKeys.contains(key.name)) {
        _pressedActionKeys.add(key.name);
      } else {
        _pressedActionKeys.remove(key.name);
      }
    });
  }

  /// Safely call [setState] after the current frame.
  void _safeSetState(VoidCallback fn) {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(fn));
  }

  /// Whether the keyboard is currently visible.
  bool _visible = false;

  @override
  void open() => setState(() => _visible = true);

  @override
  void close() {
    detachTextField();
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

  @override
  void attachTextField(OnscreenKeyboardTextFieldState state) {
    _activeTextField.value = state;
  }

  @override
  void detachTextField([OnscreenKeyboardTextFieldState? state]) {
    if (state == null || state == activeTextField) {
      _activeTextField.value = null;
    }
  }

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

  /// Returns the default keyboard layout based on the current platform.
  KeyboardLayout _getDefaultLayout() => switch (defaultTargetPlatform) {
    TargetPlatform.android ||
    TargetPlatform.iOS ||
    TargetPlatform.fuchsia => const MobileKeyboardLayout(),
    TargetPlatform.macOS ||
    TargetPlatform.windows ||
    TargetPlatform.linux => const DesktopKeyboardLayout(),
  };

  /// The resolved layout used by the keyboard.
  late final KeyboardLayout _layout = widget.layout ?? _getDefaultLayout();

  /// The current active keyboard mode (e.g., "alphabetic", "symbols").
  ///
  /// This determines which layout mode from [KeyboardLayout.modes] is used.
  late String _mode = _layout.modes.keys.first;

  @override
  void switchMode() {
    final modes = _layout.modes.keys.toList();
    final i = modes.indexOf(_mode);
    setState(() => _mode = modes[(i + 1) % modes.length]);
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
    assert(
      _layout.modes.isNotEmpty,
      'Keyboard layout must have at least one mode defined.',
    );

    return _OnscreenKeyboardProvider(
      state: this,
      child: Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (context) => OnscreenKeyboardTheme(
              data: widget.theme ?? const OnscreenKeyboardThemeData(),
              child: Stack(
                children: [
                  // the app widget
                  widget.child,

                  // keyboard
                  if (_visible)
                    Positioned.fill(
                      child: SafeArea(
                        child: Builder(
                          builder: (context) {
                            // drag handle keyboard widget
                            final dragHandle = GestureDetector(
                              onPanStart: (_) => _draggingListener.value = true,
                              onPanCancel: () =>
                                  _draggingListener.value = false,
                              onPanDown: (_) => _draggingListener.value = true,
                              onPanEnd: (_) => _draggingListener.value = false,
                              onPanUpdate: (details) {
                                final keyboardSize =
                                    _keyboardKey.currentContext!.size!;
                                _alignListener.value = (
                                  (_alignListener.value.$1 +
                                          details.delta.dx /
                                              (context.size!.width -
                                                  keyboardSize.width))
                                      .clamp(0.0, 1.0),
                                  (_alignListener.value.$2 +
                                          details.delta.dy /
                                              (context.size!.height -
                                                  keyboardSize.height))
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
                            final keyboard = TextFieldTapRegion(
                              // theme override for modes
                              child: OnscreenKeyboardTheme(
                                data:
                                    _layout.modes[_mode]!.theme?.call(
                                      context,
                                    ) ??
                                    context.theme,
                                child: Builder(
                                  key: _keyboardKey,
                                  builder: (context) {
                                    final colors = Theme.of(
                                      context,
                                    ).colorScheme;
                                    final theme = context.theme;
                                    final borderRadius =
                                        theme.borderRadius ??
                                        BorderRadius.circular(6);
                                    return Material(
                                      type: MaterialType.transparency,
                                      child: Container(
                                        width: widget.width?.call(context),
                                        margin: theme.margin,
                                        padding: theme.padding,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          color: theme.color,
                                          borderRadius: borderRadius,
                                          gradient: theme.gradient,
                                          boxShadow:
                                              theme.boxShadow ??
                                              [
                                                BoxShadow(
                                                  color: colors.shadow.fade(
                                                    0.05,
                                                  ),
                                                  spreadRadius: 5,
                                                  blurRadius: 5,
                                                ),
                                              ],
                                        ),
                                        foregroundDecoration: BoxDecoration(
                                          borderRadius: borderRadius,
                                          border:
                                              theme.border ??
                                              Border.all(
                                                color: colors.outline.fade(),
                                              ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (widget.showControlBar)
                                              _ControlBar(
                                                dragHandle: dragHandle,
                                                actions: widget
                                                    .buildControlBarActions
                                                    ?.call(context),
                                              ),
                                            RawOnscreenKeyboard(
                                              aspectRatio: widget.aspectRatio,
                                              onKeyDown: _onKeyDown,
                                              onKeyUp: _onKeyUp,
                                              layout: _layout,
                                              mode: _mode,
                                              pressedActionKeys:
                                                  _pressedActionKeys,
                                              showSecondary: _showSecondary,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
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
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
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
    final theme = context.theme;

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
      color: theme.controlBarColor ?? colors.surfaceContainer,
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

/// An [InheritedWidget] that provides [OnscreenKeyboardController]
/// to its descendants.
class _OnscreenKeyboardProvider extends InheritedWidget {
  const _OnscreenKeyboardProvider({
    required this.state,
    required super.child,
  });

  /// The state of the nearest [OnscreenKeyboard] in the widget tree.
  final _OnscreenKeyboardState state;

  @override
  bool updateShouldNotify(_OnscreenKeyboardProvider oldWidget) =>
      oldWidget.state != state;
}
