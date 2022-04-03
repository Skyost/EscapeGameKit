import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  final EscapeGame escapeGame;

  const PlayButton({
    Key? key,
    required this.escapeGame,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) => ElevatedButton.icon(
        onPressed: escapeGame.start,
        icon: const Icon(Icons.play_arrow),
        label: const Text('JOUER'),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 40, vertical: 20)),
        ),
      );
}
