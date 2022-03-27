import 'package:animate_do/animate_do.dart';
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
  // escapeGame.start();
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
        home: EscapeGameWidget(
          beforeGameStartBuilder: (context, escapeGame) => _TitleScreen(escapeGame: escapeGame),
          escapeGame: escapeGame,
        ),
      );
}

class _TitleScreen extends StatelessWidget {
  final EscapeGame escapeGame;

  const _TitleScreen({
    Key? key,
    required this.escapeGame,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          Flash(
            duration: const Duration(seconds: 1),
            child: Image.asset(
              'assets/backgrounds/title.png',
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Positioned(
            top: 60,
            child: FadeIn(
              delay: const Duration(seconds: 2),
              duration: const Duration(seconds: 1),
              child: Image.asset(
                'assets/logo.png',
                scale: 1.5,
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            child: FadeIn(
              delay: const Duration(seconds: 3),
              child: ElevatedButton.icon(
                onPressed: escapeGame.start,
                icon: const Icon(Icons.play_arrow),
                label: const Text('JOUER'),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
                ),
              ),
            ),
          ),
        ],
      );
}
