part of 'onscreen_keyboard.dart';

abstract interface class OnscreenKeyboardController {
  void open();

  void close();

  void setAlignment(Alignment alignment);

  void moveToTop();

  void moveToBottom();

  void attachTextField(OnscreenKeyboardTextFieldState state);

  void detachTextField([OnscreenKeyboardTextFieldState? state]);

  void addRawKeyDownListener(OnscreenKeyboardListener listener);

  void removeRawKeyDownListener(OnscreenKeyboardListener listener);

  void attachTextController(
    TextEditingController controller, {
    FocusNode? focusNode,
  });

  void detachTextController();

  // private

  // ValueNotifier<TextEditingController?> get _activeTextController;

  ValueNotifier<OnscreenKeyboardTextFieldState?> get _activeTextField;
}
