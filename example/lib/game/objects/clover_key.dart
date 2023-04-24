import 'package:escape_game_kit/escape_game_kit.dart';

/// The eight key.
class EightKey extends EscapeGameObject {
  /// This object id.
  static const String objectId = 'eight-key';

  /// The object asset.
  static const String asset = 'assets/objects/$objectId.svg';

  /// Creates a new eight key instance.
  const EightKey()
      : super(
          id: objectId,
          name: 'Eight shaped key',
          inventoryRenderSettings: const RenderSettings(
            asset: asset,
            height: 40,
          ),
        );
}
