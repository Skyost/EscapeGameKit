import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/widgets/glitch_message.dart';
import 'package:escape_game_kit_example/widgets/message.dart';
import 'package:flutter/material.dart';

class MessagesDialog extends StatelessWidget {
  final EscapeGame escapeGame;

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
          GlitchMessageWidget(escapeGame: escapeGame),
          TextMessageWidget(
            author: 'SERVICE INFORMATIQUE',
            title: 'Attention',
            date: DateTime.now().subtract(const Duration(hours: 1)),
            text: "Le réseau informatique du collège est très instable aujourd'hui.\nVous êtes donc priés de faire attention à ce que vous faîtes dessus.\n\nBien cordialement.\nLe service informatique",
            unread: true,
          ),
          TextMessageWidget(
            author: 'À changer',
            title: 'URGENT !!',
            date: DateTime(2022, 4, 6, 8, 24),
            text: "J'ai perdu mon sac, tu saurais pour où il est ?? 😭😭",
          ),
          TextMessageWidget(
            author: 'À changer',
            title: 'Leçons pour demain',
            date: DateTime(2022, 4, 5, 18, 47),
            text: "Salut !\n\nC'est quoi le travail à faire pour demain ?",
          ),
          TextMessageWidget(
            author: 'À changer',
            title: 'Exo de math',
            date: DateTime(2022, 4, 5, 17, 59),
            text: "Hello\n\nJ'ai pas compris l'exo sur la proportionnalité de ce matin, tu pourrais me donner un coup de main ? 🤓",
          ),
        ],
      );
}
