import 'package:escape_game_kit/src/game/padlocks/state.dart';
import 'package:escape_game_kit/src/utils/properties_equatable.dart';
import 'package:flutter/foundation.dart';

/// The default title of padlocks.
const String kDefaultPadlockTitle = "It's locked !";

/// The text displayed by default in padlock dialogs.
const String kDefaultPadlockUnlockMessage = 'Try to unlock this padlock !';

/// The text displayed by default in padlock dialogs when the user failed to unlock a padlock.
const String kDefaultFailedToUnlockMessage = 'Oops, looks like you have to try again !';

/// Represents an in-game padlock that should be unlocked in order for the user to complete an action.
abstract class Padlock<C> with PropertiesEquatable {
  /// Controls whether this padlock is locked.
  bool _isLocked;

  /// The padlock title.
  final String? title;

  /// The message displayed when the user tries to unlock this padlock.
  final String? unlockMessage;

  /// The message displayed when the user fails to unlock this padlock.
  final String? failedToUnlockMessage;

  /// Creates a new [Padlock] instance.
  Padlock({
    PadlockState? state,
    this.title = kDefaultPadlockTitle,
    this.unlockMessage = kDefaultPadlockUnlockMessage,
    this.failedToUnlockMessage = kDefaultFailedToUnlockMessage,
    bool isLocked = true,
  }) : _isLocked = isLocked;

  /// Tries to unlock the current padlock with the specified [code].
  bool tryUnlock(C code);

  /// Returns whether this padlock is locked.
  bool get isLocked => _isLocked;

  /// Returns whether this padlock is unlocked.
  bool get isUnlocked => !_isLocked;

  /// Locks this padlock.
  @protected
  void lock() => _isLocked = true;

  /// Unlocks this padlock.
  @protected
  void unlock() => _isLocked = false;

  @override
  @protected
  List<Object?> get props => [_isLocked, title, unlockMessage, failedToUnlockMessage];
}

/// A [Padlock] that can be unlocked by providing a specific object.
abstract class ObjectEqualPadlock<T> extends Padlock<T> {
  /// The object that should be given in order to unlock this padlock.
  final T? _validObject;

  /// Creates a new [ObjectEqualPadlock] instance.
  ObjectEqualPadlock({
    T? validObject,
    PadlockState? state,
    String? title = kDefaultPadlockTitle,
    String? unlockMessage = kDefaultPadlockUnlockMessage,
    String? failedToUnlockMessage = kDefaultFailedToUnlockMessage,
  })  : _validObject = validObject,
        super(
          state: state,
          title: title,
          unlockMessage: unlockMessage,
          failedToUnlockMessage: failedToUnlockMessage,
        );

  /// Returns whether the given object is valid.
  @protected
  bool isObjectValid(T object) => object == _validObject;

  @override
  bool tryUnlock(T code) {
    if (isObjectValid(code)) {
      unlock();
      return true;
    }
    return false;
  }

  @override
  @protected
  List<Object?> get props => [...super.props, _validObject];
}

/// A [Padlock] that can be unlocked by providing a specific list.
abstract class ListEqualPadlock<T> extends ObjectEqualPadlock<List<T>> {
  /// Creates a new [ListEqualPadlock] instance.
  ListEqualPadlock({
    required List<T> validList,
    PadlockState? state,
    String? title = kDefaultPadlockTitle,
    String? unlockMessage = kDefaultPadlockUnlockMessage,
    String? failedToUnlockMessage = kDefaultFailedToUnlockMessage,
  }) : super(
          validObject: validList,
          state: state,
          title: title,
          unlockMessage: unlockMessage,
          failedToUnlockMessage: failedToUnlockMessage,
        );

  @override
  @protected
  bool isObjectValid(List<T> object) => listEquals(object, _validObject);
}
