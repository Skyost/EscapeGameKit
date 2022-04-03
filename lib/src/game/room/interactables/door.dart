import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/room/interactables/action_result.dart';
import 'package:escape_game_kit/src/game/room/interactables/interactable.dart';
import 'package:escape_game_kit/src/game/room/interactables/render_settings.dart';
import 'package:escape_game_kit/src/game/room/interactables/tooltip.dart';

class Door extends LockedInteractable {
  final String roomId;

  Door({
    required this.roomId,
    Padlock? padlock,
    required String id,
    InteractableRenderSettings? renderSettings,
    Action? onTap,
    Action<InteractableTooltip>? onHover,
  }) : super(
          padlock: padlock,
          id: id,
          renderSettings: renderSettings,
          onTap: onTap,
          onHover: onHover,
        );

  @override
  ActionResult onTap(EscapeGame escapeGame) {
    ActionResult padlockTry = super.onTap(escapeGame);
    if (padlockTry.state == ActionResultState.success) {
      escapeGame.goToRoom(roomId);
      return ActionResult<String>.success(object: roomId);
    }
    return padlockTry;
  }
}
