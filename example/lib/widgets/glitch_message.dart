import 'package:escape_game_kit_example/game/game.dart';
import 'package:escape_game_kit_example/game/rooms/bedroom_present.dart';
import 'package:escape_game_kit_example/widgets/audio.dart';
import 'package:escape_game_kit_example/widgets/message.dart';
import 'package:flutter/material.dart';

/// This widget allows to show the glitch animation when the user clicks on the audio player.
class GlitchMessageWidget extends StatefulWidget {
  /// The [Error1980EscapeGame] instance.
  final Error1980EscapeGame escapeGame;

  /// Creates a new [GlitchMessageWidget] instance.
  const GlitchMessageWidget({
    Key? key,
    required this.escapeGame,
  }) : super(
          key: key,
        );

  @override
  State<StatefulWidget> createState() => _GlitchMessageWidgetState();
}

/// The [GlitchMessageWidget] state.
class _GlitchMessageWidgetState extends State<GlitchMessageWidget> {
  /// Whether the audio has started playing.
  bool hasAudioStarted = false;

  @override
  Widget build(BuildContext context) => MessageWidget(
        messageInfo: widget.escapeGame.messages.glitchMessage,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Hello everyone.\n\nHere is the file you need for tomorrow\'s exam.'),
            if (widget.escapeGame.currentRoom.id == BedroomPresentRoom.roomId)
              Padding(
                padding: const EdgeInsets.only(top: 34),
                child: AudioPlayer(
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
              )
            else
              const Text(
                '\n\nAudio removed from remote server.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            const Text('\n\nHave a nice day.\nH. Delaunay'),
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
