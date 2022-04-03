import 'package:escape_game_kit_example/game/game.dart';
import 'package:escape_game_kit_example/widgets/audio.dart';
import 'package:escape_game_kit_example/widgets/message.dart';
import 'package:flutter/material.dart';

class GlitchMessageWidget extends StatefulWidget {
  final Error1980EscapeGame escapeGame;

  const GlitchMessageWidget({
    Key? key,
    required this.escapeGame,
  }) : super(
          key: key,
        );

  @override
  State<StatefulWidget> createState() => _GlitchMessageWidgetState();
}

class _GlitchMessageWidgetState extends State<GlitchMessageWidget> {
  bool hasAudioStarted = false;

  @override
  Widget build(BuildContext context) => MessageWidget(
        messageInfo: widget.escapeGame.messages.glitchMessage,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Bonjour à tous.\n\nVoici le fichier audio dont vous aurez besoin pour l\'évaluation de demain.\n\n'),
            AudioPlayer(
              'assets/glitch/noise.mp3',
              pause: (player) {},
              play: (player) async {
                setState(() => hasAudioStarted = true);
                player.play();
                await Future.delayed(const Duration(seconds: 4));
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    backgroundColor: Colors.black,
                    contentPadding: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(),
                    content: Image.asset(
                      'assets/glitch/image.webp',
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                );
                await Future.delayed(const Duration(seconds: 8));
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                widget.escapeGame.goToRoom('bedroom');
              },
              seek: (player, duration) {},
            ),
            const Text('\n\nBonne journée.\nH. Delaunay'),
          ],
        ),
        closeButton: TextButton(
          onPressed: () {
            if (!hasAudioStarted) {
              Navigator.pop(context);
            }
          },
          child: Text(MaterialLocalizations.of(context).closeButtonLabel.toUpperCase()),
        ),
      );
}
