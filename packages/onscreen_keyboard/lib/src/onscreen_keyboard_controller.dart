part of 'onscreen_keyboard.dart';

abstract interface class OnscreenKeyboardController {
  void open();

  void close();

  void moveToTop();

  void moveToBottom();

  void attachTextController(
    TextEditingController controller, {
    FocusNode? focusNode,
  });

  void detachTextController();

  void attachTextField(OnscreenKeyboardTextFieldState state);

  void detachTextField([OnscreenKeyboardTextFieldState? state]);

  // private

  ValueNotifier<TextEditingController?> get _activeTextController;

  ValueNotifier<OnscreenKeyboardTextFieldState?> get _activeTextField;
}
