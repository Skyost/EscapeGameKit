import 'package:escape_game_kit/src/game/padlocks/credentials.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';

class CredentialsPadlockDialog extends PadlockAlertDialog<CredentialsPadlock> {
  final String? usernameText;
  final String? passwordText;

  const CredentialsPadlockDialog({
    Key? key,
    required CredentialsPadlock padlock,
    this.usernameText,
    this.passwordText,
  }) : super(
          padlock: padlock,
          key: key,
        );

  @override
  State<StatefulWidget> createState() => _CredentialPadlockDialogState();

  static CredentialsPadlockDialog builder(
    BuildContext context,
    Padlock padlock, {
    String? usernameText = 'Username',
    String? passwordText = 'Password',
  }) =>
      CredentialsPadlockDialog(
        padlock: padlock as CredentialsPadlock,
        usernameText: usernameText,
        passwordText: passwordText,
      );
}

class _CredentialPadlockDialogState extends PadlockAlertDialogState<CredentialsPadlockDialog> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  List<Widget> buildBody(BuildContext context) => [
        TextField(
          controller: usernameController,
          decoration: widget.usernameText == null
              ? const InputDecoration()
              : InputDecoration(
                  icon: const Icon(Icons.person),
                  labelText: widget.usernameText,
                ),
          onSubmitted: (value) => tryUnlock(),
        ),
        TextField(
          controller: passwordController,
          decoration: widget.passwordText == null
              ? const InputDecoration()
              : InputDecoration(
                  icon: const Icon(Icons.password),
                  labelText: widget.passwordText,
                ),
          obscureText: true,
          onSubmitted: (value) => tryUnlock(),
        ),
      ];

  @override
  dynamic getCode() => [usernameController.text, passwordController.text];

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
