part of 'onscreen_keyboard.dart';

class OnscreenKeyboardTextField extends StatefulWidget {
  const OnscreenKeyboardTextField({
    super.key,
    this.controller,
    this.focusNode,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;

  @override
  State<OnscreenKeyboardTextField> createState() =>
      OnscreenKeyboardTextFieldState();
}

class OnscreenKeyboardTextFieldState extends State<OnscreenKeyboardTextField> {
  TextEditingController? _controller;
  TextEditingController get effectiveController =>
      widget.controller ?? (_controller ??= TextEditingController());

  FocusNode? _focusNode;
  FocusNode get effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= FocusNode());

  late final OnscreenKeyboardController keyboard;

  @override
  void initState() {
    super.initState();
    keyboard = OnscreenKeyboard.of(context);
    effectiveFocusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    keyboard.detachTextField(this);
    effectiveFocusNode.removeListener(_onFocusChanged);
    _focusNode?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    if (effectiveFocusNode.hasPrimaryFocus) {
      keyboard
        ..attachTextField(this)
        ..open();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: OnscreenKeyboard.of(context)._activeTextField,
      builder: (context, value, c) {
        final theme = Theme.of(context);
        final border = value == this
            ? theme.inputDecorationTheme.focusedBorder ??
                  UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 2,
                    ),
                  )
            : null;
        return TextField(
          controller: effectiveController,
          focusNode: effectiveFocusNode,
          decoration: InputDecoration(
            enabledBorder: border,
          ),
        );
      },
    );
  }
}
