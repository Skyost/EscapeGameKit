import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/inventory/object.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/room/interactables/action_result.dart';
import 'package:escape_game_kit/src/game/room/interactables/interactable.dart';
import 'package:escape_game_kit/src/game/room/interactables/render_settings.dart';
import 'package:escape_game_kit/src/game/room/interactables/tooltip.dart';

/// A [LockedInteractable] that is meant to be a pickable object.
class PickableObject extends LockedInteractable {
  /// The target [EscapeGameObject].
  final EscapeGameObject object;

  /// Triggered when the object has been picked up.
  final Action? onPickedUp;

  /// Whether to remove this interactable after being picked up.
  final bool removeAfterPickedUp;

  /// Give an [InteractableTooltip] in order to replace this [Clue] when found (if [removeAfterPickedUp] is `true`).
  final InteractableTooltip? removedTooltip;

  /// Creates a new [PickableObject] instance.
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
            id: '$id-picked-up',
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
