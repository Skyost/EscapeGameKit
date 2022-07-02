import 'dart:collection';

import 'package:escape_game_kit/src/game/dialog.dart';
import 'package:escape_game_kit/src/game/inventory/inventory.dart';
import 'package:escape_game_kit/src/game/room/interactables/action_result.dart';
import 'package:escape_game_kit/src/game/room/room.dart';
import 'package:escape_game_kit/src/utils/countdown.dart';
import 'package:escape_game_kit/src/utils/properties_equatable.dart';
import 'package:flutter/foundation.dart';

/// Represents an [EscapeGame], with some [rooms] and an [inventory].
class EscapeGame with CountdownListener, PropertiesEquatable, ChangeNotifier {
  /// The in-game inventory.
  final Inventory inventory;

  /// The game rooms.
  Set<Room> rooms;

  /// The current room id.
  String _currentRoom;

  /// The game [Countdown].
  Countdown? countdown;

  /// Whether this game is started.
  bool _isStarted = false;

  /// Whether this game is finished.
  bool _isFinished = false;

  /// The currently displayed dialog.
  EscapeGameDialog? _dialog;

  /// Creates a new [EscapeGame] instance.
  EscapeGame({
    Inventory? inventory,
    Iterable<Room>? rooms,
    String? firstRoomId,
    this.countdown,
  })  : assert(rooms != null && rooms.isNotEmpty),
        rooms = HashSet.from(rooms!),
        inventory = inventory ?? Inventory(),
        _currentRoom = firstRoomId ?? rooms.first.id {
    this.inventory.addListener(notifyListeners);
  }

  /// Returns the current room.
  Room get currentRoom => rooms.firstWhere((room) => room.id == _currentRoom);

  /// Returns a room object by its [Room.id].
  Room? getRoomById (String roomId) {
    for (Room room in rooms) {
      if (room.id == roomId) {
        return room;
      }
    }
    return null;
  }

  /// Changes the current room.
  ActionResult goToRoom(String roomId, {bool notify = true}) {
    currentRoom.removeListener(notifyListeners);
    String oldRoom = _currentRoom;
    _currentRoom = roomId;
    Room current = currentRoom;
    current.addListener(notifyListeners);
    if (notify) {
      notifyListeners();
    }
    if (!current.hasBeenVisited) {
      if (current.onFirstVisit != null) {
        ActionResult result = current.onFirstVisit!(this);
        if (result.state != ActionResultState.success) {
          goToRoom(oldRoom, notify: notify);
          return result;
        }
      }
      current.hasBeenVisited = true;
    }
    return ActionResult.success(object: current);
  }

  /// Returns the opened dialog.
  EscapeGameDialog? get openedDialog => _dialog;

  /// Returns whether a dialog is currently opened.
  bool get isDialogOpened => _dialog != null;

  /// Opens the specified dialog.
  void openDialog(EscapeGameDialog dialog, {bool notify = true}) {
    _dialog = dialog;
    if (notify) {
      notifyListeners();
    }
  }

  /// Closes the currently opened dialog.
  void closeDialog({bool notify = true}) {
    _dialog = null;
    if (notify) {
      notifyListeners();
    }
  }

  /// Returns whether this game is started.
  bool get isStarted => _isStarted;

  /// Starts this game.
  ActionResult start({bool notify = true}) {
    countdown?.start();
    _isStarted = true;
    ActionResult result = goToRoom(_currentRoom);
    if (notify) {
      notifyListeners();
    }
    return result;
  }

  /// Returns whether this game is finished.
  bool get isFinished => _isFinished;

  /// Finishes this game.
  void finish({bool notify = true}) {
    countdown?.pause();
    _isFinished = true;
    if (notify) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    inventory.removeListener(notifyListeners);
    currentRoom.dispose();
    super.dispose();
  }

  @override
  @protected
  List<Object?> get props => [inventory, rooms, _currentRoom, countdown, _isStarted, _isFinished, _dialog];
}
