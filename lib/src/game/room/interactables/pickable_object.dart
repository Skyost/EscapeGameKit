import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/inventory/object.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/room/interactables/action_result.dart';
import 'package:escape_game_kit/src/game/room/interactables/interactable.dart';
import 'package:escape_game_kit/src/game/room/interactables/render_settings.dart';
import 'package:escape_game_kit/src/game/room/interactables/tooltip.dart';

class PickableObject extends LockedInteractable {
  final EscapeGameObject object;
  final Action? onPickedUp;
  final bool removeAfterPickedUp;
  final InteractableTooltip? removedTooltip;

  PickableObject({
    required this.object,
    this.onPickedUp,
    this.removeAfterPickedUp = true,
    this.removedTooltip,
    Padlock? padlock,
    String? id,
    InteractableRenderSettings? renderSettings,
    Action<InteractableTooltip>? onHover,
  }) : super(
          padlock: padlock,
          id: id ?? object.id,
          renderSettings: renderSettings,
          onHover: onHover,
        );

  @override
  ActionResult onTap(EscapeGame escapeGame) {
    ActionResult padlockTry = super.onTap(escapeGame);
    if (padlockTry.state == ActionResultState.success) {
      escapeGame.inventory.addObject(object);
      ActionResult result = onPickedUp == null ? ActionResult<EscapeGameObject>.success(object: object) : onPickedUp!(escapeGame);
      if (removeAfterPickedUp) {
        escapeGame.currentRoom.removeInteractable(this);
        if (removedTooltip != null) {
          escapeGame.currentRoom.addInteractable(Interactable(
            id: '$id-removed',
            renderSettings: renderSettings,
            onHover: (escapeGame) => ActionResult.success(object: removedTooltip!),
          ));
        }
      }
      return result;
    }
    return padlockTry;
  }
}
