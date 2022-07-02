import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/room/interactables/action_result.dart';
import 'package:escape_game_kit/src/game/room/interactables/render_settings.dart';
import 'package:escape_game_kit/src/game/room/interactables/tooltip.dart';
import 'package:escape_game_kit/src/utils/properties_equatable.dart';
import 'package:flutter/foundation.dart';

/// Represents an action, triggered by the player.
typedef Action<T> = ActionResult<T> Function(EscapeGame escapeGame);

/// Represents an in-game displayed object that is interactable.
class Interactable with PropertiesEquatable, ChangeNotifier {
  /// The default action when tapped.
  static ActionResult _defaultOnTap (escapeGame) => const ActionResult.success();

  /// The default action when hovered.
  static ActionResult<InteractableTooltip> _defaultOnHover (escapeGame) => const ActionResult.success();

  /// The interactable identifier.
  final String id;

  /// Controls how to render this object when displayed in-game.
  InteractableRenderSettings? _renderSettings;

  /// The triggered action when the player taps on this interactable.
  final Action _onTap;

  /// The triggered action when the player hovers this interactable.
  final Action<InteractableTooltip> _onHover;

  /// Whether this interactable is destroyed.
  bool _isDestroyed = false;

  /// Creates a new [Interactable] instance.
  Interactable({
    required this.id,
    InteractableRenderSettings? renderSettings,
    Action onTap = _defaultOnTap,
    Action<InteractableTooltip> onHover = _defaultOnHover,
  })  : _renderSettings = renderSettings,
        _onTap = onTap,
        _onHover = onHover;

  /// Should be called when the user taps on this interactable.
  ActionResult onTap(EscapeGame escapeGame) => _onTap(escapeGame);

  /// Should be called when the user hovers this interactable.
  ActionResult<InteractableTooltip> onHover(EscapeGame escapeGame) => _onHover(escapeGame);

  /// Returns this instance render settings.
  InteractableRenderSettings? get renderSettings => _renderSettings;

  /// Changes this instance render settings.
  void changeRenderSettings(InteractableRenderSettings? renderSettings, {bool notify = true}) {
    _renderSettings = renderSettings;
    if (notify) {
      notifyListeners();
    }
  }

  /// Returns whether this instance has been destroyed.
  bool get isDestroyed => _isDestroyed;

  /// Destroys this instance.
  void destroy({bool notify = true}) {
    _isDestroyed = true;
    if (notify) {
      notifyListeners();
    }
  }

  @override
  @protected
  List<Object?> get props => [id, _renderSettings, _onTap, _onHover];
}

/// Represents an [Interactable] object that is locked.
class LockedInteractable extends Interactable {
  /// The padlock.
  final Padlock? padlock;

  /// Creates a new [LockedInteractable] instance.
  LockedInteractable({
    this.padlock,
    required super.id,
    super.renderSettings,
    super.onTap,
    super.onHover,
  });

  @override
  ActionResult onTap(EscapeGame escapeGame) {
    if (padlock?.isLocked == true) {
      return ActionResult.needAction(object: padlock);
    }
    return super.onTap(escapeGame);
  }
}
