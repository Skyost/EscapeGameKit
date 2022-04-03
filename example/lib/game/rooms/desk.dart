import 'dart:math';

import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/game/objects/painting_key.dart';
import 'package:escape_game_kit_example/game/padlocks/painting_padlock.dart';

class DeskRoom extends Room {
  static const String roomId = 'desk';

  DeskRoom() : super(
          id: roomId,
          interactables: [
            Door(
              id: 'bedroom-door',
              renderSettings: InteractableRenderSettings(
                asset: 'assets/interactables/arrow.svg',
                top: 200,
                right: 20,
                height: 80,
                width: 80,
                rotationAngle: pi / 2 + 0.2,
                hoverAnimation: InteractableAnimation(type: InteractableAnimationType.pulse),
              ),
              onHover: (escapeGame) => const ActionResult.success(
                object: InteractableTooltip(
                  text: 'Vers la chambre',
                  xShift: -20,
                ),
              ),
              roomId: 'bedroom',
            ),
            Clue.dialog(
              id: 'painting',
              renderSettings: const InteractableRenderSettings(
                top: 40,
                left: 280,
                height: 80,
                width: 100,
              ),
              keyId: PaintingKey.objectId,
              padlock: PaintingPadlock(),
              clueDialog: const EscapeGameDialog(message: "Nous sommes bloqués en 1980 !? Mais comment sortir d'ici ?<br>Tiens, il y a un autre message dans le coffre...<br><br><em>1! = 1 ; 2! = 2 ; 3! = 6 ; 4! = 24 ; 5! = <strong>?</strong></em>"),
              noKeyDialog: const EscapeGameDialog(message: 'Le coffre derrière ce tableau est protégé par un cadenas fermé à clé...'),
            ),
            Clue.dialog(
              id: 'bookshelf',
              renderSettings: const InteractableRenderSettings(
                top: 48,
                left: 106,
                height: 238,
                width: 157,
              ),
              clueDialog: const EscapeGameDialog(message: 'Il y a un manuel d\'informatique !<br><br>Pour redémarrer un ordinateur, utiliser la commande suivante. <p style="text-align: left; background-color: black; color: white; font-family: SourceCodePro; padding: 8px 4px;">reboot now</p>'),
              noKeyDialog: const EscapeGameDialog(message: 'Cette bibliothèque est protégée par un cadenas fermé à clé...'),
            ),
            Clue.dialog(
              id: 'drawer',
              renderSettings: const InteractableRenderSettings(
                top: 232,
                left: 556,
                height: 38,
                width: 138,
              ),
              clueDialog: const EscapeGameDialog(
                message:
                    "Il y a un message...<br><br><em>Je n'ai pas pour habitude de noter mes mots de passe sur un papier... Je n'ai donc noté que des indices, et sûr plusieurs papiers cachés partout dans la maison !<br>Voici donc le premier indice.</em><br><br><em>Aladdin et Aladde frottent la lampe. Le génie apparaît et leur demande de formuler un vœu. Aladdin demande <q>Je veux un centime... Mais que celui-ci se dédouble tous les jours pendant 30 jours !</q>. Aladdin rétorque <q>Héhé, moi je veux 1 million d'euros maintenant !</q></em><br><br>Le premier chiffre du mot de passe se prononce comme les deux derniers lettres du nom du plus riche à l'issue des 30 jours.",
              ),
              noKeyDialog: const EscapeGameDialog(message: 'Ce tiroir est protégée par un cadenas fermé à clé...'),
            ),
          ],
        );
}
