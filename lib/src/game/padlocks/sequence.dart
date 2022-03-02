import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:flutter/material.dart';

class PadlockSequence extends Padlock {
  final List<Padlock> padlocks;

  PadlockSequence({
    required this.padlocks,
  });

  @override
  bool tryUnlock(code) {
    for (Padlock padlock in padlocks) {
      if (padlock.state.isLocked) {
        return false;
      }
    }
    state.unlock();
    return true;
  }
}
