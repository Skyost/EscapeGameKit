import 'package:escape_game_kit/src/game/dialog.dart';
import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/room/interactables/action_result.dart';
import 'package:escape_game_kit/src/game/room/interactables/interactable.dart';
import 'package:escape_game_kit/src/game/room/interactables/render_settings.dart';
import 'package:escape_game_kit/src/game/room/interactables/tooltip.dart';

class Clue extends LockedInteractable {
  String? keyId;
  Action? onCantUnlock;
  Action? onFound;
  InteractableTooltip? foundTooltip;

  Clue({
    required String id,
    InteractableRenderSettings? renderSettings,
    Action<InteractableTooltip>? onHover,
    Padlock? padlock,
    this.keyId,
    this.onCantUnlock,
    this.onFound,
    this.foundTooltip,
  }) : super(
          id: id,
          padlock: padlock,
          renderSettings: renderSettings,
          onHover: onHover,
        );

  Clue.dialog({
    required String id,
    InteractableRenderSettings? renderSettings,
    Action<InteractableTooltip>? onHover,
    Padlock? padlock,
    String? keyId,
    EscapeGameDialog? noKeyDialog,
    EscapeGameDialog? clueDialog,
    InteractableTooltip? foundTooltip,
  }) : this(
          id: id,
          renderSettings: renderSettings,
          onHover: onHover,
          padlock: padlock,
          keyId: keyId,
          onCantUnlock: (escapeGame) {
            if (noKeyDialog != null) {
              escapeGame.openDialog(noKeyDialog);
            }
            return const ActionResult.failed();
          },
          onFound: (escapeGame) {
            if (clueDialog != null) {
              escapeGame.openDialog(clueDialog);
            }
            return const ActionResult.success();
          },
          foundTooltip: foundTooltip,
        );

  @override
  ActionResult onTap(EscapeGame escapeGame) {
    if (keyId != null && !escapeGame.inventory.hasObjectId(keyId!)) {
      ActionResult unlockResult = onCantUnlock == null ? const ActionResult.failed() : onCantUnlock!(escapeGame);
      if (unlockResult.state != ActionResultState.success) {
        return unlockResult;
      }
    }

    ActionResult padlockResult = super.onTap(escapeGame);
    if (padlockResult.state != ActionResultState.success) {
      return padlockResult;
    }
    ActionResult foundResult = onFound == null ? const ActionResult.success() : onFound!(escapeGame);
    if (foundResult.state != ActionResultState.success) {
      return foundResult;
    }
    if (foundTooltip != null) {
      escapeGame.currentRoom.removeInteractable(this, notify: false);
      escapeGame.currentRoom.addInteractable(Interactable(
        id: '$id-found',
        renderSettings: renderSettings,
        onHover: (escapeGame) => ActionResult.success(object: foundTooltip!),
      ));
    }

    return const ActionResult.success();
  }
}
