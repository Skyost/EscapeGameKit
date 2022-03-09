import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/inventory/object.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/render/positioned.dart';
import 'package:escape_game_kit/src/game/room/interactables/action_result.dart';
import 'package:escape_game_kit/src/game/room/interactables/interactable.dart';

class PickableObject extends LockedInteractable {
  final EscapeGameObject object;
  final Action? onPickedUp;
  final bool removeAfterPickedUp;

  PickableObject({
    required this.object,
    this.onPickedUp,
    this.removeAfterPickedUp = true,
    Padlock? padlock,
    String? id,
    PositionedRenderSettings? renderSettings,
    Action<String>? onTooltip,
  }) : super(
          padlock: padlock,
          id: id ?? object.id,
          renderSettings: renderSettings,
          onTooltip: onTooltip,
        );

  @override
  ActionResult onTap(EscapeGame escapeGame) {
    ActionResult padlockTry = super.onTap(escapeGame);
    if (padlockTry.state == ActionResultState.success) {
      escapeGame.inventory.addObject(object);
      ActionResult result = onPickedUp == null ? ActionResult<EscapeGameObject>.success(object: object) : onPickedUp!(escapeGame);
      if (removeAfterPickedUp) {
        escapeGame.currentRoom.removeInteractable(this);
      }
      return result;
    }
    return padlockTry;
  }
}
