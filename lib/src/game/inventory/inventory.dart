import 'package:escape_game_kit/src/game/inventory/object.dart';
import 'package:escape_game_kit/src/game/render/positioned.dart';
import 'package:flutter/material.dart';

class Inventory with ChangeNotifier {
  final PositionedRenderSettings? renderSettings;
  final List<EscapeGameObject> _objects = [];
  final String? title;
  final String emptyMessage;

  Inventory({
    this.renderSettings = const PositionedRenderSettings(
      top: 10,
      left: 10,
      isInvisible: false,
    ),
    this.title = 'Inventory',
    this.emptyMessage = "You dont have any item in your inventory.",
  });

  List<EscapeGameObject> get objects => List.of(_objects);

  void addObject(EscapeGameObject object, {bool notify = true}) {
    _objects.add(object);
    if (notify) {
      notifyListeners();
    }
  }

  void removeObject(EscapeGameObject object, {bool notify = true}) {
    _objects.remove(object);
    if (notify) {
      notifyListeners();
    }
  }
}
