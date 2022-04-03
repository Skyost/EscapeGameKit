import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/game/objects/bed_key.dart';
import 'package:escape_game_kit_example/game/objects/bookshelf_key.dart';

class LinvingRoomRoom extends Room {
  static const String roomId = 'living-room';

  LinvingRoomRoom({
    EscapeGameObject bookshelfKey = const BookshelfKey(),
    EscapeGameObject bedKey = const BedKey(),
  }) : super(
          id: roomId,
          interactables: [
            Door(
              id: 'bedroom-door',
              renderSettings: InteractableRenderSettings(
                asset: 'assets/interactables/arrow.svg',
                top: 100,
                left: 20,
                height: 80,
                width: 80,
                rotationAngle: -1,
                hoverAnimation: InteractableAnimation(type: InteractableAnimationType.pulse),
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Vers la chambre')),
              roomId: 'bedroom',
            ),
            PickableObject(
              renderSettings: const InteractableRenderSettings(
                top: 302,
                left: 610,
                height: 38,
                width: 38,
              ),
              object: bedKey,
              padlock: DigitsPadlock(
                title: 'Entrer le code',
                unlockMessage: 'Ce placard est protégé par un cadenas !',
                failedToUnlockMessage: "Mince, ce n'est pas le bon code...",
                digits: '120',
              ),
              onPickedUp: (escapeGame) {
                escapeGame.openDialog(EscapeGameDialog(
                  title: 'Object trouvé !',
                  imageRenderSettings: RenderSettings(
                    asset: bedKey.inventoryRenderSettings?.asset,
                    width: 100,
                    height: 100,
                  ),
                  message: 'Vous avez trouvé une clé !',
                ));
                return const ActionResult.success();
              },
              removedTooltip: const InteractableTooltip(text: 'Vous avez trouvé une clé dans ce placard.'),
            ),
            PickableObject(
              renderSettings: const InteractableRenderSettings(
                top: 261,
                left: 8,
                height: 109,
                width: 50,
              ),
              object: bookshelfKey,
              padlock: DigitsPadlock(
                title: 'Entrer le code',
                unlockMessage: 'Il y a un coffre dans le pot de fleur... Mais il est protégé par un cadenas !',
                failedToUnlockMessage: "Mince, ce n'est pas le bon code...",
                digits: '1000',
              ),
              onPickedUp: (escapeGame) {
                escapeGame.openDialog(EscapeGameDialog(
                  title: 'Object trouvé !',
                  imageRenderSettings: RenderSettings(
                    asset: bookshelfKey.inventoryRenderSettings?.asset,
                    width: 100,
                    height: 100,
                  ),
                  message: 'Vous avez trouvé une clé !',
                ));
                return const ActionResult.success();
              },
              removedTooltip: const InteractableTooltip(text: 'Vous avez trouvé une clé dans ce pot de fleur.'),
            ),
            Interactable(
              id: 'frame-1',
              renderSettings: const InteractableRenderSettings(
                top: 132,
                left: 290,
                height: 76,
                width: 71,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Joli cadre... Bien qu\'un peu vide.')),
            ),
            Interactable(
              id: 'frame-2',
              renderSettings: const InteractableRenderSettings(
                top: 135,
                left: 623,
                height: 83,
                width: 74,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Ce cadre semble également vide.')),
            ),
            Interactable(
              id: 'frame-3',
              renderSettings: const InteractableRenderSettings(
                top: 113,
                left: 452,
                height: 102,
                width: 90,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Du marbre surplombe la cheminée.')),
            ),
            Interactable(
              id: 'fire',
              renderSettings: const InteractableRenderSettings(
                top: 285,
                left: 465,
                height: 60,
                width: 69,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Attention, ça brule !')),
            ),
            Interactable(
              id: 'flowerpot',
              renderSettings: const InteractableRenderSettings(
                top: 272,
                left: 855,
                height: 93,
                width: 41,
              ),
              onHover: (escapeGame) => const ActionResult.success(
                object: InteractableTooltip(
                  text: 'Ce n\'est qu\'un pot de fleur comme un autre...',
                  xShift: -200,
                ),
              ),
            ),
            Interactable(
              id: 'chair-1',
              renderSettings: const InteractableRenderSettings(
                top: 246,
                left: 56,
                height: 114,
                width: 112,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Quel grand fauteuil.')),
            ),
            Interactable(
              id: 'chair-2',
              renderSettings: const InteractableRenderSettings(
                top: 257,
                left: 714,
                height: 97,
                width: 94,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Joli fauteuil !')),
            ),
            Clue.dialog(
              id: 'pillow-1',
              renderSettings: const InteractableRenderSettings(
                top: 286,
                left: 224,
                height: 31,
                width: 44,
              ),
              clueDialog: const EscapeGameDialog(message: "<em>Dans un étang non loin d'ici, j'ai remarqué que le nombre de nénuphars doublait chaque nuit... Au début il y en a 1, puis 2 le lendemain, puis 4 le surlendemain, etc. si bien que l'étang est recouvert de nénuphars en 7 jours seulement !</em><br><br>Le troisième et dernier chiffre de mon mot de passe est le nombre de jour qu'il faut pour que l'étang soit recouvert si au début il y a non pas 1, mais 2 nénuphars."),
            ),
            Interactable(
              id: 'pilow-2',
              renderSettings: const InteractableRenderSettings(
                top: 289,
                left: 290,
                height: 31,
                width: 38,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Un coussin... Sans rien derrière.')),
            ),
            Interactable(
              id: 'window',
              renderSettings: const InteractableRenderSettings(
                top: 128,
                left: 822,
                height: 228,
                width: 89,
              ),
              onHover: (escapeGame) => const ActionResult.success(
                object: InteractableTooltip(
                  text: 'Il fait encore nuit dehors.',
                  xShift: -160,
                ),
              ),
            ),
          ],
        );
}
