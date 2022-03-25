import 'package:escape_game_kit/src/game/render/render_settings.dart';

class EscapeGameObject {
  final String id;
  final String name;
  final RenderSettings? inventoryRenderSettings;

  EscapeGameObject({
    required this.id,
    required this.name,
    RenderSettings? inventoryRenderSettings,
  }) : inventoryRenderSettings = inventoryRenderSettings ??
            RenderSettings(
              asset: 'assets/interactables/$id.png',
              height: 32,
            );
}
