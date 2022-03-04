import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/padlocks/state.dart';

class PatternPadlock extends ListEqualPadlock<PatternCoordinate> {
  final int dimension;

  PatternPadlock({
    required this.dimension,
    required List<PatternCoordinate> validPattern,
    PadlockState? state,
    String? title = kDefaultPadlockTitle,
    String? unlockMessage = kDefaultPadlockUnlockMessage,
  }) : super(
          validList: validPattern,
          state: state,
          title: title,
          unlockMessage: unlockMessage,
        );
}

class PatternCoordinate {
  final int x;
  final int y;

  const PatternCoordinate({
    required this.x,
    required this.y,
  });

  @override
  bool operator ==(Object other) {
    if (other is PatternCoordinate) {
      return x == other.x && y == other.y;
    }
    return super == other;
  }

  @override
  int get hashCode => 17 * x + 17 * y;
}
