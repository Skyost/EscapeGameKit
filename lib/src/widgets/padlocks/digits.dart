import 'package:escape_game_kit/src/game/padlocks/digits.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';

class DigitsPadlockDialog extends PadlockAlertDialog<DigitsPadlock> {
  final bool shouldSeparateTextFields;

  DigitsPadlockDialog({
    Key? key,
    required DigitsPadlock padlock,
    bool? shouldSeparateTextFields,
  })  : shouldSeparateTextFields = shouldSeparateTextFields ?? (padlock.digits.isNotEmpty && padlock.digits.length <= 4),
        super(
          key: key,
          padlock: padlock,
        );

  @override
  State<StatefulWidget> createState() => _DigitsPadlockDialogState();

  static DigitsPadlockDialog builder(
    BuildContext context,
    Padlock padlock, {
    bool? shouldSeparateTextFields,
  }) =>
      DigitsPadlockDialog(padlock: padlock as DigitsPadlock);
}

class _DigitsPadlockDialogState extends PadlockAlertDialogState<DigitsPadlockDialog> {
  List<TextEditingController> controllers = [];
  List<FocusNode> focusNodes = [];

  @override
  void initState() {
    super.initState();
    Iterable<String> iterable = widget.shouldSeparateTextFields ? widget.padlock.digits.characters : [''];
    for (String _ in iterable) {
      controllers.add(TextEditingController());
      focusNodes.add(FocusNode());
    }
  }

  @override
  List<Widget> buildBody(BuildContext context) => [
        if (controllers.length > 1)
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
          )
        else
          TextField(
            controller: controllers.first,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
            maxLength: 1,
            decoration: const InputDecoration(counterText: ''),
            onSubmitted: (value) => tryUnlock(),
          )
      ];

  @override
  dynamic getCode() => controllers.map((controller) => controller.text).join();

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
