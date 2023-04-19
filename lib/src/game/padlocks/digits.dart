import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:flutter/foundation.dart';

/// A padlock that can be unlocked by providing the correct [digits].
class DigitsPadlock extends ObjectEqualPadlock<String> {
  /// The digits to provide.
  final String digits;

  /// Creates a new [CredentialsPadlock] instance.
  DigitsPadlock({
    required this.digits,
    super.title = kDefaultPadlockTitle,
    super.unlockMessage = kDefaultPadlockUnlockMessage,
    super.failedToUnlockMessage = kDefaultFailedToUnlockMessage,
    super.hintBuilder,
  }) : super(
          validObject: digits,
        );

  @override
  @protected
  List<Object?> get props => [...super.props, digits];
}
