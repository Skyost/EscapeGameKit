import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/widgets/padlock_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A padlock that can be unlocked by entering the good digits, which is encrypted using a Caesar code.
class CaesarPadlock extends ObjectEqualPadlock<String> {
  /// Creates a new [CaesarPadlock] instance.
  CaesarPadlock()
      : super(
          title: 'Padlock',
          unlockMessage: 'It seems to be a padlock with a strange wheel...',
          failedToUnlockMessage: "This code doesn't work.",
        );

  @override
  bool isObjectValid(String object) => object.toLowerCase() == '50';
}

/// Allows to unlock a [CaesarPadlock].
class CaesarPadlockDialog extends PadlockAlertDialog<CaesarPadlock> {
  /// Creates a new [CaesarPadlockDialog] instance.
  const CaesarPadlockDialog({
    Key? key,
    required CaesarPadlock padlock,
  }) : super(
          key: key,
          padlock: padlock,
        );

  @override
  State<StatefulWidget> createState() => _CaesarPadlockDialogState();

  /// The [CaesarPadlockDialog] builder.
  static CaesarPadlockDialog builder(BuildContext context, Padlock padlock) => CaesarPadlockDialog(
        padlock: padlock as CaesarPadlock,
      );
}

/// The [CaesarPadlockDialog] state.
class _CaesarPadlockDialogState extends PadlockAlertDialogState<CaesarPadlockDialog> {
  /// The wheel width.
  static const double width = 220;

  /// The letters.
  static const List<String> letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];

  /// The encrypted text.
  static const encryptedText = 'SVSGUL';

  /// The text editing controller.
  TextEditingController controller = TextEditingController();

  /// How many times the wheel has been turned.
  int turns = 0;

  @override
  List<Widget> buildBody(BuildContext context) => [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                'assets/padlocks/caesar-1.svg',
                width: width,
              ),
              AnimatedRotation(
                turns: turns / 26,
                duration: const Duration(milliseconds: 200),
                child: SvgPicture.asset(
                  'assets/padlocks/caesar-2.svg',
                  width: width * 115 / 148,
                ),
              ),
            ],
          ),
        ),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                setState(() => turns += 1);
              },
              icon: const Icon(Icons.rotate_right),
              label: const Text('Tourner vers la gauche'),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
              ),
            ),
            Text(
              '$encryptedText 👉 $decryptedText',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            ElevatedButton.icon(
              onPressed: () {
                setState(() => turns -= 1);
              },
              icon: const Icon(Icons.rotate_left),
              label: const Text('Tourner vers la droite'),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
              ),
            ),
          ],
        ),
        PadlockInputWidget(
          controller: controller,
          tryUnlock: tryUnlock,
        ),
      ];

  @override
  dynamic getCode() => controller.text;

  /// Returns the decrypted text.
  String get decryptedText {
    String result = '';
    for (String letter in encryptedText.characters) {
      int newIndex = (letters.indexOf(letter) + turns) % 26;
      result += letters[newIndex];
    }
    return result;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
