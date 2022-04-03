import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/main.dart';
import 'package:escape_game_kit_example/widgets/messages_dialog.dart';
import 'package:flutter/material.dart';

class BedroomPresentRoom extends Room {
  static const String roomId = 'bedroom-present';

  BedroomPresentRoom()
      : super(
          id: roomId,
          firstVisitDialog: const EscapeGameDialog(message: 'Ah, vous venez enfin de rentrer des cours !'),
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
                showDialog(
                  barrierColor: Colors.black,
                  context: navigatorKey.currentContext!,
                  builder: (context) => MessagesDialog(escapeGame: escapeGame),
                );
                return const ActionResult.success();
              },
            ),
            Interactable(
              id: 'neon-1',
              renderSettings: const InteractableRenderSettings(
                top: 70,
                left: 30,
                height: 170,
                width: 8,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: "C'est un grand néon.")),
            ),
            Interactable(
              id: 'desk-computer-screens',
              renderSettings: const InteractableRenderSettings(
                left: 130,
                bottom: 110,
                height: 50,
                width: 130,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: "Des écrans d'ordinateur sont disposés sur le bureau.")),
            ),
            Interactable(
              id: 'top-computer-screen',
              renderSettings: const InteractableRenderSettings(
                left: 130,
                bottom: 180,
                height: 60,
                width: 100,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: "Un écran d'ordinateur affichant une courbe statistique.")),
            ),
            Interactable(
              id: 'papers',
              renderSettings: const InteractableRenderSettings(
                left: 270,
                bottom: 160,
                height: 60,
                width: 60,
              ),
              onTap: (escapeGame) {
                escapeGame.openDialog(const EscapeGameDialog(message: "<strong><em>Liste de choses à faire</em></strong><br>~~~<br><br>NE PAS OUBLIER DE CONSULTER LA MESSAGERIE EN RENTRANT DES COURS !"));
                return const ActionResult.success();
              },
            ),
            Interactable(
              id: 'window',
              renderSettings: const InteractableRenderSettings(
                left: 410,
                top: 135,
                height: 175,
                width: 160,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Il fait presque nuit dehors.')),
            ),
            Interactable(
              id: 'shoes-box',
              renderSettings: const InteractableRenderSettings(
                left: 662,
                top: 175,
                height: 24,
                width: 50,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Une boîte à chaussures.')),
            ),
            Interactable(
              id: 'neon-2',
              renderSettings: const InteractableRenderSettings(
                top: 114,
                left: 771,
                height: 125,
                width: 7,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Un grand néon.')),
            ),
            Interactable(
              id: 'poster',
              renderSettings: const InteractableRenderSettings(
                top: 111,
                left: 798,
                height: 169,
                width: 67,
              ),
              onHover: (escapeGame) => const ActionResult.success(
                object: InteractableTooltip(
                  text: 'C\'est une photo de Mila Kunis plus jeune.',
                  xShift: -120,
                ),
              ),
            ),
            Interactable(
              id: 'lights',
              renderSettings: const InteractableRenderSettings(
                top: 20,
                left: 342,
                height: 25,
                width: 294,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Il serait temps de changer ces ampoules.')),
            ),
            Interactable(
              id: 'laptop',
              renderSettings: const InteractableRenderSettings(
                top: 258,
                left: 262,
                height: 24,
                width: 47,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Un petit ordinateur portable.')),
            ),
            Interactable(
              id: 'pc-computer',
              renderSettings: const InteractableRenderSettings(
                top: 236,
                left: 302,
                height: 48,
                width: 84,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'C\'est un ordinateur fixe.')),
            ),
            Interactable(
              id: 'draws',
              renderSettings: const InteractableRenderSettings(
                top: 303,
                left: 38,
                height: 62,
                width: 65,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Rien dans ces tiroirs.')),
            ),
            Interactable(
              id: 'hi-fi',
              renderSettings: const InteractableRenderSettings(
                top: 239,
                left: 877,
                height: 81,
                width: 53,
              ),
              onHover: (escapeGame) => const ActionResult.success(
                object: InteractableTooltip(
                  text: 'Une chaîne HiFi qui à l\'air vraiment moderne !',
                  xShift: -240,
                ),
              ),
            ),
            Interactable(
              id: 'outlet',
              renderSettings: const InteractableRenderSettings(
                top: 354,
                left: 270,
                height: 16,
                width: 48,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Attention, c\'est dangereux.')),
            ),
            Interactable(
              id: 'gaming-computer',
              renderSettings: const InteractableRenderSettings(
                top: 301,
                left: 162,
                height: 57,
                width: 54,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Une tour gaming !')),
            ),
            Interactable(
              id: 'mug',
              renderSettings: const InteractableRenderSettings(
                top: 286,
                left: 606,
                height: 24,
                width: 24,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Le tasse n\'a pas été lavée...')),
            ),
            Interactable(
              id: 'bass',
              renderSettings: const InteractableRenderSettings(
                top: 122,
                left: 629,
                height: 26,
                width: 76,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Des basses !')),
            ),
            Interactable(
              id: 'nightstand',
              renderSettings: const InteractableRenderSettings(
                top: 306,
                left: 596,
                height: 49,
                width: 51,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Une table de nuit.')),
            ),
            Interactable(
              id: 'bed',
              renderSettings: const InteractableRenderSettings(
                top: 278,
                left: 646,
                height: 82,
                width: 225,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Il n\'est pas encore l\'heure de dormir !')),
            ),
            Interactable(
              id: 'books',
              renderSettings: const InteractableRenderSettings(
                top: 196,
                left: 892,
                height: 20,
                width: 38,
              ),
              onHover: (escapeGame) => const ActionResult.success(
                object: InteractableTooltip(
                  text: 'Ce ne sont pas des livres de maths !',
                  xShift: -240,
                ),
              ),
            ),
            Interactable(
              id: 'desktop-computer',
              renderSettings: const InteractableRenderSettings(
                top: 210,
                left: 102,
                height: 73,
                width: 27,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Un ordinateur de bureau.')),
            ),
          ],
        );
}
