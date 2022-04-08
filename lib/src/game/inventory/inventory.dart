import 'package:escape_game_kit/src/game/inventory/object.dart';
import 'package:escape_game_kit/src/game/render/positioned.dart';
import 'package:escape_game_kit/src/utils/properties_equatable.dart';
import 'package:flutter/foundation.dart';

/// Represents an in-game inventory.
class Inventory with PropertiesEquatable, ChangeNotifier {
  /// Controls how to render the inventory.
  final PositionedRenderSettings? renderSettings;

  /// Contains the objects found by the player.
  final List<EscapeGameObject> _objects = [];

  /// The inventory title.
  final String? title;

  /// The message displayed when there is no item in this inventory.
  final String emptyMessage;

  /// Creates a new [Inventory] instance.
  Inventory({
    this.renderSettings = const PositionedRenderSettings(
      top: 10,
      left: 10,
      isInvisible: false,
    ),
    this.title = 'Inventory',
    this.emptyMessage = "You don't have any item in your inventory.",
  });

  /// Returns the objects contained in this inventory.
  List<EscapeGameObject> get objects => List.of(_objects);

  /// Adds the specified [object] to this inventory.
  void addObject(EscapeGameObject object, {bool notify = true}) {
    _objects.add(object);
    if (notify) {
      notifyListeners();
    }
  }

  /// Removes the specified [object] from this inventory.
  void removeObject(EscapeGameObject object, {bool notify = true}) {
    _objects.remove(object);
    if (notify) {
      notifyListeners();
    }
  }

  /// Returns whether this inventory has the specified [object].
  bool hasObject(EscapeGameObject object) => hasObjectId(object.id);

  /// Returns whether this inventory has an object with the specified [id].
  bool hasObjectId(String id) {
    for (EscapeGameObject object in _objects) {
      if (object.id == id) {
        return true;
      }
    }
    return false;
  }

  @override
  @protected
  List<Object?> get props => [renderSettings, _objects, title, emptyMessage];
}
