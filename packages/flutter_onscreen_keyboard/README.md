# flutter_onscreen_keyboard

A customizable and extensible on-screen virtual keyboard for Flutter applications. Ideal for desktop and touchscreen environments where physical keyboards are unavailable or limited.

[![deploy](https://github.com/albinpk/flutter_onscreen_keyboard/actions/workflows/deploy.yml/badge.svg)](https://github.com/albinpk/flutter_onscreen_keyboard/actions/workflows/deploy.yml)
[![codecov](https://codecov.io/gh/albinpk/flutter_onscreen_keyboard/graph/badge.svg?token=01VDBVBIR9)](https://codecov.io/gh/albinpk/flutter_onscreen_keyboard)
[![Pub Version](https://img.shields.io/pub/v/flutter_onscreen_keyboard.svg)](https://pub.dev/packages/flutter_onscreen_keyboard)
[![Pub Points](https://img.shields.io/pub/points/flutter_onscreen_keyboard)](https://pub.dev/packages/flutter_onscreen_keyboard/score)
[![GitHub License](https://img.shields.io/github/license/albinpk/flutter_onscreen_keyboard)](https://github.com/albinpk/flutter_onscreen_keyboard/blob/main/LICENSE)
[![GitHub Repo](https://img.shields.io/badge/GitHub-albinpk/flutter_onscreen_keyboard-blue?logo=github)](https://github.com/albinpk/flutter_onscreen_keyboard)
[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg)](https://github.com/invertase/melos)

---

![Desktop demo - flutter_onscreen_keyboard](https://github.com/albinpk/flutter_onscreen_keyboard/blob/main/docs/demo.gif?raw=true)

<table>
    <tr>
        <td>
            <img alt="Gboard blue alphabets - flutter_onscreen_keyboard"
                src="https://github.com/albinpk/flutter_onscreen_keyboard/blob/main/docs/gboard-blue-alphabets.jpeg?raw=true"
                width="220">
        </td>
        <td>
            <img alt="Gboard blue emoji - flutter_onscreen_keyboard"
                src="https://github.com/albinpk/flutter_onscreen_keyboard/blob/main/docs/gboard-blue-emoji.jpeg?raw=true"
                width="220">
        </td>
        <td>
            <img alt="ios default alphabets - flutter_onscreen_keyboard"
                src="https://github.com/albinpk/flutter_onscreen_keyboard/blob/main/docs/ios-default-alphabets.png?raw=true"
                width="220">
        </td>
        <td>
            <img alt="ios default symbols - flutter_onscreen_keyboard"
                src="https://github.com/albinpk/flutter_onscreen_keyboard/blob/main/docs/ios-default-symbols.png?raw=true"
                width="220">
        </td>
    </tr>
</table>

## ✨ Features

- 🧩 **Customizable Layouts** – Tailor the keyboard layout and style to suit your UI.
- 🎛️ **Keyboard Modes** – Support for multiple keyboard modes like alphanumeric, symbols, etc., with dynamic switching.
- 📱 **Mobile & Desktop Layouts** – Comes with built-in layouts for both mobile and desktop platforms.
- 🎨 **Theming Support** – Easily style the keyboard using `OnscreenKeyboardThemeData`.
- 🛠️ **Extensible Architecture** – Add custom keys or override behavior easily.
- 💻 **Full Desktop Keyboard** – Complete support for alphabetic, numeric, symbol, and function keys.
- 🔤 **Integrated Text Field** – Comes with a dedicated `OnscreenKeyboardTextField` widget to easily handle user input.
- 🖱️ **Drag & Align** – Move and align the keyboard anywhere on screen, including top or bottom alignment.
- 🔌 **Controller API** – Programmatically control keyboard visibility and alignment.
- 🖥️ **Designed for Desktop and Touch Devices** – Ideal for touchscreen setups like POS systems.

---

## 🚀 Getting Started

### 📦 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_onscreen_keyboard: ^0.3.0+1
```

---

## 🧪 Usage

### ➕ Add `OnscreenKeyboard` to Your Root Widget

There are two ways to integrate the keyboard into your root widget:

- Using `OnscreenKeyboard.builder`.

```dart
return MaterialApp(
  builder: OnscreenKeyboard.builder(), // add this line
  home: const HomeScreen(),
);
```

- Or using `OnscreenKeyboard`.

```dart
return MaterialApp(
  builder: (context, child) {
    // your other codes
    // child = ...

    // wrap with OnscreenKeyboard
    return OnscreenKeyboard(child: child);
  },
  home: const HomeScreen(),
);
```

---

### 🧾 Use `OnscreenKeyboardTextField` Anywhere

You can place the `OnscreenKeyboardTextField` widget anywhere in your app. It will automatically connect with the keyboard and handle input seamlessly.

```dart
@override
Widget build(BuildContext context) {
  return const OnscreenKeyboardTextField(
    // enableOnscreenKeyboard: false, // default to true
  ),
}
```

---

### 🎛️ Access the Keyboard Controller

Use `OnscreenKeyboard.of(context)` to get the keyboard controller instance.

```dart
final keyboardController = OnscreenKeyboard.of(context);
```

---

### 📂 Open and Close the Keyboard Programmatically

With the controller, you can open or close the keyboard as needed in your application flow.

```dart
keyboardController.open(); // open the keyboard

keyboardController.close(); // close the keyboard
```

---

### 🔄 Switch Keyboard Modes

You can define multiple modes in your `KeyboardLayout` (e.g., "alphanumeric", "symbols") and switch between them using the controller:

```dart
keyboardController.switchMode();
```

The keyboard will cycle through modes in the order they are defined in your layout.

---

### 🎛 Built-in Mobile and Desktop Layouts

By default, the keyboard selects the appropriate layout based on platform:

- `MobileKeyboardLayout` for Android/iOS/Fuchsia
- `DesktopKeyboardLayout` for macOS/Windows/Linux

You can also explicitly set a custom layout:

```dart
OnscreenKeyboard.builder(
  layout: const MobileKeyboardLayout(), // or your custom layout
  // ...more options
),
```

---

### 🎹 Listen to Key Events

To respond to key presses globally, use the `addRawKeyDownListener` method.

```dart
class _AppState extends State<App> {
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
      case ActionKey(:final name): // an action key: "shift", "backspace", etc.
        log('action: $name');
    }
  }

  @override
  Widget build(BuildContext context) {
    // ...
  }
}
```

---

## 🎨 Customization

- **Styles:** Customize key colors, shapes, and padding.
- **Layouts:** Use built-in or define your own layouts with multiple modes.
- **Behaviors:** Override key presses and implement custom actions.

### Predefined Themes

Easily apply built-in keyboard styles like **Gboard** or **iOS** using predefined factory constructors:

```dart
OnscreenKeyboard.builder(
  theme: OnscreenKeyboardThemeData.gBoard(),
)
```

#### Available Themes:

- `OnscreenKeyboardThemeData.gBoard()`
- `OnscreenKeyboardThemeData.ios()`

### Custom Theme

An example of theme customization:

```dart
final theme = OnscreenKeyboardThemeData(
  border: Border.all(color: Colors.white),
  margin: const EdgeInsets.all(40),
  padding: const EdgeInsets.all(10),
  borderRadius: BorderRadius.circular(20),
  boxShadow: [
    const BoxShadow(
      blurRadius: 5,
      spreadRadius: 5,
      color: Colors.black12,
    ),
  ],
  // color: ..,
  gradient: const LinearGradient(
    colors: [Colors.indigo, Colors.indigoAccent],
  ),
  textKeyThemeData: TextKeyThemeData(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    borderRadius: BorderRadius.circular(20),
    margin: const EdgeInsets.all(1),
    boxShadow: [
      const BoxShadow(blurRadius: 2, color: Colors.black26),
    ],
    // padding: ..,
    // textStyle: ..,
    // gradient: ...,
    // border: ..,
  ),
  actionKeyThemeData: ActionKeyThemeData(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white54,
    pressedBackgroundColor: Colors.indigo,
    pressedForegroundColor: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [const BoxShadow()],
    margin: const EdgeInsets.all(1),
    iconSize: 20,
    fitChild: false,
    // border: ..,
    // gradient: ..,
    // padding: ..,
  ),
);
```

---

## 📂 Repository

Browse the source code and contribute here:
🔗 [https://github.com/albinpk/flutter_onscreen_keyboard](https://github.com/albinpk/flutter_onscreen_keyboard)

---

## 🛠️ Contributing

Contributions, issues, and feature requests are welcome!
See the [CONTRIBUTING.md](https://github.com/albinpk/flutter_onscreen_keyboard/blob/main/CONTRIBUTING.md) for guidelines.

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

## 🙌 Credits

Created and maintained by [Albin PK](https://github.com/albinpk).
If you find this package useful, consider giving it a ⭐ on GitHub and a like on [pub.dev](https://pub.dev/packages/flutter_onscreen_keyboard)!
