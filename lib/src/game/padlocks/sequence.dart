import 'package:escape_game_kit/src/game/padlocks/padlock.dart';

class PadlockSequence extends Padlock {
  final List<Padlock> padlocks;

  PadlockSequence({
    required this.padlocks,
  });

  Padlock? get firstLocked {
    for (Padlock padlock in padlocks) {
      if (padlock.state.isLocked) {
        return padlock;
      }
    }
    return null;
  }

  @override
  bool tryUnlock(code) {
    if (firstLocked != null) {
      return false;
    }
    state.unlock();
    return true;
  }
}
