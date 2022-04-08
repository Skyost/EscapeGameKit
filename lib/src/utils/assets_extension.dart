import 'package:escape_game_kit/src/game/inventory/object.dart';
import 'package:escape_game_kit/src/game/room/interactables/interactable.dart';
import 'package:escape_game_kit/src/game/room/room.dart';

/// Allows to give a default asset path for an [EscapeGameObject].
extension EscapeGameObjectAssets on EscapeGameObject {
  /// Returns the default asset path.
  String get defaultAssetPath => 'assets/interactables/$id.png';
}

/// Allows to give a default asset path for an [Interactable].
extension InteractableAssets on Interactable {
  /// Returns the default asset path.
  String get defaultAssetPath => 'assets/interactables/$id.png';
}

/// Allows to give a default asset path for a [Room].
extension RoomAssets on Room {
  /// Returns the default asset path.
  String get defaultAssetPath => 'assets/backgrounds/$id.png';
}
