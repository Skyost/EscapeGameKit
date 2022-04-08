import 'package:escape_game_kit/src/game/padlocks/credentials.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';

/// Allows to unlock a [CredentialsPadlock].
class CredentialsPadlockDialog extends PadlockAlertDialog<CredentialsPadlock> {
  /// The username text prompt.
  final String? usernameText;

  /// The password text prompt.
  final String? passwordText;

  /// Creates a new [CredentialsPadlockDialog] instance.
  const CredentialsPadlockDialog({
    Key? key,
    required CredentialsPadlock padlock,
    this.usernameText = 'Username',
    this.passwordText = 'Password',
  }) : super(
          padlock: padlock,
          key: key,
        );

  @override
  State<StatefulWidget> createState() => _CredentialPadlockDialogState();

  /// The [CredentialsPadlockDialog] builder.
  static CredentialsPadlockDialog builder(BuildContext context, Padlock padlock) => CredentialsPadlockDialog(
        padlock: padlock as CredentialsPadlock,
      );
}

/// The [CredentialsPadlockDialog] state.
class _CredentialPadlockDialogState extends PadlockAlertDialogState<CredentialsPadlockDialog> {
  /// The username text editing controller.
  TextEditingController usernameController = TextEditingController();

  /// The password text editing controller.
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
