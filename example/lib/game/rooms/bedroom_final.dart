import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/game/game.dart';
import 'package:escape_game_kit_example/widgets/main_widget.dart';
import 'package:escape_game_kit_example/widgets/messages_dialog.dart';
import 'package:flutter/material.dart';

/// The final bedroom.
class BedroomFinalRoom extends Room {
  /// The room id.
  static const String roomId = 'bedroom-final';

  /// Creates a new [BedroomFinalRoom] instance.
  BedroomFinalRoom()
      : super(
          id: roomId,
          renderSettings: const RenderSettings(asset: 'assets/backgrounds/bedroom-present.png'),
          onFirstVisit: (escapeGame) {
            escapeGame.openDialog(const EscapeGameDialog(message: "<em>Wow... I think we're back...<br>But what was that ??</em>"));
            return const ActionResult.success();
          },
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
                  builder: (context) => MessagesDialog(escapeGame: escapeGame),
                );
                return const ActionResult.success();
              },
            ),
          ],
        );
}
