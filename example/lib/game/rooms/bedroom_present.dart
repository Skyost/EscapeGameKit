import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/game/game.dart';
import 'package:escape_game_kit_example/widgets/main_widget.dart';
import 'package:escape_game_kit_example/widgets/messages_dialog.dart';
import 'package:flutter/material.dart';

/// The present bedroom.
class BedroomPresentRoom extends Room {
  /// The room id.
  static const String roomId = 'bedroom-present';

  /// Creates a new [BedroomPresentRoom] instance.
  BedroomPresentRoom()
      : super(
          id: roomId,
          onFirstVisit: (escapeGame) {
            escapeGame.showDialog(const EscapeGameDialog(content: '<em>Ah, finished !<br>Your day is over and you have finally come home from school !</em>'));
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
                showDialog(
                  barrierColor: Colors.black,
                  context: navigatorKey.currentContext!,
                  builder: (context) => MessagesDialog(escapeGame: escapeGame as Error1980EscapeGame),
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
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: "It's a big neon.")),
            ),
            Interactable(
              id: 'desk-computer-screens',
              renderSettings: const InteractableRenderSettings(
                left: 130,
                bottom: 110,
                height: 50,
                width: 130,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: "Computer screens are arranged on the desk.")),
            ),
            Interactable(
              id: 'top-computer-screen',
              renderSettings: const InteractableRenderSettings(
                left: 130,
                bottom: 180,
                height: 60,
                width: 100,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: "A computer screen displaying a statistical curve.")),
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
                escapeGame.showDialog(const EscapeGameDialog(
                  title: 'Things to do',
                  content: "An exam is scheduled for tomorrow, I should <strong>above all</strong> not forget to check my messages once I come back from school !!",
                ));
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
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: "It's almost dark outside.")),
            ),
            Interactable(
              id: 'shoes-box',
              renderSettings: const InteractableRenderSettings(
                left: 662,
                top: 175,
                height: 24,
                width: 50,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'A shoebox.')),
            ),
            Interactable(
              id: 'neon-2',
              renderSettings: const InteractableRenderSettings(
                top: 114,
                left: 771,
                height: 125,
                width: 7,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Another big neon.')),
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
                object: InteractableTooltip(text: "It's a picture of young Mila Kunis."),
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
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: "It's time to change those bulbs.")),
            ),
            Interactable(
              id: 'laptop',
              renderSettings: const InteractableRenderSettings(
                top: 258,
                left: 262,
                height: 24,
                width: 47,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'A small laptop.')),
            ),
            Interactable(
              id: 'pc-computer',
              renderSettings: const InteractableRenderSettings(
                top: 236,
                left: 302,
                height: 48,
                width: 84,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'It is a fixed computer.')),
            ),
            Interactable(
              id: 'draws',
              renderSettings: const InteractableRenderSettings(
                top: 303,
                left: 38,
                height: 62,
                width: 65,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Nothing in these draws')),
            ),
            Interactable(
              id: 'hi-fi',
              renderSettings: const InteractableRenderSettings(
                top: 239,
                left: 877,
                height: 81,
                width: 53,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'A HiFi system that looks really modern !')),
            ),
            Interactable(
              id: 'outlet',
              renderSettings: const InteractableRenderSettings(
                top: 354,
                left: 270,
                height: 16,
                width: 48,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Warning, it\'s dangerous.')),
            ),
            Interactable(
              id: 'gaming-computer',
              renderSettings: const InteractableRenderSettings(
                top: 301,
                left: 162,
                height: 57,
                width: 54,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'A gaming machine !')),
            ),
            Interactable(
              id: 'mug',
              renderSettings: const InteractableRenderSettings(
                top: 286,
                left: 606,
                height: 24,
                width: 24,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'The cup has not been washed...')),
            ),
            Interactable(
              id: 'bass',
              renderSettings: const InteractableRenderSettings(
                top: 122,
                left: 629,
                height: 26,
                width: 76,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Some basses !')),
            ),
            Interactable(
              id: 'nightstand',
              renderSettings: const InteractableRenderSettings(
                top: 306,
                left: 596,
                height: 49,
                width: 51,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'A nightstand.')),
            ),
            Interactable(
              id: 'bed',
              renderSettings: const InteractableRenderSettings(
                top: 278,
                left: 646,
                height: 82,
                width: 225,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'It\'s not time to sleep yet !')),
            ),
            Interactable(
              id: 'books',
              renderSettings: const InteractableRenderSettings(
                top: 196,
                left: 892,
                height: 20,
                width: 38,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'These are not math books !')),
            ),
            Interactable(
              id: 'desktop-computer',
              renderSettings: const InteractableRenderSettings(
                top: 210,
                left: 102,
                height: 73,
                width: 27,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'A desktop computer.')),
            ),
          ],
        );
}
