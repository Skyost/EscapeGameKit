import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class PaintingPadlock extends ObjectEqualPadlock<String> {
  PaintingPadlock()
      : super(
          title: 'Cadenas',
          unlockMessage: "Vous avez déverrouillez ce coffre à l'aide de la clé en forme de bouche... Mais il y a un deuxième cadenas avec une sorte de symbôle ! Qu'est-ce que cela peut être ?",
          failedToUnlockMessage: "Ce code ne fonctionne pas...",
        );

  @override
  bool isObjectValid(String object) => object == '0891';
}

class PaintingPadlockDialog extends PadlockAlertDialog<PaintingPadlock> {
  final String url;

  const PaintingPadlockDialog({
    Key? key,
    required PaintingPadlock padlock,
    required this.url,
  }) : super(
          key: key,
          padlock: padlock,
        );

  @override
  State<StatefulWidget> createState() => _PaintingPadlockDialogState();

  static PaintingPadlockDialog builder(
    BuildContext context,
    Padlock padlock, {
    String url = 'https://url.skyost.eu/APi8Ab',
  }) =>
      PaintingPadlockDialog(
        padlock: padlock as PaintingPadlock,
        url: url,
      );
}

class _PaintingPadlockDialogState extends PadlockAlertDialogState<PaintingPadlockDialog> {
  TextEditingController controller = TextEditingController();

  @override
  List<Widget> buildBody(BuildContext context) => [
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () async {
              if (await launcher.canLaunch(widget.url)) {
                launcher.launch(widget.url);
              }
            },
            child: QrImage(
              data: widget.url,
              size: 200,
            ),
          ),
        ),
        TextField(
          controller: controller,
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
