import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/main.dart';
import 'package:escape_game_kit_example/widgets/messages_dialog.dart';
import 'package:flutter/material.dart';

final Room bedroomPresent = Room(
  id: 'bedroom-present',
  interactables: [
    Interactable(
      id: 'invisible-1',
      renderSettings: const InteractableRenderSettings(
        top: 130,
        left: 280,
        height: 80,
        width: 60,
      ),
      onTap: (escapeGame) {
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
