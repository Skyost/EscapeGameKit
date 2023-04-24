import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/game/objects/bookshelf_key.dart';
import 'package:escape_game_kit_example/game/objects/clover_key.dart';
import 'package:escape_game_kit_example/game/padlocks/caesar_padlock.dart';
import 'package:escape_game_kit_example/widgets/object_found_dialog_content.dart';

/// The living room.
class LinvingRoomRoom extends Room {
  /// The room id.
  static const String roomId = 'living-room';

  /// Creates a new [LinvingRoomRoom] instance.
  LinvingRoomRoom()
      : super(
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
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Go to the bedroom')),
              roomId: 'bedroom',
            ),
            PickableObject(
              renderSettings: const InteractableRenderSettings(
                top: 302,
                left: 610,
                height: 38,
                width: 38,
              ),
              object: const EightKey(),
              padlock: DigitsPadlock(
                title: 'Padlock',
                unlockMessage: 'This cupboard is protected by a code padlock !\nThere must be a hint somewhere.',
                failedToUnlockMessage: "Goddamn, this is not working...",
                digits: '120',
              ),
              onPickedUp: (escapeGame) {
                escapeGame.showDialog(const EscapeGameDialog(
                  title: 'Object found !',
                  content: ObjectFoundDialogContent(
                    asset: EightKey.asset,
                    message: '<em>You just found a <strong>eight shaped key</strong> !</em>',
                  ),
                ));
                return const ActionResult.success();
              },
              removedTooltip: const InteractableTooltip(text: "You've found a key in this cupboard."),
            ),
            PickableObject(
              renderSettings: const InteractableRenderSettings(
                top: 261,
                left: 8,
                height: 109,
                width: 50,
              ),
              object: const CloverKey(),
              padlock: DigitsPadlock(
                title: 'Padlock',
                unlockMessage: 'There is a chest in this flowerpot... But it is protected by a code padlock !\nThere must be a hint somewhere.',
                failedToUnlockMessage: "Damn, that's not the code...",
                digits: '1000',
              ),
              onPickedUp: (escapeGame) {
                escapeGame.showDialog(const EscapeGameDialog(
                  title: 'Object found !',
                  content: ObjectFoundDialogContent(
                    asset: CloverKey.asset,
                    message: '<em>You just found a <strong>clover shaped key</strong> !</em>',
                  ),
                ));
                return const ActionResult.success();
              },
              removedTooltip: const InteractableTooltip(text: "You've found a key in this flowerpot."),
            ),
            Interactable(
              id: 'frame-1',
              renderSettings: const InteractableRenderSettings(
                top: 132,
                left: 290,
                height: 76,
                width: 71,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Nice frame... Although a little empty.')),
            ),
            Interactable(
              id: 'frame-2',
              renderSettings: const InteractableRenderSettings(
                top: 135,
                left: 623,
                height: 83,
                width: 74,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'This frame also seems a bit empty.')),
            ),
            Interactable(
              id: 'frame-3',
              renderSettings: const InteractableRenderSettings(
                top: 113,
                left: 452,
                height: 102,
                width: 90,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Marble overhangs the fireplace.')),
            ),
            Interactable(
              id: 'fire',
              renderSettings: const InteractableRenderSettings(
                top: 285,
                left: 465,
                height: 60,
                width: 69,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Careful, it\'s hot !')),
            ),
            Interactable(
              id: 'chair-1',
              renderSettings: const InteractableRenderSettings(
                top: 246,
                left: 56,
                height: 114,
                width: 112,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'What a big chair.')),
            ),
            Interactable(
              id: 'chair-2',
              renderSettings: const InteractableRenderSettings(
                top: 257,
                left: 714,
                height: 97,
                width: 94,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Nice chair !')),
            ),
            Clue.dialog(
              id: 'pillow-1',
              renderSettings: const InteractableRenderSettings(
                top: 286,
                left: 224,
                height: 31,
                width: 44,
              ),
              padlock: CaesarPadlock(),
              clueDialog: const EscapeGameDialog(
                title: 'Hint on the password',
                content:
                    "<em>An hint is behind the pillow !</em><br><br>In a pond not far from here, I noticed that the number of water lilies doubles every night... At first there is 1, then 2 the next day, then 4 the day after, etc. so much so that the pond is covered with water lilies in just 7 days !<br><br><strong>The third and last digit of the computer password is the number of days it takes for the pond to be covered if at the beginning there are not 1, but 2 water lilies.</strong>",
              ),
            ),
            Interactable(
              id: 'pilow-2',
              renderSettings: const InteractableRenderSettings(
                top: 289,
                left: 290,
                height: 31,
                width: 38,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'A pillow... With nothing behind it.')),
            ),
            Interactable(
              id: 'window',
              renderSettings: const InteractableRenderSettings(
                top: 128,
                left: 822,
                height: 228,
                width: 89,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'It is still dark outside.')),
            ),
            Interactable(
              id: 'table',
              renderSettings: const InteractableRenderSettings(
                top: 309,
                left: 344,
                height: 59,
                width: 138,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'A table with nothing on it.')),
            ),
            Interactable(
              id: 'lamp-1',
              renderSettings: const InteractableRenderSettings(
                top: 252,
                left: 597,
                height: 47,
                width: 30,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'A small bedside lamp.')),
            ),
            Interactable(
              id: 'lamp-2',
              renderSettings: const InteractableRenderSettings(
                top: 206,
                left: 698,
                height: 148,
                width: 38,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'It\'s a big lamp, but it has been turned off.')),
            ),
            Clue.dialog(
              id: 'sofa',
              renderSettings: const InteractableRenderSettings(
                top: 341,
                left: 175,
                height: 22,
                width: 190,
              ),
              clueDialog: const EscapeGameDialog(
                title: "Hint on the username",
                content:
                    "<em>There's a message under the couch !</em><br><br>I always forget my username to login to my computer... But I know it's the name of my favorite school subject backwards !",
              ),
            ),
            Interactable(
              id: 'flowerpot',
              renderSettings: const InteractableRenderSettings(
                top: 272,
                left: 855,
                height: 93,
                width: 41,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: "It's just a flower pot like any other...", xShift: -200)),
            ),
          ],
        );
}
