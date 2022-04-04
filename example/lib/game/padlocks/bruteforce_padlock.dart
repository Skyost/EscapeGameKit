import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:flutter/material.dart';

class BruteforcePadlock extends ObjectEqualPadlock<String> {
  final String digits;

  BruteforcePadlock({
    this.digits = '2018',
  }) : super(
          title: 'Cadenas',
          unlockMessage: "Ce tiroir est protégé par un drôle de cadenas qui affiche des informations additionnelles... Essayons différents codes !",
        );

  @override
  bool isObjectValid(String object) => object.toLowerCase() == digits;
}

class BruteforcePadlockDialog extends PadlockAlertDialog<BruteforcePadlock> {
  const BruteforcePadlockDialog({
    Key? key,
    required BruteforcePadlock padlock,
  }) : super(
          key: key,
          padlock: padlock,
        );

  @override
  State<StatefulWidget> createState() => _BruteforcePadlockDialogState();

  static BruteforcePadlockDialog builder(BuildContext context, Padlock padlock) => BruteforcePadlockDialog(padlock: padlock as BruteforcePadlock);
}

class _BruteforcePadlockDialogState extends PadlockAlertDialogState<BruteforcePadlockDialog> {
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];

  @override
  void initState() {
    super.initState();
    Iterable<String> iterable = widget.padlock.digits.characters;
    for (String _ in iterable) {
      controllers.add(TextEditingController());
      focusNodes.add(FocusNode());
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
                  onChanged: (value) {
                    if (value.isNotEmpty && i < controllers.length - 1) {
                      focusNodes[i + 1].requestFocus();
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
      'Le code est incorrect : $goodDigits chiffre(s) correct(s) et $wellPlacedDigits chiffre(s) bien placé(s).',
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
