## 0.4.3

 - **FIX**: remove unnecessary type annotation. ([adffb8ac](https://github.com/albinpk/flutter_onscreen_keyboard/commit/adffb8ac00c66952eb2871966fe9b5e09d1fdf12))
 - **FEAT**: implementation of `setModeNamed` to specify keyboard modes ([#29](https://github.com/albinpk/flutter_onscreen_keyboard/issues/29)). ([87308d69](https://github.com/albinpk/flutter_onscreen_keyboard/commit/87308d69a53e79af5f8dfc056c2861b4dd139d39))

## 0.4.2+1

 - **FIX**: upgrade sdk and dependencies. ([e3534cae](https://github.com/albinpk/flutter_onscreen_keyboard/commit/e3534caed3fa087a7e0e211eaad37188ee94e42b))

## 0.4.2

 - **FEAT**: add `useSafeArea` to `OnscreenKeyboardThemeData` ([#28](https://github.com/albinpk/flutter_onscreen_keyboard/issues/28)). ([dd1ea873](https://github.com/albinpk/flutter_onscreen_keyboard/commit/dd1ea873cb4c8442a1923a649815988dee619d88))

## 0.4.1+1

 - **FIX**: update dependencies. ([e050f326](https://github.com/albinpk/flutter_onscreen_keyboard/commit/e050f3269175e7cdf58862a6ec24aad6e44c06f1))
 - **FIX**: handle `initialValue` in `OnscreenKeyboardTextFormField` ([#26](https://github.com/albinpk/flutter_onscreen_keyboard/issues/26)). ([9123884e](https://github.com/albinpk/flutter_onscreen_keyboard/commit/9123884e71888ab9ea0107b21e472e4ba985d350))

## 0.4.1

 - **FIX**: update sdk and dependencies. ([3da71fca](https://github.com/albinpk/flutter_onscreen_keyboard/commit/3da71fca135e7a2963298df9ea12101ce5ff6a9a))
 - **FEAT**: add `formFieldKey` to the `OnscreenKeyboardTextFormField` widget ([#23](https://github.com/albinpk/flutter_onscreen_keyboard/issues/23)). ([50c42e45](https://github.com/albinpk/flutter_onscreen_keyboard/commit/50c42e450a701fbab717732dd57a07eecfa11b95))

## 0.4.0+1

 - **FIX**: TextInputFormatter is not applied to the edits of the onscreen_keyboard and onChanged is not triggered on changes thorugh the onscreen_keyboard ([#22](https://github.com/albinpk/flutter_onscreen_keyboard/issues/22)). ([9ea27c1d](https://github.com/albinpk/flutter_onscreen_keyboard/commit/9ea27c1ddf9dd93305fff1818ca1abd5995a37a0))

## 0.4.0

> Note: This release has breaking changes.

 - **DOCS**: add `OnscreenKeyboardTextFormField` in readme. ([95ab04cf](https://github.com/albinpk/flutter_onscreen_keyboard/commit/95ab04cfc55e2badcac43f7d30b7c6f04f49addc))
 - **BREAKING** **FEAT**: add `OnscreenKeyboardTextFormField` widget ([#20](https://github.com/albinpk/flutter_onscreen_keyboard/issues/20)). ([23d73ca4](https://github.com/albinpk/flutter_onscreen_keyboard/commit/23d73ca43c113d0f0687018c0fadfec89b925de4))

## 0.3.0+2

 - **FIX**: update flutter sdk and dependencies. ([8894ea4d](https://github.com/albinpk/flutter_onscreen_keyboard/commit/8894ea4d86b10f732d0599d81f59fded5fda95a2))

## 0.3.0+1

 - **DOCS**: add codcov badge in README.md. ([4f85b8ef](https://github.com/albinpk/flutter_onscreen_keyboard/commit/4f85b8ef593a243481dee1fb8da34fefe43802fe))

## 0.3.0

> Note: This release has breaking changes.

 - **REFACTOR**: simplify text handling in keyboard input methods. ([e3e8edd9](https://github.com/albinpk/flutter_onscreen_keyboard/commit/e3e8edd995006270960e763fca57b5cdf963fe97))
 - **FIX**: gboard and ios themes. ([6a6bfade](https://github.com/albinpk/flutter_onscreen_keyboard/commit/6a6bfadee84837f47289853f3f5bcc04100a3a02))
 - **FEAT**: add emoji mode for default mobile layout. ([a9414077](https://github.com/albinpk/flutter_onscreen_keyboard/commit/a9414077895ebc4d539cabd73c27f14d5dd59996))
 - **FEAT**: add option to show/hide control bar in `OnscreenKeyboard`. ([7b9147f4](https://github.com/albinpk/flutter_onscreen_keyboard/commit/7b9147f44c94fdf3610e99cb52d092258d8aa2ac))
 - **DOCS**: update `README.md` with more screenshots. ([79310704](https://github.com/albinpk/flutter_onscreen_keyboard/commit/7931070410aa150665beabe0ec1c9b46cc508944))
 - **BREAKING** **REFACTOR**: remove `attachTextController` and related implementations. ([0d44c91c](https://github.com/albinpk/flutter_onscreen_keyboard/commit/0d44c91c1387ad93c0ac8738bb7d35d9d79f9ca1))

## 0.2.0+1

 - **PERF**: use `InheritedWidget` for providing `OnscreenKeyboardController`. ([46f92914](https://github.com/albinpk/flutter_onscreen_keyboard/commit/46f92914ba6f0ed7a4f6397c07af93f04b7980f2))

## 0.2.0

> Note: This release has breaking changes.

 - **BREAKING** **REFACTOR**: migrate to `KeyboardMode` for layout modes ([#19](https://github.com/albinpk/flutter_onscreen_keyboard/issues/19)). ([436ffd1b](https://github.com/albinpk/flutter_onscreen_keyboard/commit/436ffd1bf342c18f6efbea8281e1d473de3e704a))

## 0.1.1

 - **FIX**: disable system keyboard for `OnscreenKeyboardTextField`.
 - **FEAT**: add predefined themes (Gboard, iOS) for easy styling (#18).

## 0.1.0

> Note: This release has breaking changes.

 - **BREAKING** **FEAT**: add mobile layout and support for multiple keyboard modes ([#17](https://github.com/albinpk/flutter_onscreen_keyboard/issues/17)). ([ba97977e](https://github.com/albinpk/flutter_onscreen_keyboard/commit/ba97977ed9cebe3c4aac4eccf3bb1ffd2b193814))

## 0.0.6

 - **FEAT**: add more theme customization for keys ([#12](https://github.com/albinpk/flutter_onscreen_keyboard/issues/12)). ([58109c4a](https://github.com/albinpk/flutter_onscreen_keyboard/commit/58109c4a06b91088466bec1e66fc472f2dfe81b8))
 - **FEAT**: add textstyle TextKeyThemeData ([#11](https://github.com/albinpk/flutter_onscreen_keyboard/issues/11)). ([5785d06e](https://github.com/albinpk/flutter_onscreen_keyboard/commit/5785d06e0e89eac1290ee313770e752c3dc5496f))
 - **DOCS**: update readme with theme configurations ([#13](https://github.com/albinpk/flutter_onscreen_keyboard/issues/13)). ([57364611](https://github.com/albinpk/flutter_onscreen_keyboard/commit/57364611386fba4c7f2d267bb6bb2a2eae906f34))

## 0.0.5

 - **FIX**: better and simplified focus management ([#10](https://github.com/albinpk/flutter_onscreen_keyboard/issues/10)). ([206cc114](https://github.com/albinpk/flutter_onscreen_keyboard/commit/206cc1149905a7ddd2b8fc8421cd7a5b5fdc8dae))
 - **FEAT**: automatically show/hide keyboard when input gains or loses focus. ([76a34553](https://github.com/albinpk/flutter_onscreen_keyboard/commit/76a3455384de036085afc31824a9c8989a1168bb))

## 0.0.4+2

 - **DOCS**: update README for badge links and usage instructions. ([8d75e6fc](https://github.com/albinpk/flutter_onscreen_keyboard/commit/8d75e6fc040b38a5fa6ebd01b870e73853f63421))

## 0.0.4+1

 - **DOCS**: update docs directory. ([3e1611a8](https://github.com/albinpk/flutter_onscreen_keyboard/commit/3e1611a82c1ef49b12322d4562c8a1688ee42e06))

## 0.0.4

 - **FEAT**: customizable control bar actions ([#6](https://github.com/albinpk/flutter_onscreen_keyboard/issues/6)). ([ba0d842d](https://github.com/albinpk/flutter_onscreen_keyboard/commit/ba0d842d61e3100c20d506cab627334abf566330))
 - **FEAT**: customizable keyboard aspect ratio ([#5](https://github.com/albinpk/flutter_onscreen_keyboard/issues/5)). ([658ded00](https://github.com/albinpk/flutter_onscreen_keyboard/commit/658ded00eb80a78d0818ac2b73dd1735181f3a84))
 - **DOCS**: update readme with a short demo ([#4](https://github.com/albinpk/flutter_onscreen_keyboard/issues/4)). ([bc167e86](https://github.com/albinpk/flutter_onscreen_keyboard/commit/bc167e86a0a775a4e2560b66302c28889ffce04d))

## 0.0.3+1

 - **DOCS**: add documentation for all APIs ([#3](https://github.com/albinpk/flutter_onscreen_keyboard/issues/3)). ([abe6af23](https://github.com/albinpk/flutter_onscreen_keyboard/commit/abe6af233aeca5d1ecfadcc0f6f2d324916be33b))

## 0.0.3

 - **FEAT**: add text selection support ([#2](https://github.com/albinpk/flutter_onscreen_keyboard/issues/2)). ([60a0b8b8](https://github.com/albinpk/flutter_onscreen_keyboard/commit/60a0b8b8d88cc54bc94927d818d231bb299d2c95))

## 0.0.2

 - **FEAT**: draggable keyboard widget. ([b7a87595](https://github.com/albinpk/flutter_onscreen_keyboard/commit/b7a87595b670ccb4ea2ee39bfb84e3588fd8c424))

## 0.0.1+1

 - **DOCS**: add deploy workflow and update package description. ([8a4b57b1](https://github.com/albinpk/flutter_onscreen_keyboard/commit/8a4b57b1f689f6a62f650e93800a787ef313383f))

## 0.0.1

 - **FEAT**: implement onscreen keyboard layout and functionality
 - **DOCS**: enhance README with comprehensive usage instructions and features.
 - **FEAT**: make `OnscreenKeyboardTextField` similar to `TextField`
 - **FEAT**: customizable width for keyboard
 - **FIX**: handle multiline `TextField`
 - **FEAT**: create `wrap` function
 - **FEAT**: add `addRawKeyDownListener` to `OnscreenKeyboard`
 - **DOCS**: update example app with `OnscreenKeyboardTextField` usage
 - **CHORE**: create LICENSE
 - **CHORE**: add CONTRIBUTING.md
 - **CHORE**: add pull request template for consistent contributions
 - **CHORE**: update issue templates
 - **CHORE**: create CODE_OF_CONDUCT.md
