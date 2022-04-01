import 'package:escape_game_kit/src/game/dialog.dart';
import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/room/interactables/action_result.dart';
import 'package:escape_game_kit/src/game/room/interactables/interactable.dart';
import 'package:escape_game_kit/src/game/room/interactables/render_settings.dart';
import 'package:escape_game_kit/src/game/room/interactables/tooltip.dart';

class Clue extends LockedInteractable {
  String? keyId;
  EscapeGameDialog? noKeyDialog;
  EscapeGameDialog? clueDialog;
  InteractableTooltip? foundTooltip;

  Clue({
    required String id,
    InteractableRenderSettings? renderSettings,
    Action<InteractableTooltip>? onTooltip,
    Padlock? padlock,
    this.keyId,
    this.noKeyDialog,
    this.clueDialog,
    this.foundTooltip,
  }) : super(
          id: id,
          padlock: padlock,
          renderSettings: renderSettings,
          onTooltip: onTooltip,
        );

  @override
  ActionResult onTap(EscapeGame escapeGame) {
    if (keyId == null || escapeGame.inventory.hasObjectId(keyId!)) {
      ActionResult padlockResult = super.onTap(escapeGame);
      if (padlockResult.state != ActionResultState.success) {
        return padlockResult;
      }
      if (clueDialog != null) {
        escapeGame.openDialog(clueDialog!);
      }
      if (foundTooltip != null) {
        escapeGame.currentRoom.removeInteractable(this, notify: false);
        escapeGame.currentRoom.addInteractable(Interactable(
          id: id,
          renderSettings: renderSettings,
          onTooltip: (escapeGame) => ActionResult.success(object: foundTooltip!),
        ));
      }
    } else if (noKeyDialog != null) {
      escapeGame.openDialog(noKeyDialog!);
    }
    return const ActionResult.success();
  }
}
