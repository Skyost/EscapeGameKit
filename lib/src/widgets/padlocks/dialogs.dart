import 'package:escape_game_kit/src/game/padlocks/credentials.dart';
import 'package:escape_game_kit/src/game/padlocks/digits.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/padlocks/pattern.dart';
import 'package:escape_game_kit/src/game/padlocks/sequence.dart';
import 'package:escape_game_kit/src/widgets/alert_dialog.dart';
import 'package:escape_game_kit/src/widgets/padlocks/credentials.dart';
import 'package:escape_game_kit/src/widgets/padlocks/digits.dart';
import 'package:escape_game_kit/src/widgets/padlocks/pattern.dart';
import 'package:flutter/material.dart';

typedef PadlockDialogBuilder = Widget? Function(BuildContext context, Padlock padlock);

extension PadlockDialogs on Padlock {
  static final Map<Type, PadlockDialogBuilder> _builders = {
    CredentialsPadlock: CredentialsPadlockDialog.builder,
    PatternPadlock: PatternPadlockDialog.builder,
    DigitsPadlock: DigitsPadlockDialog.builder,
  };

  static void registerBuilderFor(Type type, PadlockDialogBuilder builder) => _builders[type] = builder;

  Future<void> tryUnlockViaDialog(BuildContext context) async {
    if (this is PadlockSequence) {
      Padlock? firstLocked = (this as PadlockSequence).firstLocked;
      while (firstLocked != null) {
        await firstLocked.tryUnlockViaDialog(context);
        tryUnlock(null);
        Padlock? newFirstLocked = (this as PadlockSequence).firstLocked;
        if (firstLocked == newFirstLocked || newFirstLocked == null) {
          return;
        }
        firstLocked = newFirstLocked;
      }
    }
    await showDialog(
      context: context,
      builder: (context) =>
          _buildPadlockDialog(context, this) ??
          EscapeGameAlertDialog.oneChild(
            child: Text('Dialog not found for padlock type "${runtimeType.toString()}".'),
            actions: const [EscapeGameAlertDialogCloseButton(cancel: false)],
          ),
    );
  }

  static Widget? _buildPadlockDialog(BuildContext context, Padlock padlock) {
    PadlockDialogBuilder? padlockDialogBuilder = _builders[padlock.runtimeType];
    return padlockDialogBuilder == null ? null : padlockDialogBuilder(context, padlock);
  }
}
