import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  KeyboardLayout _selectedLayout = const MobileKeyboardLayout();

  void _updateLayout(KeyboardLayout layout) {
    setState(() {
      _selectedLayout = layout;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // use OnscreenKeyboard.builder on MaterialApp.builder
      builder: OnscreenKeyboard.builder(
        width: (context) => MediaQuery.sizeOf(context).width / 2,
        layout: (context) => _selectedLayout,
        // ...more options
      ),

      // or

      // builder: (context, child) {
      //   // your other codes
      //   // child = ...;

      //   // wrap with OnscreenKeyboard
      //   return OnscreenKeyboard(child: child!);
      // },
      home: HomeScreen(onLayoutChange: _updateLayout),
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onLayoutChange});

  final void Function(KeyboardLayout layout) onLayoutChange;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final keyboard = OnscreenKeyboard.of(context);

  final _formFieldKey = GlobalKey<FormFieldState<String>>();
  String _selectedLanguage = 'English';

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

  void _changeKeyboardLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });

    final KeyboardLayout layout = switch (language) {
      'Russian' => const RussianMobileKeyboardLayout(),
      'Kazakh' => const KazakhMobileKeyboardLayout(),
      _ => const MobileKeyboardLayout(), // English
    };

    widget.onLayoutChange(layout);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 300,
              child: Column(
                spacing: 20,
                children: [
                  const SizedBox(height: 10),

                  // Language selector
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Keyboard Language',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SegmentedButton<String>(
                            segments: const [
                              ButtonSegment(
                                value: 'English',
                                label: Text('EN'),
                              ),
                              ButtonSegment(
                                value: 'Russian',
                                label: Text('RU'),
                              ),
                              ButtonSegment(
                                value: 'Kazakh',
                                label: Text('KZ'),
                              ),
                            ],
                            selected: {_selectedLanguage},
                            onSelectionChanged: (Set<String> newSelection) {
                              _changeKeyboardLanguage(newSelection.first);
                            },
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Current: $_selectedLanguage',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

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
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                  ),

                  // you can disable the keyboard if you want
                  const OnscreenKeyboardTextField(
                    enableOnscreenKeyboard: false,
                    decoration: InputDecoration(
                      labelText: 'Email (normal keyboard)',
                    ),
                  ),

                  // a multiline TextField
                  const OnscreenKeyboardTextField(
                    decoration: InputDecoration(
                      labelText: 'Address',
                    ),
                    maxLines: null,
                  ),

                  // form field
                  OnscreenKeyboardTextFormField(
                    formFieldKey: _formFieldKey,
                    decoration: const InputDecoration(
                      labelText: 'Note',
                    ),
                    onChanged: (value) {
                      _formFieldKey.currentState?.validate();
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
