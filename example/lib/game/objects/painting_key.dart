import 'package:escape_game_kit/escape_game_kit.dart';

class DeskKey extends EscapeGameObject {
  static const String objectId = 'desk-key';

  const DeskKey()
      : super(
          id: objectId,
          name: 'Clé en forme de bouche',
          inventoryRenderSettings: const RenderSettings(
            asset: 'assets/interactables/desk-key.svg',
            height: 40,
          ),
        );
}
