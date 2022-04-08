import 'dart:collection';

import 'package:escape_game_kit/src/game/dialog.dart';
import 'package:escape_game_kit/src/game/render/render_settings.dart';
import 'package:escape_game_kit/src/game/room/interactables/interactable.dart';
import 'package:escape_game_kit/src/utils/properties_equatable.dart';
import 'package:flutter/foundation.dart';

/// Represents a room.
class Room with PropertiesEquatable, ChangeNotifier {
  /// The room id.
  final String id;

  /// Controls how to render this room.
  final RenderSettings? renderSettings;

  /// The room interactables.
  final HashSet<Interactable> _interactables;

  /// Triggered when this room is visited for the first time.
  final Action<EscapeGameDialog>? onFirstVisit;

  /// Returns whether this room has been visited.
  bool hasBeenVisited = false;

  /// Creates a new [Room] instance.
  Room({
    required this.id,
    this.renderSettings,
    Iterable<Interactable>? interactables,
    this.onFirstVisit,
  }) : _interactables = HashSet.from(interactables ?? <Interactable>{});

  /// Returns the room interactables.
  HashSet<Interactable> get interactables => HashSet.of(_interactables);

  /// Returns an interactable object by its [Interactable.id].
  Interactable? getInteractableById(String id) {
    for (Interactable interactable in _interactables) {
      if (interactable.id == id) {
        return interactable;
      }
    }
    return null;
  }

  /// Adds an [Interactable] to the [interactables] list.
  void addInteractable(Interactable interactable, {bool notify = true}) {
    if (_interactables.add(interactable)) {
      interactable.addListener(notifyListeners);
      if (notify) {
        notifyListeners();
      }
    }
  }

  /// Removes an [Interactable] from the [interactables] list.
  void removeInteractable(Interactable interactable, {bool notify = true}) {
    if (_interactables.remove(interactable)) {
      interactable.removeListener(notifyListeners);
      if (notify) {
        notifyListeners();
      }
    }
  }

  /// Removes an interactable object by its [Interactable.id].
  void removeInteractableFromId(String id, {bool notify = true}) {
    Interactable? interactable = getInteractableById(id);
    if (interactable != null) {
      removeInteractable(interactable, notify: notify);
    }
  }

  @override
  void dispose() {
    for (Interactable interactable in _interactables) {
      interactable.dispose();
    }
    super.dispose();
  }

  @override
  @protected
  List<Object?> get props => [id, renderSettings, _interactables, onFirstVisit, hasBeenVisited];
}
