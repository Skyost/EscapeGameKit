import 'package:escape_game_kit/src/game/padlocks/credentials.dart';
import 'package:escape_game_kit/src/game/padlocks/digits.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/widgets/padlocks/alert_dialog.dart';
import 'package:flutter/material.dart';

class DigitsPadlockDialog extends StatefulWidget {
  final DigitsPadlock padlock;
  final bool shouldSeparateTextFields;

  DigitsPadlockDialog({
    Key? key,
    required this.padlock,
    bool? shouldSeparateTextFields,
  })  : shouldSeparateTextFields = shouldSeparateTextFields ?? (padlock.digits.isNotEmpty && padlock.digits.length <= 4),
        super(
          key: key,
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

class _DigitsPadlockDialogState extends State<DigitsPadlockDialog> {
  List<TextEditingController> controllers = [];
  bool isFirstTry = true;

  @override
  void initState() {
    super.initState();
    Iterable<String> iterable = widget.shouldSeparateTextFields ? widget.padlock.digits.characters : [''];
    for (String _ in iterable) {
      controllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) => EscapeGameAlertDialog(
        title: widget.padlock.title,
        children: [
          if (widget.padlock.unlockMessage != null)
            Text(
              widget.padlock.unlockMessage!,
              textAlign: TextAlign.center,
            ),
          if (controllers.length > 1)
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              children: [
                for (TextEditingController controller in controllers)
                  SizedBox(
                    width: 20,
                    child: TextField(
                      controller: controller,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
              ],
            )
          else
            TextField(
              controller: controllers.first,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            )
        ],
        bottom: isFirstTry ? null : const EscapeGameAlertDialogNewTry(),
        actions: [
          EscapeGameAlertDialogOkButton(
            onPressed: () {
              bool unlockResult = widget.padlock.tryUnlock(controllers.map((controller) => controller.text).join());
              if (unlockResult) {
                Navigator.pop(context);
              } else {
                setState(() => isFirstTry = false);
              }
            },
          ),
          const EscapeGameAlertDialogCloseButton(),
        ],
      );

  @override
  void dispose() {
    for (TextEditingController controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
