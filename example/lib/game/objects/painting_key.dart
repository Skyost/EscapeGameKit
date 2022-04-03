import 'package:escape_game_kit/escape_game_kit.dart';

class PaintingKey extends EscapeGameObject {
  static const String objectId = 'painting-key';

  const PaintingKey()
      : super(
          id: objectId,
          name: 'Clé en forme de bouche',
          inventoryRenderSettings: const RenderSettings(
            asset: 'assets/interactables/painting-key.svg',
            height: 40,
          ),
        );
}
