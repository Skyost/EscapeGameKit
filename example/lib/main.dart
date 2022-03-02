import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.linux || defaultTargetPlatform == TargetPlatform.macOS) {
    adjustWindowSize();
  }
  escapeGame.start();
  runApp(_EscapeGameKitExample());
}

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

class _EscapeGameKitExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'EscapeGameKit Example',
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: EscapeGameWidget(escapeGame: escapeGame),
      );
}
