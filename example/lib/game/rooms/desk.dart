import 'dart:math';

import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/game/objects/bookshelf_key.dart';
import 'package:escape_game_kit_example/game/padlocks/qr_padlock.dart';

/// The desk.
class DeskRoom extends Room {
  /// The room id.
  static const String roomId = 'desk';

  /// Creates a new [DeskRoom] instance.
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
                  text: 'Go to the bedroom',
                  xShift: -50,
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
              padlock: QrPadlock(),
              clueDialog: const EscapeGameDialog(
                title: 'Hint on a padlock',
                content: "<em>So we're stuck in 1980 !? But how to get out of here ?<br>Here, there's another message in the chest...</em><br><br><strong>1! = 1 ; 2! = 2 ; 3! = 6 ; 4! = 24 ; 5! = <em>?</em></strong>",
              ),
            ),
            Clue.dialog(
              id: 'bookshelf',
              renderSettings: const InteractableRenderSettings(
                top: 48,
                left: 106,
                height: 238,
                width: 157,
              ),
              keyId: CloverKey.objectId,
              clueDialog: const EscapeGameDialog(
                title: 'Hint on the command',
                content: '<em>You have unlocked this bookshelf thanks to the clover shaped key... And there is a computer manual inside !</em><br><br>To restart a computer, use the following command. <p style="text-align: left; background-color: black; color: white; font-family: SourceCodePro; padding: 8px 4px;">reboot now</p>',
              ),
              noKeyDialog: const EscapeGameDialog(
                title: 'Locked bookshelf',
                content: "<em>The bookshelf has been locked with a key, and you don't have it.</em>",
              ),
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
                title: 'Hint on the password',
                content:
                    "<em>There is a message...</em><br><br>I don't usually write down my passwords on paper.... So I only noted hints, and on several papers hidden all over the house !<br>Here's the first hint<br><br>Aladdin and Aladde rub the lamp. The genie appears and asks them to make a wish. Aladdin asks <q>I want a penny... But it has to double every day for 30 days !</q>. Aladde retorts <q>Hehe, I want 1 million pounds now!</q><br><br><strong>The first digit of the computer password is pronounced in french like the last two letters of the richest person's name after 30 days.</strong>",
              ),
              noKeyDialog: const EscapeGameDialog(content: '<em>This draw has been locked with a key, and you don\'t have it.</em>'),
            ),
            Interactable(
              id: 'books-1',
              renderSettings: const InteractableRenderSettings(
                top: 122,
                left: 532,
                height: 42,
                width: 40,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Books are piled up here.')),
            ),
            Interactable(
              id: 'books-2',
              renderSettings: const InteractableRenderSettings(
                top: 144,
                left: 468,
                height: 17,
                width: 48,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'A book is spread out.')),
            ),
            Interactable(
              id: 'books-3',
              renderSettings: const InteractableRenderSettings(
                top: 167,
                left: 470,
                height: 39,
                width: 40,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'More books.')),
            ),
            Interactable(
              id: 'books-4',
              renderSettings: const InteractableRenderSettings(
                top: 206,
                left: 469,
                height: 43,
                width: 93,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Still books, but not math books...')),
            ),
            Interactable(
              id: 'chair-1',
              renderSettings: const InteractableRenderSettings(
                top: 195,
                left: 270,
                height: 153,
                width: 233,
              ),
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: "'It's a big chair.'")),
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
                  text: 'This is an office chair !',
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
              onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: 'Oh, an inkwell !')),
            ),
            Interactable(
              id: 'floor',
              renderSettings: const InteractableRenderSettings(
                top: 349,
                left: 266,
                height: 22,
                width: 634,
              ),
              onHover: (escapeGame) => const ActionResult.success(
                object: InteractableTooltip(
                  text: 'The moonlight is reflected on the ground.',
                  yShift: -20,
                ),
              ),
            ),
          ],
        );
}
