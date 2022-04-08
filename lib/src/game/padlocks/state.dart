import 'package:escape_game_kit/src/utils/properties_equatable.dart';
import 'package:flutter/foundation.dart';

/// Allows to control a padlock state.
class PadlockState with PropertiesEquatable {
  /// Controls whether this padlock is locked.
  bool isLocked;

  /// Creates a new [PadlockState] instance.
  PadlockState({
    this.isLocked = true,
  });

  /// Returns whether this padlock is unlocked.
  bool get isUnlocked => !isLocked;

  /// Locks this padlock.
  void lock() => isLocked = true;

  /// Unlocks this padlock.
  void unlock() => isLocked = false;

  @override
  @protected
  List<Object?> get props => [isLocked];
}
