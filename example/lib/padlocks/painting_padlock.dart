import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

final PaintingPadlock paintingPadlock = PaintingPadlock();

class PaintingPadlock extends ObjectEqualPadlock<String> {
  PaintingPadlock()
      : super(
          title: 'Cadenas',
          unlockMessage: "Mince, il y a un deuxième cadenas avec une sorte de symbôle ! Qu'est-ce que cela peut être ?",
          failedToUnlockMessage: "Ce code ne fonctionne pas...",
        );

  @override
  bool isObjectValid(String object) => object == '0891';
}

class PaintingPadlockDialog extends PadlockAlertDialog<PaintingPadlock> {
  const PaintingPadlockDialog({
    Key? key,
    required PaintingPadlock padlock,
  }) : super(
          key: key,
    padlock: padlock,
        );

  @override
  State<StatefulWidget> createState() => _PaintingPadlockDialogState();

  static PaintingPadlockDialog builder(BuildContext context, Padlock padlock) => PaintingPadlockDialog(
        padlock: padlock as PaintingPadlock,
      );
}

class _PaintingPadlockDialogState extends PadlockAlertDialogState<PaintingPadlockDialog> {
  TextEditingController controller = TextEditingController();

  @override
  List<Widget> buildBody(BuildContext context) => [
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
    ),
  ];

  @override
  dynamic getCode() => controller.text;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
