import 'package:escape_game_kit/src/game/padlocks/credentials.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';

class CredentialsPadlockDialog extends StatefulWidget {
  final CredentialsPadlock padlock;
  final String? usernameText;
  final String? passwordText;

  const CredentialsPadlockDialog({
    Key? key,
    required this.padlock,
    this.usernameText = 'Username :',
    this.passwordText = 'Password :',
  }) : super(
          key: key,
        );

  @override
  State<StatefulWidget> createState() => _CredentialPadlockDialogState();

  static CredentialsPadlockDialog builder(
    BuildContext context,
    Padlock padlock, {
    String? usernameText,
    String? passwordText,
  }) =>
      CredentialsPadlockDialog(
        padlock: padlock as CredentialsPadlock,
        usernameText: usernameText,
        passwordText: passwordText,
      );
}

class _CredentialPadlockDialogState extends State<CredentialsPadlockDialog> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
          TextField(
            controller: usernameController,
            decoration: widget.usernameText == null
                ? null
                : InputDecoration(
                    icon: const Icon(Icons.person),
                    labelText: widget.usernameText,
                  ),
          ),
          TextField(
            controller: passwordController,
            decoration: widget.passwordText == null
                ? null
                : InputDecoration(
                    icon: const Icon(Icons.password),
                    labelText: widget.passwordText,
                  ),
          ),
        ],
        bottom: isFirstTry ? null : const EscapeGameAlertDialogNewTry(),
        actions: [
          EscapeGameAlertDialogOkButton(
            onPressed: () {
              bool unlockResult = widget.padlock.tryUnlock([usernameController.text, passwordController.text]);
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
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
