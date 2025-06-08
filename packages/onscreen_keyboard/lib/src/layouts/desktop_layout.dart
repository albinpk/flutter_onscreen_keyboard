import 'package:flutter/material.dart';
import 'package:onscreen_keyboard/src/models/keys.dart';
import 'package:onscreen_keyboard/src/models/layout.dart';

class DesktopLayout extends KeyboardLayout {
  @override
  List<KeyboardRow> get rows => [
    const KeyboardRow(
      keys: [
        OnscreenKeyboardKey.text(primary: '`', secondary: '~'),
        OnscreenKeyboardKey.text(primary: '1', secondary: '!'),
        OnscreenKeyboardKey.text(primary: '2', secondary: '@'),
        OnscreenKeyboardKey.text(primary: '3', secondary: '#'),
        OnscreenKeyboardKey.text(primary: '4', secondary: r'$'),
        OnscreenKeyboardKey.text(primary: '5', secondary: '%'),
        OnscreenKeyboardKey.text(primary: '6', secondary: '^'),
        OnscreenKeyboardKey.text(primary: '7', secondary: '&'),
        OnscreenKeyboardKey.text(primary: '8', secondary: '*'),
        OnscreenKeyboardKey.text(primary: '9', secondary: '('),
        OnscreenKeyboardKey.text(primary: '0', secondary: ')'),
        OnscreenKeyboardKey.text(primary: '-', secondary: '_'),
        OnscreenKeyboardKey.text(primary: '=', secondary: '+'),
        OnscreenKeyboardKey.action(
          name: ActionKeyType.backspace,
          child: Icon(Icons.backspace_rounded),
          flex: 25,
        ),
      ],
    ),
    KeyboardRow(
      keys: [
        const OnscreenKeyboardKey.action(
          name: ActionKeyType.tab,
          child: Icon(Icons.keyboard_tab_rounded),
          flex: 25,
        ),
        for (final c in ['q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'])
          OnscreenKeyboardKey.text(primary: c),
        const OnscreenKeyboardKey.text(primary: '[', secondary: '{'),
        const OnscreenKeyboardKey.text(primary: ']', secondary: '}'),
        const OnscreenKeyboardKey.text(primary: r'\', secondary: '|'),
      ],
    ),

    KeyboardRow(
      keys: [
        const OnscreenKeyboardKey.action(
          name: ActionKeyType.capslock,
          child: Icon(Icons.keyboard_capslock_rounded),
          flex: 30,
          canHold: true,
        ),
        for (final c in ['a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l'])
          OnscreenKeyboardKey.text(primary: c),
        const OnscreenKeyboardKey.text(primary: ';', secondary: ':'),
        const OnscreenKeyboardKey.text(primary: "'", secondary: '"'),
        const OnscreenKeyboardKey.action(
          name: ActionKeyType.enter,

          child: Icon(Icons.keyboard_return_rounded),
          flex: 30,
        ),
      ],
    ),
    KeyboardRow(
      keys: [
        const OnscreenKeyboardKey.action(
          name: ActionKeyType.shift,
          child: Icon(Icons.arrow_upward_rounded),
          flex: 35,
        ),
        for (final c in ['z', 'x', 'c', 'v', 'b', 'n', 'm'])
          OnscreenKeyboardKey.text(primary: c),
        const OnscreenKeyboardKey.text(primary: ',', secondary: '<'),
        const OnscreenKeyboardKey.text(primary: '.', secondary: '>'),
        const OnscreenKeyboardKey.text(primary: '/', secondary: '?'),
        const OnscreenKeyboardKey.action(
          name: ActionKeyType.shift,
          child: Icon(Icons.arrow_upward_rounded),
          flex: 35,
        ),
      ],
    ),
    const KeyboardRow(
      keys: [
        OnscreenKeyboardKey.text(
          primary: ' ',
          child: Icon(Icons.space_bar_rounded),
        ),
      ],
    ),
  ];
}

abstract class ActionKeyType {
  static const backspace = 'backspace';
  static const tab = 'tab';
  static const capslock = 'capslock';
  static const enter = 'enter';
  static const shift = 'shift';
}
