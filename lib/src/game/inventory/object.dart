import 'package:escape_game_kit/src/game/render/render_settings.dart';
import 'package:escape_game_kit/src/utils/id_equatable.dart';

class EscapeGameObject with IdEquatable<String> {
  @override
  final String id;
  final String name;
  final RenderSettings? inventoryRenderSettings;

  const EscapeGameObject({
    required this.id,
    required this.name,
    this.inventoryRenderSettings,
  });
}
