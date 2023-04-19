import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/padlocks/digits.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';

/// Allows to unlock a [DigitsPadlock].
class DigitsPadlockDialog extends PadlockAlertDialog<DigitsPadlock> {
  /// Whether text fields should be separated.
  final bool shouldSeparateTextFields;

  /// Creates a new [DigitsPadlockDialog] instance.
  DigitsPadlockDialog({
    super.key,
    required super.escapeGame,
    required super.padlock,
    bool? shouldSeparateTextFields,
  }) : shouldSeparateTextFields = shouldSeparateTextFields ?? (padlock.digits.isNotEmpty && padlock.digits.length <= 4);

  @override
  State<StatefulWidget> createState() => _DigitsPadlockDialogState();

  /// The [DigitsPadlockDialog] builder.
  static DigitsPadlockDialog builder(BuildContext context, EscapeGame escapeGame, Padlock padlock) => DigitsPadlockDialog(
        escapeGame: escapeGame,
        padlock: padlock as DigitsPadlock,
      );
}

/// The [DigitsPadlockDialog] state.
class _DigitsPadlockDialogState extends PadlockAlertDialogState<DigitsPadlockDialog> {
  /// Text editing controllers.
  List<TextEditingController> controllers = [];

  /// Focus nodes.
  List<FocusNode> focusNodes = [];

  @override
  void initState() {
    super.initState();
    Iterable<String> iterable = widget.shouldSeparateTextFields ? widget.padlock.digits.characters : [''];
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
          )
        else
          TextField(
            controller: controllers.first,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
            maxLength: 1,
            decoration: const InputDecoration(counterText: ''),
            onSubmitted: (value) => tryUnlock(),
            autofocus: true,
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
