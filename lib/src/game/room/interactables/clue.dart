import 'package:escape_game_kit/src/game/dialog.dart';
import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/room/interactables/action_result.dart';
import 'package:escape_game_kit/src/game/room/interactables/interactable.dart';
import 'package:escape_game_kit/src/game/room/interactables/render_settings.dart';
import 'package:escape_game_kit/src/game/room/interactables/tooltip.dart';

/// A [LockedInteractable] that is meant to be a clue.
class Clue extends LockedInteractable {
  /// The default action when hovered.
  static ActionResult<InteractableTooltip> _defaultOnHover (escapeGame) => const ActionResult.success();

  /// If this [Interactable] should be found only when the user has a specific key, provides its id here.
  String? keyId;

  /// Triggered when the user cannot unlock this clue.
  Action? onCantUnlock;

  /// Triggered when the user has found this clue.
  Action? onFound;

  /// Whether to remove this interactable after being found.
  final bool removeAfterFound;

  /// Give an [InteractableTooltip] in order to replace this [Clue] when found (if [removeAfterFound] is `true`).
  InteractableTooltip? removedTooltip;

  /// Creates a new [Clue] instance.
  Clue({
    required super.id,
    super.renderSettings,
    super.onHover,
    super.padlock,
    this.keyId,
    this.onCantUnlock,
    this.onFound,
    this.removeAfterFound = false,
    this.removedTooltip,
  });

  /// Creates a new [Clue] instance by providing some dialogs.
  Clue.dialog({
    required String id,
    InteractableRenderSettings? renderSettings,
    Action<InteractableTooltip> onHover = _defaultOnHover,
    Padlock? padlock,
    String? keyId,
    EscapeGameDialog? noKeyDialog,
    EscapeGameDialog? clueDialog,
    bool removeAfterFound = false,
    InteractableTooltip? removedTooltip,
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
          removeAfterFound: removeAfterFound,
          removedTooltip: removedTooltip,
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
    if (removeAfterFound) {
      escapeGame.currentRoom.removeInteractable(this, notify: false);
      if (removedTooltip != null) {
        escapeGame.currentRoom.addInteractable(Interactable(
          id: '$id-found',
          renderSettings: renderSettings,
          onHover: (escapeGame) => ActionResult.success(object: removedTooltip!),
        ));
      }
    }

    return const ActionResult.success();
  }
}
