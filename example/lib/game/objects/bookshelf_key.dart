import 'package:escape_game_kit/escape_game_kit.dart';

class BookshelfKey extends EscapeGameObject {
  static const String objectId = 'bookshelf-key';

  const BookshelfKey()
      : super(
          id: objectId,
          name: 'Clé en forme de huit',
          inventoryRenderSettings: const RenderSettings(
            asset: 'assets/interactables/bookshelf-key.svg',
            height: 40,
          ),
        );
}
