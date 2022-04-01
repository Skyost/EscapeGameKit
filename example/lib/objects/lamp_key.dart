import 'package:escape_game_kit/escape_game_kit.dart';

final EscapeGameObject lampKey = EscapeGameObject(
  id: 'lamp-key',
  name: 'Clé trouvée dans le salon',
  inventoryRenderSettings: const RenderSettings(
    asset: 'assets/interactables/lamp-key.svg',
    height: 40,
  ),
);
