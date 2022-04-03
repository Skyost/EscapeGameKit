import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/game/game.dart';
import 'package:escape_game_kit_example/main.dart';
import 'package:escape_game_kit_example/widgets/messages_dialog.dart';
import 'package:flutter/material.dart';

class BedroomFinalRoom extends Room {
  static const String roomId = 'bedroom-final';

  BedroomFinalRoom()
      : super(
          id: roomId,
          renderSettings: const RenderSettings(asset: 'assets/backgrounds/bedroom-present.png'),
          firstVisitDialog: const EscapeGameDialog(message: "<em>Wow...<br>C'était quoi ça ??</em>"),
          interactables: [
            Interactable(
              id: 'left-computer',
              renderSettings: const InteractableRenderSettings(
                bottom: 90,
                left: 40,
                height: 30,
                width: 55,
              ),
              onTap: (escapeGame) {
                (escapeGame as Error1980EscapeGame).messages.endMessage.date = DateTime.now();
                showDialog(
                  barrierColor: Colors.black,
                  context: navigatorKey.currentContext!,
                  builder: (context) => MessagesDialog(escapeGame: escapeGame as Error1980EscapeGame),
                );
                return const ActionResult.success();
              },
            ),
          ],
        );
}
