import 'dart:math';

import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/game/objects/bookshelf_key.dart';
import 'package:escape_game_kit_example/game/objects/painting_key.dart';
import 'package:escape_game_kit_example/game/padlocks/painting_padlock.dart';

class DeskRoom extends Room {
  static const String roomId = 'desk';

  DeskRoom()
      : super(
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
              clueDialog: const EscapeGameDialog(message: "<em>Nous sommes bloqués en 1980 !? Mais comment sortir d'ici ?<br>Tiens, il y a un autre message dans le coffre...</em><br><br><strong>1! = 1 ; 2! = 2 ; 3! = 6 ; 4! = 24 ; 5! = <em>?</em></strong>"),
              noKeyDialog: const EscapeGameDialog(message: '<em>Le coffre derrière ce tableau est protégé par un cadenas fermé à clé, et vous ne possédez pas cette clé...</em>'),
            ),
            Clue.dialog(
              id: 'bookshelf',
              renderSettings: const InteractableRenderSettings(
                top: 48,
                left: 106,
                height: 238,
                width: 157,
              ),
              keyId: BookshelfKey.objectId,
              clueDialog: const EscapeGameDialog(message: '<em>Vous avez déverrouillez cette bibliothèque à l\'aide de la clé en forme de trèfle... Et il y a un manuel d\'informatique à l\'intérieur !</em><br><br>Pour redémarrer un ordinateur, utiliser la commande suivante. <p style="text-align: left; background-color: black; color: white; font-family: SourceCodePro; padding: 8px 4px;">reboot now</p>'),
              noKeyDialog: const EscapeGameDialog(message: "<em>Cette bibliothèque est protégée par un cadenas fermé à clé, et vous ne possédez pas cette clé...</em>"),
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
                    "<em>Il y a un message...</em><br><br>Je n'ai pas pour habitude de noter mes mots de passe sur un papier... Je n'ai donc noté que des indices, et sûr plusieurs papiers cachés partout dans la maison !<br>Voici donc le premier indice.<br><br>Aladdin et Aladde frottent la lampe. Le génie apparaît et leur demande de formuler un vœu. Aladdin demande <q>Je veux un centime... Mais que celui-ci se dédouble tous les jours pendant 30 jours !</q>. Aladde rétorque <q>Héhé, moi je veux 1 million d'euros maintenant !</q><br><br><strong>Le premier chiffre du mot de passe de l'ordinateur se prononce comme les deux dernières lettres du nom du plus riche à l'issue des 30 jours.</strong>",
              ),
              noKeyDialog: const EscapeGameDialog(message: '<em>Ce tiroir est protégée par un cadenas fermé à clé, et vous ne possédez pas cette clé...</em>'),
            ),
            Interactable(
              id: 'books-1',
              renderSettings: const InteractableRenderSettings(
                top: 122,
                left: 532,
                height: 42,
                width: 40,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Des livres sont entassés ici.')),
            ),
            Interactable(
              id: 'books-2',
              renderSettings: const InteractableRenderSettings(
                top: 144,
                left: 468,
                height: 17,
                width: 48,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Un livre est étalé.')),
            ),
            Interactable(
              id: 'books-3',
              renderSettings: const InteractableRenderSettings(
                top: 167,
                left: 470,
                height: 39,
                width: 40,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Encore des livres.')),
            ),
            Interactable(
              id: 'books-4',
              renderSettings: const InteractableRenderSettings(
                top: 206,
                left: 469,
                height: 43,
                width: 93,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Toujours des livres, mais pas des livres de maths...')),
            ),
            Interactable(
              id: 'chair-1',
              renderSettings: const InteractableRenderSettings(
                top: 195,
                left: 270,
                height: 153,
                width: 233,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'C\'est un grand fauteuil.')),
            ),
            Interactable(
              id: 'chair-2',
              renderSettings: const InteractableRenderSettings(
                top: 157,
                left: 755,
                height: 207,
                width: 100,
              ),
              onHover: (escapeGame) => const ActionResult.success(
                object: InteractableTooltip(
                  text: 'Ça c\'est de la chaise de bureau !',
                  xShift: -100,
                ),
              ),
            ),
            Interactable(
              id: 'inkwell',
              renderSettings: const InteractableRenderSettings(
                top: 177,
                left: 662,
                height: 50,
                width: 106,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Oh, un encrier !')),
            ),
            Interactable(
              id: 'floor',
              renderSettings: const InteractableRenderSettings(
                top: 372,
                left: 274,
                height: 10,
                width: 386,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Le clair de la lune se reflète sur le sol.')),
            ),
          ],
        );
}
