import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/widgets/padlock_input.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

/// A padlock that displays a QR code.
class QrPadlock extends ObjectEqualPadlock<String> {
  /// The QR code URL.
  final String url;

  /// Creates a new [QrPadlock] instance.
  QrPadlock({
    this.url = 'https://url.skyost.eu/pKXAyO',
  }) : super(
          title: 'Padlock',
          unlockMessage: "There's a padlock with a strange symbol ! What does it mean ?",
          failedToUnlockMessage: "This code doesn't work...",
        );

  @override
  bool isObjectValid(String object) => object == '0891';
}

/// Allows to unlock a [QrPadlock].
class QrPadlockDialog extends PadlockAlertDialog<QrPadlock> {
  /// Creates a new [QrPadlockDialog] instance.
  const QrPadlockDialog({
    super.key,
    required super.padlock,
  });

  @override
  State<StatefulWidget> createState() => _QrPadlockDialogState();

  /// The [QrPadlockDialog] builder.
  static QrPadlockDialog builder(BuildContext context, EscapeGame escapeGame, Padlock padlock) => QrPadlockDialog(
        padlock: padlock as QrPadlock,
      );
}

/// The [QrPadlockDialog] state.
class _QrPadlockDialogState extends PadlockAlertDialogState<QrPadlockDialog> {
  /// The code text editing controller.
  TextEditingController controller = TextEditingController();

  @override
  List<Widget> buildBody(BuildContext context) => [
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () async {
              Uri url = Uri.parse(widget.padlock.url);
              if (await launcher.canLaunchUrl(url)) {
                launcher.launchUrl(url);
              }
            },
            child: QrImage(
              data: widget.padlock.url,
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
