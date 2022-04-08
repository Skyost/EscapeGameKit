import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/game/game.dart';
import 'package:escape_game_kit_example/game/padlocks/bruteforce_padlock.dart';
import 'package:escape_game_kit_example/game/padlocks/caesar_padlock.dart';
import 'package:escape_game_kit_example/game/padlocks/computer_padlock.dart';
import 'package:escape_game_kit_example/game/padlocks/qr_padlock.dart';
import 'package:escape_game_kit_example/widgets/main_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

/// Hello world !
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb && (defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.linux || defaultTargetPlatform == TargetPlatform.macOS)) {
    adjustWindowSize();
  }
  registerPadlocks();
  Error1980EscapeGame escapeGame = Error1980EscapeGame();
  runApp(MainWidget(escapeGame: escapeGame));
}

/// Adjusts the window size.
Future<void> adjustWindowSize() async {
  await windowManager.ensureInitialized();

  windowManager.waitUntilReadyToShow().then((_) async {
    Size size = const Size(990, 430);
    await windowManager.setSize(size);
    await windowManager.setMinimumSize(size);
    await windowManager.setMaximumSize(size);
    await windowManager.setResizable(false);
    await windowManager.center();
    await windowManager.show();
  });
}

/// Registers padlock dialogs.
void registerPadlocks() {
  PadlockDialogs.registerBuilderFor(BruteforcePadlock, BruteforcePadlockDialog.builder);
  PadlockDialogs.registerBuilderFor(CaesarPadlock, CaesarPadlockDialog.builder);
  PadlockDialogs.registerBuilderFor(ComputerPadlock, ComputerPadlockDialog.builder);
  PadlockDialogs.registerBuilderFor(QrPadlock, QrPadlockDialog.builder);
}
