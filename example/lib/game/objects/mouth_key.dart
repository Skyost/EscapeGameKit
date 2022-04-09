import 'package:escape_game_kit/escape_game_kit.dart';

/// The mouth key.
class MouthKey extends EscapeGameObject {
  /// This object id.
  static const String objectId = 'mouth-key';

  /// Creates a new mouth key instance.
  const MouthKey()
      : super(
          id: objectId,
          name: 'Mouth shaped key',
          inventoryRenderSettings: const RenderSettings(
            asset: 'assets/objects/mouth-key.svg',
            height: 40,
          ),
        );
}
