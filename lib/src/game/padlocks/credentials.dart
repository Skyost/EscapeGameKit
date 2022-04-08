import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/padlocks/state.dart';
import 'package:flutter/foundation.dart';

/// A padlock that can be unlocked by providing the correct [username] and the correct [password].
class CredentialsPadlock extends ListEqualPadlock<String> {
  /// The username to provide.
  final String username;

  /// The password to provide.
  final String password;

  /// Whether the username and the password are case sensitive.
  final bool caseSensitive;

  /// Creates a new [CredentialsPadlock] instance.
  CredentialsPadlock({
    required this.username,
    required this.password,
    this.caseSensitive = true,
    PadlockState? state,
    String? title = kDefaultPadlockTitle,
    String? unlockMessage = kDefaultPadlockUnlockMessage,
    String? failedToUnlockMessage = kDefaultFailedToUnlockMessage,
  }) : super(
          validList: caseSensitive ? [username, password] : [username.toLowerCase(), password.toLowerCase()],
          state: state,
          title: title,
          unlockMessage: unlockMessage,
          failedToUnlockMessage: failedToUnlockMessage,
        );

  @override
  @protected
  bool isObjectValid(List<String> object) => super.isObjectValid(caseSensitive ? object : object.map((element) => element.toLowerCase()).toList());

  @override
  @protected
  List<Object?> get props => [...super.props, username, password, caseSensitive];
}
