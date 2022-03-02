import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/render/positioned.dart';
import 'package:escape_game_kit/src/game/room/interactables/action_result.dart';
import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/render/render_settings.dart';
import 'package:flutter/material.dart';

typedef Action<T> = ActionResult<T> Function(EscapeGame escapeGame);

class Interactable with ChangeNotifier {
  final String id;
  PositionedRenderSettings? _renderSettings;
  final Action? _onTap;
  final Action<String>? _onTooltip;

  bool _isDestroyed = false;

  Interactable({
    required this.id,
    PositionedRenderSettings? renderSettings,
    Action? onTap,
    Action<String>? onTooltip,
  })  : _renderSettings = renderSettings,
        _onTap = onTap,
        _onTooltip = onTooltip;

  ActionResult onTap(EscapeGame escapeGame) => _onTap == null ? const ActionResult.success() : _onTap!(escapeGame);

  ActionResult<String> onTooltip(EscapeGame escapeGame) => _onTooltip == null
      ? const ActionResult.success(
          object: null,
        )
      : _onTooltip!(escapeGame);

  PositionedRenderSettings? get renderSettings => _renderSettings;

  void changeRenderSettings(PositionedRenderSettings? renderSettings, {bool notify = true}) {
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
    PositionedRenderSettings? renderSettings,
    Action? onTap,
    Action<String>? onTooltip,
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
    return const ActionResult.success();
  }
}
