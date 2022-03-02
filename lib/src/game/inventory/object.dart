import 'package:escape_game_kit/src/game/render/render_settings.dart';

class EscapeGameObject {
  final String id;
  final String name;
  final RenderSettings? inventoryRenderSettings;

  const EscapeGameObject({
    required this.id,
    required this.name,
    this.inventoryRenderSettings,
  });
}
