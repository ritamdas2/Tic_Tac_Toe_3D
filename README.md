# tictactoe_3d

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.io/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.io/docs/cookbook)

For help getting started with Flutter, view our 
[online documentation](https://flutter.io/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.

Cheat Sheet
-----------
Assuming you know nothing about Flutter

1. Everything for this project is in the `lib` directory
2. You’ll start with `main.dart` file — which defines the home screen. Then follow the screens from one to the next (`home_screen.dart`, `game_screen.dart` files respectively).
3. Every screen file has 2 classes. GameScreen and _GameScreenState for example. The `state` class is has most of the magic. The first part is something that compiler needs, you don’t care - at this stage anyway
4. The “framework” calls the “build” method (why/how doesn’t matter) — so you should start with the build method. When the framework calls `build`, it is expecting a getting a `Scaffold`.

`Scaffold` means the whole screen. It's broken up into a "bar" at the very top (`AppBar`) and `body` (the rest of the screen).

When you start with the `build` method, you'll follow it *up" (meaning follow the methods it calls). Noting magical really, just start clicking through. Each method it calls should be reasonably self explanatory

