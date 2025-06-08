import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:onscreen_keyboard/onscreen_keyboard.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // use OnscreenKeyboard.builder on MaterialApp.builder
      builder: OnscreenKeyboard.builder(
        width: (context) => MediaQuery.sizeOf(context).width / 2,
        // ...more options
      ),

      // or

      // builder: (context, child) {
      //   // your other codes
      //   child = Builder(builder: (context) => child!);
      //   // wrap with OnscreenKeyboard.wrap
      //   return OnscreenKeyboard.wrap(child: child);
      // },
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final keyboard = OnscreenKeyboard.of(context);

  @override
  void initState() {
    super.initState();
    // listener for raw keyboard events
    keyboard.addRawKeyDownListener(_listener);
  }

  @override
  void dispose() {
    keyboard.removeRawKeyDownListener(_listener);
    super.dispose();
  }

  void _listener(OnscreenKeyboardKey key) {
    switch (key) {
      case TextKey(:final primary): // a text key: "a", "b", "4", etc.
        log('key: "$primary"');
      case ActionKey(:final name): // a action key: "shift", "backspace", etc.
        log('action: $name');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              children: [
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () {
                    // open the keyboard from anywhere using
                    OnscreenKeyboard.of(context).open();
                  },
                  child: const Text('Open Keyboard'),
                ),
                TextButton(
                  onPressed: () {
                    // close the keyboard from anywhere using
                    OnscreenKeyboard.of(context).close();
                  },
                  child: const Text('Close Keyboard'),
                ),

                // TextField that opens the keyboard on focus
                const OnscreenKeyboardTextField(
                  // enableOnscreenKeyboard: false,
                ),

                // you can disable the keyboard if you want
                const OnscreenKeyboardTextField(
                  enableOnscreenKeyboard: false,
                ),

                // a multiline TextField
                const OnscreenKeyboardTextField(maxLines: null),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
