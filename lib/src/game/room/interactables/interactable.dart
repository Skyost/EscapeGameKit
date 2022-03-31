import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/room/interactables/action_result.dart';
import 'package:escape_game_kit/src/game/room/interactables/render_settings.dart';
import 'package:escape_game_kit/src/game/room/interactables/tooltip.dart';
import 'package:escape_game_kit/src/utils/id_equatable.dart';
import 'package:flutter/material.dart';

typedef Action<T> = ActionResult<T> Function(EscapeGame escapeGame);

class Interactable with IdEquatable<String>, ChangeNotifier {
  @override
  final String id;
  InteractableRenderSettings? _renderSettings;
  final Action? _onTap;
  final Action<InteractableTooltip>? _onTooltip;

  bool _isDestroyed = false;

  Interactable({
    required this.id,
    InteractableRenderSettings? renderSettings,
    Action? onTap,
    Action<InteractableTooltip>? onTooltip,
  })  : _renderSettings = renderSettings,
        _onTap = onTap,
        _onTooltip = onTooltip;

  ActionResult onTap(EscapeGame escapeGame) => _onTap == null ? const ActionResult.success() : _onTap!(escapeGame);

  ActionResult<InteractableTooltip> onTooltip(EscapeGame escapeGame) => _onTooltip == null
      ? const ActionResult.success(
          object: null,
        )
      : _onTooltip!(escapeGame);

  InteractableRenderSettings? get renderSettings => _renderSettings;

  void changeRenderSettings(InteractableRenderSettings? renderSettings, {bool notify = true}) {
    _renderSettings = renderSettings;
    if (notify) {
      notifyListeners();
    }
  }

  bool get isDestroyed => _isDestroyed;

  void destroy({bool notify = true}) {
    _isDestroyed = true;
    if (notify) {
      notifyListeners();
    }
  }
}

class LockedInteractable extends Interactable {
  final Padlock? padlock;

  LockedInteractable({
    required this.padlock,
    required String id,
    InteractableRenderSettings? renderSettings,
    Action? onTap,
    Action<InteractableTooltip>? onTooltip,
  }) : super(
          id: id,
          renderSettings: renderSettings,
          onTap: onTap,
          onTooltip: onTooltip,
        );

  @override
  ActionResult onTap(EscapeGame escapeGame) {
    if (padlock?.state.isLocked == true) {
      return ActionResult(
        state: ActionResultState.needAction,
        object: padlock,
      );
    }
    return super.onTap(escapeGame);
  }
}
