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
      builder: OnscreenKeyboard.builder(
        width: (context) => MediaQuery.sizeOf(context).width / 2,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                    OnscreenKeyboard.of(context).open();
                  },
                  child: const Text('Open Keyboard'),
                ),
                TextButton(
                  onPressed: () {
                    OnscreenKeyboard.of(context).close();
                  },
                  child: const Text('Close Keyboard'),
                ),

                const OnscreenKeyboardTextField(),
                const OnscreenKeyboardTextField(),
                const OnscreenKeyboardTextField(maxLines: null),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
