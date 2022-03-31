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
        bottom: 90,
        left: 40,
        height: 30,
        width: 55,
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
    Interactable(
      id: 'invisible-2',
      renderSettings: const InteractableRenderSettings(
        top: 70,
        left: 30,
        height: 170,
        width: 8,
      ),
      onTooltip: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: "C'est un grand néon.")),
    ),
    Interactable(
      id: 'invisible-3',
      renderSettings: const InteractableRenderSettings(
        left: 130,
        bottom: 110,
        height: 50,
        width: 130,
      ),
      onTooltip: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: "Des écrans d'ordinateur sont disposés sur le bureau.")),
    ),
    Interactable(
      id: 'invisible-4',
      renderSettings: const InteractableRenderSettings(
        left: 130,
        bottom: 180,
        height: 60,
        width: 100,
      ),
      onTooltip: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: "Un écran d'ordinateur affichant une courbe statistique.")),
    ),
    Interactable(
      id: 'invisible-5',
      renderSettings: const InteractableRenderSettings(
        left: 270,
        bottom: 160,
        height: 60,
        width: 60,
      ),
      onTap: (escapeGame) {
        escapeGame.openDialog(const EscapeGameDialog(message: "<em>Liste de choses à faire</em><br>~~~<br><br>NE PAS OUBLIER D'ALLER ACHETER DU <strong>PAIN</strong> 🥖 EN RENTRANT DES COURS !"));
        return const ActionResult.success();
      },
    ),
    Interactable(
      id: 'invisible-6',
      renderSettings: const InteractableRenderSettings(
        left: 410,
        top: 135,
        height: 175,
        width: 160,
      ),
      onTooltip: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Il fait presque nuit dehors.')),
    ),
    Interactable(
      id: 'invisible-7',
      renderSettings: const InteractableRenderSettings(
        left: 662,
        top: 175,
        height: 24,
        width: 50,
      ),
      onTooltip: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Une boîte à chaussures.')),
    ),
    Interactable(
      id: 'invisible-8',
      renderSettings: const InteractableRenderSettings(
        top: 114,
        left: 771,
        height: 125,
        width: 7,
      ),
      onTooltip: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Un grand néon.')),
    ),
    Interactable(
      id: 'invisible-9',
      renderSettings: const InteractableRenderSettings(
        top: 111,
        left: 798,
        height: 169,
        width: 67,
      ),
      onTooltip: (escapeGame) => const ActionResult.success(
        object: InteractableTooltip(
          text: 'C\'est une photo de Mila Kunis plus jeune.',
          xShift: -120,
        ),
      ),
    ),
  ],
);
