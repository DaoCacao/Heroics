# Heroics

Heroics is the ultimate character creation and management tool for tabletop role-playing games. With its powerful and
versatile features, Heroics allows players to create and customize characters like never before. Elevate your gaming
experience with Heroics!

## Getting Started

For code generation run:

```
flutter pub run build_runner build
```

After updating firebase libs run:

```
flutterfire configure
```

After updating splash screen settings run:

```
flutter pub run flutter_native_splash:create
```

For generate coverage and open report run:

```
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```