import 'dart:math';

import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/objects/painting_key.dart';
import 'package:escape_game_kit_example/padlocks/painting_padlock.dart';

final Room desk = Room(
  id: 'desk',
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
      onTooltip: (escapeGame) => const ActionResult.success(
        object: InteractableTooltip(
          text: 'Vers la chambre',
          xShift: -20,
        ),
      ),
      roomId: 'bedroom',
    ),
    Clue(
      id: 'painting',
      renderSettings: const InteractableRenderSettings(
        top: 40,
        left: 280,
        height: 80,
        width: 100,
      ),
      keyId: paintingKey.id,
      padlock: PaintingPadlock(),
      clueDialog: const EscapeGameDialog(message: "Nous sommes bloqués en 1980 !? Mais comment sortir d'ici ?<br>Tiens, il y a un autre message dans le coffre...<br><br>« 1! = 1 ; 2! = 2 ; 3! = 6 ; 4! = 24 ; 5! = <em>?</em> »"),
      foundTooltip: const InteractableTooltip(text: 'Vous avez trouvé un indice derrière ce tableau.'),
      noKeyDialog: const EscapeGameDialog(message: 'Le coffre derrière ce tableau est protégé par un cadenas fermé à clé...'),
    ),
    Clue(
      id: 'wardrobe',
      renderSettings: const InteractableRenderSettings(
        top: 48,
        left: 106,
        height: 238,
        width: 157,
      ),
      clueDialog: const EscapeGameDialog(message: "Il y a un manuel d'informatique !<br><br>Pour redémarrer un ordinateur, utiliser la commande <pre>reboot now</pre>."),
      foundTooltip: const InteractableTooltip(text: 'Vous avez trouvé un indice dans cette armoire.'),
      noKeyDialog: const EscapeGameDialog(message: 'Cette armoire est protégée par un cadenas fermé à clé...'),
    ),
  ],
);
