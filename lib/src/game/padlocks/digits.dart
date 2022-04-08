import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/padlocks/state.dart';
import 'package:flutter/foundation.dart';

/// A padlock that can be unlocked by providing the correct [digits].
class DigitsPadlock extends ObjectEqualPadlock<String> {
  /// The digits to provide.
  final String digits;

  /// Creates a new [CredentialsPadlock] instance.
  DigitsPadlock({
    required this.digits,
    PadlockState? state,
    String? title = kDefaultPadlockTitle,
    String? unlockMessage = kDefaultPadlockUnlockMessage,
    String? failedToUnlockMessage = kDefaultFailedToUnlockMessage,
  }) : super(
          validObject: digits,
          state: state,
          title: title,
          unlockMessage: unlockMessage,
          failedToUnlockMessage: failedToUnlockMessage,
        );

  @override
  @protected
  List<Object?> get props => [...super.props, digits];
}
