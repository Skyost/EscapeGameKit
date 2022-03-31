import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

final PaintingPadlock paintingPadlock = PaintingPadlock();

class PaintingPadlock extends ObjectEqualPadlock<String> {
  PaintingPadlock()
      : super(
          title: 'Cadenas',
          unlockMessage: "Mince, il y a un deuxième cadenas avec une sorte de symbôle ! Qu'est-ce que cela peut être ?",
        );

  @override
  bool isObjectValid(String object) => object == '0891';
}

class PaintingPadlockDialog extends StatefulWidget {
  final PaintingPadlock padlock;

  const PaintingPadlockDialog({
    Key? key,
    required this.padlock,
  }) : super(
          key: key,
        );

  @override
  State<StatefulWidget> createState() => _PaintingPadlockDialogState();

  static PaintingPadlockDialog builder(BuildContext context, Padlock padlock) => PaintingPadlockDialog(
        padlock: padlock as PaintingPadlock,
      );
}

class _PaintingPadlockDialogState extends State<PaintingPadlockDialog> {
  TextEditingController controller = TextEditingController();
  bool isFirstTry = true;

  @override
  Widget build(BuildContext context) => EscapeGameAlertDialog(
        title: widget.padlock.title,
        children: [
          if (widget.padlock.unlockMessage != null)
            Text(
              widget.padlock.unlockMessage!,
              textAlign: TextAlign.center,
            ),
          Align(
            alignment: Alignment.center,
            child: QrImage(
              data: 'https://url.skyost.eu/APi8Ab',
              size: 200,
            ),
          ),
          TextField(
            controller: controller,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              labelText: 'Entrer le code ici',
              icon: Icon(Icons.key),
            ),
          )
        ],
        bottom: isFirstTry ? null : const EscapeGameAlertDialogNewTry(text: "Ce n'est pas le bon code..."),
        actions: [
          EscapeGameAlertDialogOkButton(
            onPressed: () {
              bool unlockResult = widget.padlock.tryUnlock(controller.text);
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
    controller.dispose();
    super.dispose();
  }
}
