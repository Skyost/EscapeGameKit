import 'package:escape_game_kit/src/game/game.dart';
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

/// Builds a dialog that allows to unlock a [Padlock].
typedef PadlockDialogBuilder = Widget? Function(BuildContext context, EscapeGame escapeGame, Padlock padlock);

/// Allows to unlock padlocks with a dialog.
extension PadlockDialogs on Padlock {
  /// The padlock dialog builders.
  static final Map<Type, PadlockDialogBuilder> _builders = {
    CredentialsPadlock: CredentialsPadlockDialog.builder,
    PatternPadlock: PatternPadlockDialog.builder,
    DigitsPadlock: DigitsPadlockDialog.builder,
  };

  /// Registers a [PadlockDialogBuilder] for the specified [type].
  static void registerBuilderFor(Type type, PadlockDialogBuilder builder) => _builders[type] = builder;

  /// Tries to unlock this padlock using a dialog.
  Future<void> tryUnlockViaDialog(BuildContext context, EscapeGame escapeGame) async {
    if (this is PadlockSequence) {
      Padlock? firstLocked = (this as PadlockSequence).firstLocked;
      while (firstLocked != null) {
        await firstLocked.tryUnlockViaDialog(context, escapeGame);
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
          _buildPadlockDialog(context, escapeGame, this) ??
          EscapeGameAlertDialog.oneChild(
            actions: const [EscapeGameAlertDialogCloseButton(cancel: false)],
            child: Text('Dialog not found for padlock type "${runtimeType.toString()}".'),
          ),
    );
  }

  /// Builds a padlock for the specified [padlock].
  Widget? _buildPadlockDialog(BuildContext context, EscapeGame escapeGame, Padlock padlock) {
    PadlockDialogBuilder? padlockDialogBuilder = _builders[padlock.runtimeType];
    return padlockDialogBuilder == null ? null : padlockDialogBuilder(context, escapeGame, padlock);
  }
}
