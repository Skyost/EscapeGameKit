import 'package:escape_game_kit/escape_game_kit.dart';

/// The eight key.
class EightKey extends EscapeGameObject {
  /// This object id.
  static const String objectId = 'eight-key';

  /// Creates a new eight key instance.
  const EightKey()
      : super(
          id: objectId,
          name: 'Eight shaped key',
          inventoryRenderSettings: const RenderSettings(
            asset: 'assets/objects/eight-key.svg',
            height: 40,
          ),
        );
}
