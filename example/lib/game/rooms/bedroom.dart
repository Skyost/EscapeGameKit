import 'dart:math';

import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/game/objects/clover_key.dart';
import 'package:escape_game_kit_example/game/objects/mouth_key.dart';
import 'package:escape_game_kit_example/game/padlocks/bruteforce_padlock.dart';
import 'package:escape_game_kit_example/game/padlocks/computer_padlock.dart';

/// The bedroom.
class BedroomRoom extends Room {
  /// The room id.
  static const String roomId = 'bedroom';

  /// Creates a new [BedroomRoom] instance.
  BedroomRoom({
    EscapeGameObject mouthKey = const MouthKey(),
  }) : super(
          id: roomId,
          onFirstVisit: (escapeGame) {
            escapeGame.openDialog(const EscapeGameDialog(message: "<em>Shit, what has just happened ?<br>And above all, where are we !?</em>"));
            return const ActionResult.success();
          },
          interactables: [
            Door(
              id: 'desk-door',
              renderSettings: InteractableRenderSettings(
                asset: 'assets/interactables/arrow.svg',
                top: 200,
                left: 20,
                height: 80,
                width: 80,
                rotationAngle: -pi / 2 - 0.2,
                hoverAnimation: InteractableAnimation(type: InteractableAnimationType.pulse),
              ),
              onTap: (escapeGame) {
                if (!escapeGame.inventory.hasObject(mouthKey)) {
                  escapeGame.openDialog(const EscapeGameDialog(
                    title: 'Door locked',
                    message: "<em>Damn, the desk door is locked, and you don't have the key !</em>",
                  ));
                  return const ActionResult.failed();
                }
                return const ActionResult.success();
              },
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Go to the desk')),
              roomId: 'desk',
            ),
            Door(
              id: 'living-room-door',
              renderSettings: InteractableRenderSettings(
                asset: 'assets/interactables/arrow.svg',
                top: 200,
                right: 20,
                height: 80,
                width: 80,
                rotationAngle: pi / 2 + 0.2,
                hoverAnimation: InteractableAnimation(type: InteractableAnimationType.pulse),
              ),
              onTap: (escapeGame) {
                if (!escapeGame.inventory.hasObject(mouthKey)) {
                  escapeGame.openDialog(const EscapeGameDialog(
                    title: 'Door locked',
                    message: "<em>Damn, the living room door is locked, and you don't have the key !</em>",
                  ));
                  return const ActionResult.failed();
                }
                return const ActionResult.success();
              },
              onHover: (escapeGame) => const ActionResult.success(
                object: InteractableTooltip(
                  text: 'Go to the living room',
                  xShift: -50,
                ),
              ),
              roomId: 'living-room',
            ),
            Door(
              id: 'computer',
              renderSettings: const InteractableRenderSettings(
                top: 225,
                left: 410,
                height: 60,
                width: 60,
              ),
              roomId: 'bedroom-final',
              padlock: PadlockSequence(
                padlocks: [
                  CredentialsPadlock(
                    username: 'htam',
                    password: '146',
                    caseSensitive: false,
                    title: 'Login',
                    unlockMessage: 'Oh no, we need to login !',
                    failedToUnlockMessage: 'Cannot login... There must be an error somewhere.',
                  ),
                  ComputerPadlock(),
                ],
              ),
            ),
            Interactable(
              id: 'mirror',
              renderSettings: const InteractableRenderSettings(
                top: 130,
                left: 280,
                height: 80,
                width: 60,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'A big mirror.')),
            ),
            Interactable(
              id: 'top-drawers',
              renderSettings: const InteractableRenderSettings(
                top: 290,
                left: 250,
                height: 30,
                width: 70,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: "There's nothing in the first two draws.")),
            ),
            PickableObject(
              object: mouthKey,
              renderSettings: const InteractableRenderSettings(
                top: 320,
                left: 250,
                height: 15,
                width: 70,
              ),
              padlock: BruteforcePadlock(),
              onPickedUp: (escapeGame) {
                escapeGame.openDialog(EscapeGameDialog(
                  title: 'Object found !',
                  imageRenderSettings: RenderSettings(
                    asset: mouthKey.inventoryRenderSettings?.asset,
                    width: 100,
                    height: 100,
                  ),
                  message: '<em>You just found a mouth shaped key !</em>',
                ));
                return const ActionResult.success();
              },
              removedTooltip: const InteractableTooltip(text: "You've found a key in this draw."),
            ),
            Interactable(
              id: 'wardrobe',
              renderSettings: const InteractableRenderSettings(
                top: 143,
                left: 100,
                height: 217,
                width: 100,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'This is just a wardrobe.')),
            ),
            Interactable(
              id: 'window',
              renderSettings: const InteractableRenderSettings(
                top: 134,
                left: 424,
                height: 213,
                width: 122,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'It\'s still dark outside.')),
            ),
            Clue.dialog(
              id: 'bed-chest',
              renderSettings: const InteractableRenderSettings(
                top: 279,
                left: 636,
                height: 78,
                width: 288,
              ),
              keyId: EightKey.objectId,
              clueDialog: const EscapeGameDialog(
                title: 'Hint on the password',
                message: "<em>You have unlocked this chest using the eight shaped key... And there is a message !</em><br><br>Rabbits and chickens are in the garden. We don't know how many there are, but we can count 20 paws and 6 heads.<br><br><strong>The second digit of the computer password is the rabbit count.</strong>",
              ),
              noKeyDialog: const EscapeGameDialog(
                title: 'Locked chest',
                message: '<em>There seems to be a chest under this bed, but it has been locked with a key, and you don\'t have it...</em>',
              ),
            ),
            Clue.dialog(
              id: 'lamp',
              renderSettings: const InteractableRenderSettings(
                top: 230,
                left: 288,
                height: 44,
                width: 38,
              ),
              clueDialog: const EscapeGameDialog(
                title: 'Hint on a padlock',
                message: "<em>There seems to be a hint behind this lamp !</em><br><br>I was always forgetting the code of the chest padlock that is hidden in the flower pot in the living room... But now no more worries !<br>To unlock it, we just need to input the number of possible 3-digit code combinations !",
              ),
            ),
            Interactable(
              id: 'candles',
              renderSettings: const InteractableRenderSettings(
                top: 218,
                left: 247,
                height: 55,
                width: 31,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Some candles are lighting up the room.')),
            ),
          ],
        );
}
