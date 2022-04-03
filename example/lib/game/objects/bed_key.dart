import 'package:escape_game_kit/escape_game_kit.dart';

class BedKey extends EscapeGameObject {
  static const String objectId = 'bed-key';

  const BedKey()
      : super(
          id: objectId,
          name: 'Clé en forme de huit',
          inventoryRenderSettings: const RenderSettings(
            asset: 'assets/interactables/bed-key.svg',
            height: 40,
          ),
        );
}
