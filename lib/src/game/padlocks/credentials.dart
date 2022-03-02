import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/padlocks/state.dart';

class CredentialsPadlock extends ListEqualPadlock<String> {
  final String username;
  final String password;

  CredentialsPadlock({
    required this.username,
    required this.password,
    PadlockState? state,
    String? title = kDefaultPadlockTitle,
    String? unlockMessage = kDefaultPadlockUnlockMessage,
  }) : super(
          validList: [username, password],
          state: state,
          title: title,
          unlockMessage: unlockMessage,
        );
}
