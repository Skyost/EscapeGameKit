import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:flutter/foundation.dart';

/// A very special padlock that is unlocked only when its children are unlocked.
class PadlockSequence extends Padlock {
  /// The children padlocks.
  final List<Padlock> padlocks;

  /// Creates a new [PadlockSequence] instance.
  PadlockSequence({
    required this.padlocks,
  });

  /// Returns the first child padlock that is still locked.
  Padlock? get firstLocked {
    for (Padlock padlock in padlocks) {
      if (padlock.isLocked) {
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
    unlock();
    return true;
  }

  @override
  @protected
  List<Object?> get props => [...super.props, padlocks];
}
