import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/widgets/padlock_input.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class QrPadlock extends ObjectEqualPadlock<String> {
  QrPadlock()
      : super(
          title: 'Cadenas',
          unlockMessage: "Il y a un cadenas avec une sorte de symbôle ! Qu'est-ce que cela peut être ?",
          failedToUnlockMessage: "Ce code ne fonctionne pas...",
        );

  @override
  bool isObjectValid(String object) => object == '0891';
}

class QrPadlockDialog extends PadlockAlertDialog<QrPadlock> {
  final String url;

  const QrPadlockDialog({
    Key? key,
    required QrPadlock padlock,
    required this.url,
  }) : super(
          key: key,
          padlock: padlock,
        );

  @override
  State<StatefulWidget> createState() => _QrPadlockDialogState();

  static QrPadlockDialog builder(
    BuildContext context,
    Padlock padlock, {
    String url = 'https://url.skyost.eu/APi8Ab',
  }) =>
      QrPadlockDialog(
        padlock: padlock as QrPadlock,
        url: url,
      );
}

class _QrPadlockDialogState extends PadlockAlertDialogState<QrPadlockDialog> {
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
        PadlockInputWidget(
          controller: controller,
          tryUnlock: tryUnlock,
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
