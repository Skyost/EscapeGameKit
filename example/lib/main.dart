import 'package:animate_do/animate_do.dart';
import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/game/game.dart';
import 'package:escape_game_kit_example/game/padlocks/computer_padlock.dart';
import 'package:escape_game_kit_example/game/padlocks/painting_padlock.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:window_manager/window_manager.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.windows || defaultTargetPlatform == TargetPlatform.linux || defaultTargetPlatform == TargetPlatform.macOS) {
    adjustWindowSize();
  }
  registerPadlocks();
  Error1980EscapeGame escapeGame = Error1980EscapeGame();
  runApp(_EscapeGameKitExample(escapeGame: escapeGame));
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

void registerPadlocks() {
  PadlockDialogs.registerBuilderFor(
    CredentialsPadlock,
    (context, padlock) => CredentialsPadlockDialog.builder(
      context,
      padlock,
      usernameText: "Nom d'utilisateur",
      passwordText: 'Mot de passe',
    ),
  );
  PadlockDialogs.registerBuilderFor(PaintingPadlock, PaintingPadlockDialog.builder);
  PadlockDialogs.registerBuilderFor(ComputerPadlock, ComputerPadlockDialog.builder);
}

class _EscapeGameKitExample extends StatelessWidget {
  final EscapeGame escapeGame;

  const _EscapeGameKitExample({
    required this.escapeGame,
  });

  @override
  Widget build(BuildContext context) => MaterialApp(
        navigatorKey: navigatorKey,
        title: 'EscapeGameKit Example',
        theme: ThemeData(primarySwatch: Colors.indigo),
        locale: const Locale('fr'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('fr')],
        home: EscapeGameWidget(
          beforeGameStartBuilder: (context, escapeGame) => _TitleScreen(escapeGame: escapeGame),
          escapeGame: escapeGame,
          autostart: kDebugMode,
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
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AboutDialog(
                      applicationName: 'ERROR 1980',
                      applicationVersion: 'v1.0.0',
                      applicationIcon: Image.asset(
                        'assets/icon.png',
                        height: 60,
                      ),
                      applicationLegalese: "Copyright © 2022 Hugo Delaunay. Tous droits réservés.\nL'icône provient de FreePik, les décors ainsi que les objets ont été créés par upklyak.",
                    ),
                  );
                },
                child: Image.asset(
                  'assets/logo.png',
                  scale: 1.5,
                ),
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
