import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/widgets/end_message.dart';
import 'package:escape_game_kit_example/widgets/play_button.dart';
import 'package:escape_game_kit_example/widgets/title_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Allows to build dialogs from outside a widget.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// The main widget.
class MainWidget extends StatefulWidget {
  /// The [EscapeGame] instance.
  final EscapeGame escapeGame;

  /// Creates a new [MainWidget] instance.
  const MainWidget({
    super.key,
    required this.escapeGame,
  });

  @override
  State<StatefulWidget> createState() => _MainWidgetState();
}

/// The [MainWidget] state.
class _MainWidgetState extends State<MainWidget> {
  @override
  void initState() {
    super.initState();
    for (String asset in [
      'assets/backgrounds/bedroom.png',
      'assets/backgrounds/bedroom-present.png',
      'assets/backgrounds/desk.png',
      'assets/backgrounds/living-room.png',
      'assets/glitch/image.webp',
    ]) {
      precacheImage(AssetImage(asset), context);
    }
    for (String asset in [
      'assets/interactables/arrow.svg',
      'assets/objects/eight-key.svg',
      'assets/objects/clover-key.svg',
      'assets/objects/mouth-key.svg',
      'assets/padlocks/caesar-1.svg',
      'assets/padlocks/caesar-2.svg',
    ]) {
      precachePicture(ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, asset), context);
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        navigatorKey: navigatorKey,
        title: 'ERROR 1980',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          scrollbarTheme: ScrollbarThemeData(thumbVisibility: MaterialStateProperty.all(true)),
        ),
        locale: const Locale('en'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en')],
        home: EscapeGameWidget(
          baseSize: const Size(975.2, 392.0),
          backgroundColor: Colors.black,
          beforeGameStartBuilder: (context, escapeGame) => TitleScreen(
            child: PlayButton(
              escapeGame: escapeGame,
            ),
          ),
          afterGameFinishedBuilder: (context, escapeGame) => const TitleScreen(
            child: EndMessage(),
          ),
          escapeGame: widget.escapeGame,
        ),
      );
}
