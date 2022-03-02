import 'package:escape_game_kit/src/game/padlocks/state.dart';
import 'package:flutter/foundation.dart';

const String kDefaultPadlockTitle = "It's locked !";
const String kDefaultPadlockUnlockMessage = "Try to unlock this padlock !";

abstract class Padlock<C> {
  final PadlockState state;
  String? title;
  String? unlockMessage;

  Padlock({
    PadlockState? state,
    this.title = kDefaultPadlockTitle,
    this.unlockMessage = kDefaultPadlockUnlockMessage,
  }) : state = state ?? PadlockState();

  bool tryUnlock(C code);
}

abstract class ObjectEqualPadlock<T> extends Padlock<T> {
  final T? _validObject;

  ObjectEqualPadlock({
    T? validObject,
    PadlockState? state,
    String? title = kDefaultPadlockTitle,
    String? unlockMessage = kDefaultPadlockUnlockMessage,
  })  : _validObject = validObject,
        super(
          state: state,
          title: title,
          unlockMessage: unlockMessage,
        );

  @protected
  bool isObjectValid(T object) => object == _validObject;

  @override
  bool tryUnlock(T code) {
    if (isObjectValid(code)) {
      state.unlock();
      return true;
    }
    return false;
  }
}

abstract class ListEqualPadlock<T> extends ObjectEqualPadlock<List<T>> {
  ListEqualPadlock({
    required List<T> validList,
    PadlockState? state,
    String? title = kDefaultPadlockTitle,
    String? unlockMessage = kDefaultPadlockUnlockMessage,
  }) : super(
          validObject: validList,
          state: state,
          title: title,
          unlockMessage: unlockMessage,
        );

  @override
  @protected
  bool isObjectValid(List<T> object) => listEquals(object, _validObject);
}
