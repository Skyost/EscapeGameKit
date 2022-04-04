import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/game/game.dart';
import 'package:escape_game_kit_example/game/messages/messages.dart';
import 'package:escape_game_kit_example/game/rooms/bedroom_final.dart';
import 'package:escape_game_kit_example/widgets/glitch_message.dart';
import 'package:escape_game_kit_example/widgets/message.dart';
import 'package:flutter/material.dart';

class MessagesDialog extends StatelessWidget {
  final Error1980EscapeGame escapeGame;

  const MessagesDialog({
    Key? key,
    required this.escapeGame,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) => EscapeGameAlertDialog(
        title: 'Messagerie',
        contentPadding: EdgeInsets.zero,
        children: [
          if (escapeGame.currentRoom.id == BedroomFinalRoom.roomId)
            TextMessageWidget(
              messageInfo: escapeGame.messages.endMessage,
              closeButton: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  escapeGame.finish();
                },
                child: Text(MaterialLocalizations.of(context).closeButtonLabel.toUpperCase()),
              ),
            ),
          GlitchMessageWidget(escapeGame: escapeGame),
          for (TextMessageInfo textMessage in escapeGame.messages.textMessages)
            TextMessageWidget(
              messageInfo: textMessage,
            ),
        ],
      );
}
