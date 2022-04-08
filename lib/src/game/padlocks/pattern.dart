import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/padlocks/state.dart';
import 'package:escape_game_kit/src/utils/properties_equatable.dart';
import 'package:flutter/foundation.dart';

/// A padlock that can be unlocked by providing the correct pattern.
class PatternPadlock extends ListEqualPadlock<PatternCoordinate> {
  /// The padlock grid dimension.
  final int dimension;

  /// Creates a new [PatternPadlock] instance.
  PatternPadlock({
    required this.dimension,
    required List<PatternCoordinate> validPattern,
    PadlockState? state,
    String? title = kDefaultPadlockTitle,
    String? unlockMessage = kDefaultPadlockUnlockMessage,
    String? failedToUnlockMessage = kDefaultFailedToUnlockMessage,
  }) : super(
          validList: validPattern,
          state: state,
          title: title,
          unlockMessage: unlockMessage,
          failedToUnlockMessage: failedToUnlockMessage,
        );

  @override
  @protected
  List<Object?> get props => [...super.props, dimension];
}

/// Represents a `(x, y)` coordinate.
class PatternCoordinate with PropertiesEquatable {
  /// The x coordinate.
  final int x;

  /// The y coordinate.
  final int y;

  /// Creates a new [PatternCoordinate] instance.
  const PatternCoordinate({
    required this.x,
    required this.y,
  });

  @override
  @protected
  List<Object?> get props => [x, y];
}
