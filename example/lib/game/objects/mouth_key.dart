import 'package:escape_game_kit/escape_game_kit.dart';

/// The mouth key.
class MouthKey extends EscapeGameObject {
  /// This object id.
  static const String objectId = 'mouth-key';

  /// The object asset.
  static const String asset = 'assets/objects/$objectId.svg';

  /// Creates a new mouth key instance.
  const MouthKey()
      : super(
          id: objectId,
          name: 'Mouth shaped key',
          inventoryRenderSettings: const RenderSettings(
            asset: asset,
            height: 40,
          ),
        );
}
