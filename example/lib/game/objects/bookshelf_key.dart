import 'package:escape_game_kit/escape_game_kit.dart';

/// The clover key.
class CloverKey extends EscapeGameObject {
  /// This object id.
  static const String objectId = 'clover-key';

  /// The object asset.
  static const String asset = 'assets/objects/$objectId.svg';

  /// Creates a new clover key instance.
  const CloverKey()
      : super(
          id: objectId,
          name: 'Clover shaped key',
          inventoryRenderSettings: const RenderSettings(
            asset: asset,
            height: 40,
          ),
        );
}
