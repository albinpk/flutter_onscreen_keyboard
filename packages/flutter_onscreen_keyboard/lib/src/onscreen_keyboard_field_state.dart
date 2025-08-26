part of 'onscreen_keyboard.dart';

/// An interface that defines the contract for the state of an
/// onscreen keyboard field.
abstract interface class OnscreenKeyboardFieldState {
  /// The [TextEditingController] associated with the field.
  TextEditingController get controller;

  /// The [FocusNode] associated with the field.
  FocusNode get focusNode;

  /// The maxLines property of the field.
  int? get maxLines;
}
