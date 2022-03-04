import 'package:escape_game_kit/src/game/padlocks/credentials.dart';
import 'package:escape_game_kit/src/game/padlocks/digits.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/padlocks/pattern.dart';
import 'package:escape_game_kit/src/widgets/alert_dialog.dart';
import 'package:escape_game_kit/src/widgets/padlocks/credentials.dart';
import 'package:escape_game_kit/src/widgets/padlocks/digits.dart';
import 'package:escape_game_kit/src/widgets/padlocks/pattern.dart';
import 'package:flutter/material.dart';

typedef PadlockDialogBuilder = Widget Function(BuildContext context, Padlock padlock);

extension PadlockDialogs on Padlock {
  static final Map<Type, PadlockDialogBuilder> _builders = {
    CredentialsPadlock: CredentialsPadlockDialog.builder,
    PatternPadlock: PatternPadlockDialog.builder,
    DigitsPadlock: DigitsPadlockDialog.builder,
  };

  static void registerBuilderFor(Type type, PadlockDialogBuilder builder) => _builders[type] = builder;

  Future tryUnlockViaDialog(BuildContext context) => showDialog(
        context: context,
        builder: _builders.containsKey(runtimeType)
            ? (context) => _builders[runtimeType]!(context, this)
            : (context) => EscapeGameAlertDialog.oneChild(
                  child: Text('Dialog not found for padlock type "${runtimeType.toString()}".'),
                  actions: const [EscapeGameAlertDialogCloseButton(cancel: false)],
                ),
      );
}
