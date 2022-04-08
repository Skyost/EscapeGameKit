import 'package:escape_game_kit/src/game/render/render_settings.dart';
import 'package:escape_game_kit/src/utils/properties_equatable.dart';
import 'package:flutter/foundation.dart';

/// Represents an in-game object.
class EscapeGameObject with PropertiesEquatable {
  /// The object id.
  final String id;

  /// The object name.
  final String name;

  /// Controls how to render this object when displayed in the inventory.
  final RenderSettings? inventoryRenderSettings;

  /// Creates a new [EscapeGameObject] instance.
  const EscapeGameObject({
    required this.id,
    required this.name,
    this.inventoryRenderSettings,
  });

  @override
  @protected
  List<Object?> get props => [id];
}
