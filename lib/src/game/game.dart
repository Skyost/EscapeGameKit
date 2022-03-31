import 'dart:collection';

import 'package:escape_game_kit/src/game/dialog.dart';
import 'package:escape_game_kit/src/game/inventory/inventory.dart';
import 'package:escape_game_kit/src/game/room/room.dart';
import 'package:escape_game_kit/src/utils/countdown.dart';
import 'package:flutter/material.dart';

class EscapeGame with CountdownListener, ChangeNotifier {
  final Inventory inventory;
  Set<Room> rooms;
  Set<String> visitedRooms;
  String _currentRoom;
  Countdown? countdown;
  bool _isStarted = false;
  bool _isFinished = false;
  EscapeGameDialog? _dialog;

  EscapeGame({
    Inventory? inventory,
    Iterable<Room>? rooms,
    required String firstRoomId,
    this.countdown,
  })  : rooms = HashSet.from(rooms ?? <Room>{}),
        inventory = inventory ?? Inventory(),
        _currentRoom = firstRoomId,
        visitedRooms = {} {
    goToRoom(firstRoomId);
    this.inventory.addListener(notifyListeners);
  }

  Room get currentRoom => rooms.firstWhere((room) => room.id == _currentRoom);

  void goToRoom(String roomId, {bool notify = true}) {
    currentRoom.removeListener(notifyListeners);
    _currentRoom = roomId;
    Room current = currentRoom;
    current.addListener(notifyListeners);
    if (notify) {
      notifyListeners();
    }
    if (current.firstVisitDialog != null && !visitedRooms.contains(roomId)) {
      openDialog(current.firstVisitDialog!, notify: notify);
    }
    visitedRooms.add(roomId);
  }

  EscapeGameDialog? get openedDialog => _dialog;

  bool get isDialogOpened => _dialog != null;

  void openDialog(EscapeGameDialog dialog, {bool notify = true}) {
    _dialog = dialog;
    if (notify) {
      notifyListeners();
    }
  }

  void closeDialog({bool notify = true}) {
    _dialog = null;
    if (notify) {
      notifyListeners();
    }
  }

  bool get isStarted => _isStarted;

  void start({bool notify = true}) {
    countdown?.start();
    _isStarted = true;
    if (notify) {
      notifyListeners();
    }
  }

  bool get isFinished => _isFinished;

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
}
