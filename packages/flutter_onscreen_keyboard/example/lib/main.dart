import 'dart:developer';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_onscreen_keyboard/flutter_onscreen_keyboard.dart';

void main() {
  runApp(const App());
}

enum KeyboardLanguage { english, russian, kazakh }

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  KeyboardLanguage _currentLanguage = KeyboardLanguage.english;

  // Determine if we're on desktop or mobile
  bool get _isDesktop {
    if (kIsWeb) return false;
    return Platform.isMacOS || Platform.isWindows || Platform.isLinux;
  }

  KeyboardLayout _getLayout() {
    if (_isDesktop) {
      return switch (_currentLanguage) {
        KeyboardLanguage.english => const DesktopEnglishKeyboardLayout(),
        KeyboardLanguage.russian => const DesktopRussianKeyboardLayout(),
        KeyboardLanguage.kazakh => const DesktopKazakhKeyboardLayout(),
      };
    } else {
      return switch (_currentLanguage) {
        KeyboardLanguage.english => const MobileKeyboardLayout(),
        KeyboardLanguage.russian => const RussianMobileKeyboardLayout(),
        KeyboardLanguage.kazakh => const KazakhMobileKeyboardLayout(),
      };
    }
  }

  void _switchLanguage() {
    setState(() {
      _currentLanguage = switch (_currentLanguage) {
        KeyboardLanguage.english => KeyboardLanguage.russian,
        KeyboardLanguage.russian => KeyboardLanguage.kazakh,
        KeyboardLanguage.kazakh => KeyboardLanguage.english,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // use OnscreenKeyboard.builder on MaterialApp.builder
      builder: OnscreenKeyboard.builder(
        key: ValueKey(_currentLanguage), // Force rebuild on language change
        width: (context) => MediaQuery.sizeOf(context).width / 2,
        layout: (context) => _getLayout(),
        // ...more options
      ),

      // or

      // builder: (context, child) {
      //   // your other codes
      //   // child = ...;

      //   // wrap with OnscreenKeyboard
      //   return OnscreenKeyboard(child: child!);
      // },
      home: HomeScreen(
        currentLanguage: _currentLanguage,
        onLanguageSwitch: _switchLanguage,
        isDesktop: _isDesktop,
      ),
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
  const HomeScreen({
    super.key,
    required this.currentLanguage,
    required this.onLanguageSwitch,
    required this.isDesktop,
  });

  final KeyboardLanguage currentLanguage;
  final VoidCallback onLanguageSwitch;
  final bool isDesktop;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final keyboard = OnscreenKeyboard.of(context);

  final _formFieldKey = GlobalKey<FormFieldState<String>>();

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
        // Handle language switch
        if (name == ActionKeyType.language) {
          widget.onLanguageSwitch();
        }
    }
  }

  String get _languageName {
    return switch (widget.currentLanguage) {
      KeyboardLanguage.english => 'English',
      KeyboardLanguage.russian => 'Russian (Русский)',
      KeyboardLanguage.kazakh => 'Kazakh (Қазақ)',
    };
  }

  String get _languageEmoji {
    return switch (widget.currentLanguage) {
      KeyboardLanguage.english => '🇬🇧',
      KeyboardLanguage.russian => '🇷🇺',
      KeyboardLanguage.kazakh => '🇰🇿',
    };
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

                  // Language indicator
                  Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _languageEmoji,
                                style: const TextStyle(fontSize: 32),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Current Language',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer,
                                        ),
                                  ),
                                  Text(
                                    _languageName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimaryContainer,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.isDesktop ? 'Desktop Layout' : 'Mobile Layout',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 8),
                          const Divider(),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.language_rounded,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Click 🌐 on keyboard to switch',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
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
