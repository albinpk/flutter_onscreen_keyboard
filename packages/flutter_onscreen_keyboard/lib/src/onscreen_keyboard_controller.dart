part of 'onscreen_keyboard.dart';

/// An interface for controlling the [OnscreenKeyboard] programmatically.
///
/// This allows opening and closing the keyboard, changing its alignment,
/// managing focus and text input sources, and adding listeners
/// for raw key events.
///
/// > **Note:** Only one input source can be active at a time.
/// Either use [attachTextField] for a custom [OnscreenKeyboardTextField], or
/// [attachTextController] for a standard [TextEditingController]-based input.
/// Using both simultaneously is not supported.
abstract interface class OnscreenKeyboardController {
  /// Opens the onscreen keyboard.
  void open();

  /// Closes the onscreen keyboard.
  void close();

  /// Sets the alignment of the onscreen keyboard.
  ///
  /// [alignment] defines where the keyboard should appear in the app.
  void setAlignment(Alignment alignment);

  /// Moves the keyboard to the top-center of the available screen space.
  void moveToTop();

  /// Moves the keyboard to the bottom-center of the available screen space.
  void moveToBottom();

  /// Attaches an [OnscreenKeyboardTextFieldState] to the keyboard,
  /// making it the active input field for text input.
  ///
  /// > This will automatically detach any previously attached
  /// [TextEditingController] or [OnscreenKeyboardTextField].
  void attachTextField(OnscreenKeyboardTextFieldState state);

  /// Detaches a previously attached [OnscreenKeyboardTextFieldState].
  ///
  /// If no [state] is provided, detaches the currently active one.
  void detachTextField([OnscreenKeyboardTextFieldState? state]);

  /// Adds a listener to receive raw key down events from the keyboard.
  ///
  /// Useful for handling custom shortcuts or key-based interactions.
  void addRawKeyDownListener(OnscreenKeyboardListener listener);

  /// Removes a previously added raw key down listener.
  void removeRawKeyDownListener(OnscreenKeyboardListener listener);

  /// Attaches a [TextEditingController] (and optional [FocusNode]) to
  /// the keyboard.
  ///
  /// This enables text input for standard Flutter text fields.
  ///
  /// > This will automatically detach any previously attached
  /// [OnscreenKeyboardTextField] or [TextEditingController].
  void attachTextController(
    TextEditingController controller, {
    FocusNode? focusNode,
  });

  /// Detaches the currently attached [TextEditingController], if any.
  void detachTextController();

  /// Returns a [ValueNotifier] of the currently active
  /// [OnscreenKeyboardTextFieldState].
  ///
  /// This is intended for internal use.
  ValueNotifier<OnscreenKeyboardTextFieldState?> get _activeTextField;
}
