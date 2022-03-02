import 'package:escape_game_kit/src/game/render/positioned.dart';
import 'package:escape_game_kit/src/game/room/interactables/action_result.dart';
import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/room/interactables/interactable.dart';
import 'package:escape_game_kit/src/game/inventory/object.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/render/render_settings.dart';

class PickableObject extends LockedInteractable {
  final EscapeGameObject object;

  PickableObject({
    required this.object,
    Padlock? padlock,
    String? id,
    PositionedRenderSettings? renderSettings,
    Action? onTap,
    Action<String>? onTooltip,
  }) : super(
          padlock: padlock,
          id: id ?? object.id,
          renderSettings: renderSettings,
          onTap: onTap,
          onTooltip: onTooltip,
        );

  @override
  ActionResult onTap(EscapeGame escapeGame) {
    ActionResult padlockTry = super.onTap(escapeGame);
    if (padlockTry.state == ActionResultState.success) {
      escapeGame.inventory.addObject(object);
      return ActionResult<EscapeGameObject>.success(object: object);
    }
    return padlockTry;
  }
}
