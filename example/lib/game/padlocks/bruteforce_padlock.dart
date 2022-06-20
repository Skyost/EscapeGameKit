import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:flutter/material.dart';

/// A padlock that can be unlocked by trying a lot of codes.
class BruteforcePadlock extends ObjectEqualPadlock<String> {
  /// The code.
  final String digits;

  /// Creates a new [BruteforcePadlock] instance.
  BruteforcePadlock({
    this.digits = '2018',
  }) : super(
          title: 'Padlock',
          unlockMessage: "This draw is protected by a strange padlock which is showing various info... Let's try some codes !",
        );

  @override
  bool isObjectValid(String object) => object.toLowerCase() == digits;
}

/// Allows to unlock a [BruteforcePadlock].
class BruteforcePadlockDialog extends PadlockAlertDialog<BruteforcePadlock> {
  /// Creates a new [BruteforcePadlockDialog] instance.
  const BruteforcePadlockDialog({
    Key? key,
    required BruteforcePadlock padlock,
  }) : super(
          key: key,
          padlock: padlock,
        );

  @override
  State<StatefulWidget> createState() => _BruteforcePadlockDialogState();

  /// The [BruteforcePadlockDialog] builder.
  static BruteforcePadlockDialog builder(BuildContext context, Padlock padlock) => BruteforcePadlockDialog(
        padlock: padlock as BruteforcePadlock,
      );
}

/// The [BruteforcePadlockDialog] state.
class _BruteforcePadlockDialogState extends PadlockAlertDialogState<BruteforcePadlockDialog> {
  /// Text editing controllers.
  List<TextEditingController> controllers = [];

  /// Focus nodes.
  List<FocusNode> focusNodes = [];

  @override
  void initState() {
    super.initState();
    Iterable<String> iterable = widget.padlock.digits.characters;
    for (int i = 0; i < iterable.length; i++) {
      TextEditingController controller = TextEditingController();
      FocusNode focusNode = FocusNode();
      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          controller.selection = TextSelection(baseOffset: 0, extentOffset: controller.text.length);
        }
      });
      controllers.add(controller);
      focusNodes.add(focusNode);
    }
  }

  @override
  List<Widget> buildBody(BuildContext context) => [
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            '🔐',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40),
          ),
        ),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          children: [
            for (int i = 0; i < controllers.length; i++)
              SizedBox(
                width: 20,
                child: TextField(
                  controller: controllers[i],
                  focusNode: focusNodes[i],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                  maxLength: 1,
                  decoration: const InputDecoration(counterText: ''),
                  autofocus: i == 0,
                  onChanged: (value) {
                    if (value.isNotEmpty && i < controllers.length - 1) {
                      focusNodes[i].nextFocus();
                    }
                  },
                  onSubmitted: (value) => tryUnlock(),
                ),
              ),
          ],
        ),
      ];

  @override
  dynamic getCode() => controllers.map((controller) => controller.text).join();

  @override
  Widget? buildBottom(BuildContext context) {
    if (isFirstTry) {
      return null;
    }

    int goodDigits = 0;
    int wellPlacedDigits = 0;

    List<String> digits = widget.padlock.digits.characters.toList();
    for (int i = 0; i < digits.length; i++) {
      TextEditingController controller = controllers[i];
      if (digits.contains(controller.text)) {
        goodDigits++;
        if (digits[i] == controller.text) {
          wellPlacedDigits++;
        }
      }
    }

    return Text(
      'Incorrect code : $goodDigits correct(s) digit(s) and $wellPlacedDigits well placed digit(s).',
      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
      textAlign: TextAlign.center,
    );
  }

  @override
  void dispose() {
    for (TextEditingController controller in controllers) {
      controller.dispose();
    }
    for (FocusNode focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }
}
