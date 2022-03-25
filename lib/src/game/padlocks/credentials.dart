import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/padlocks/state.dart';
import 'package:flutter/material.dart';

class CredentialsPadlock extends ListEqualPadlock<String> {
  final String username;
  final String password;
  final bool caseSensitive;

  CredentialsPadlock({
    required this.username,
    required this.password,
    this.caseSensitive = true,
    PadlockState? state,
    String? title = kDefaultPadlockTitle,
    String? unlockMessage = kDefaultPadlockUnlockMessage,
  }) : super(
          validList: caseSensitive ? [username, password] : [username.toLowerCase(), password.toLowerCase()],
          state: state,
          title: title,
          unlockMessage: unlockMessage,
        );

  @override
  @protected
  bool isObjectValid(List<String> object) => super.isObjectValid(caseSensitive ? object : object.map((element) => element.toLowerCase()).toList());
}
