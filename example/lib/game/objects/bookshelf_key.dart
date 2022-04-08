import 'package:escape_game_kit/escape_game_kit.dart';

/// The clover key.
class CloverKey extends EscapeGameObject {
  /// This object id.
  static const String objectId = 'clover-key';

  /// Creates a new clover key instance.
  const CloverKey()
      : super(
          id: objectId,
          name: 'Clover shaped key',
          inventoryRenderSettings: const RenderSettings(
            asset: 'assets/interactables/clover-key.svg',
            height: 40,
          ),
        );
}
