import 'package:escape_game_kit/src/game/inventory/object.dart';
import 'package:escape_game_kit/src/game/room/interactables/interactable.dart';
import 'package:escape_game_kit/src/game/room/room.dart';

extension EscapeGameObjectAssets on EscapeGameObject {
  String get defaultAssetPath => 'assets/interactables/$id.png';
}

extension InteractableAssets on Interactable {
  String get defaultAssetPath => 'assets/interactables/$id.png';
}

extension RoomAssets on Room {
  String get defaultAssetPath => 'assets/backgrounds/$id.png';
}
