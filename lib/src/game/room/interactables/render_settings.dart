import 'package:escape_game_kit/src/game/render/positioned.dart';
import 'package:escape_game_kit/src/utils/properties_equatable.dart';
import 'package:flutter/foundation.dart';

/// Controls how an [Interactable] should be rendered in-game.
class InteractableRenderSettings extends PositionedRenderSettings {
  /// The [Interactable] animation when hovered.
  final InteractableAnimation? hoverAnimation;

  /// The [Interactable] animation when displayed for the first time.
  final InteractableAnimation? enterAnimation;

  /// Creates a new [InteractableRenderSettings] instance.
  const InteractableRenderSettings({
    super.top,
    super.right,
    super.bottom,
    super.left,
    super.width,
    super.height,
    super.rotationAngle,
    super.mirror,
    super.asset,
    super.isInvisible,
    this.hoverAnimation,
    this.enterAnimation,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is PositionedRenderSettings) {
      if (super != other) {
        return false;
      }

      if (other is! InteractableRenderSettings) {
        return hoverAnimation == null && enterAnimation == null;
      }
      return hoverAnimation == other.hoverAnimation && enterAnimation == other.enterAnimation;
    }
    return super == other;
  }

  @override
  List<Object?> get props => [...super.props, hoverAnimation, enterAnimation];
}

/// Represents an interactable animation.
class InteractableAnimation with PropertiesEquatable {
  /// The animation type.
  final InteractableAnimationType type;

  /// The animation duration.
  final Duration duration;

  /// The animation delay.
  final Duration delay;

  /// Whether this animation should be manually triggered.
  final bool manualTrigger;

  /// The starting value. Not used by all types.
  final double from;

  /// Whether this animation is infinite. Not used by all types.
  final bool infinite;

  /// Creates a new [InteractableAnimation] instance.
  const InteractableAnimation({
    required this.type,
    this.duration = const Duration(seconds: 1),
    this.delay = Duration.zero,
    this.manualTrigger = false,
    this.from = 0,
    bool? infinite,
  }) : infinite = infinite ?? (type == InteractableAnimationType.bounce || type == InteractableAnimationType.flash || type == InteractableAnimationType.pulse || type == InteractableAnimationType.swing || type == InteractableAnimationType.spin || type == InteractableAnimationType.spinPerfect || type == InteractableAnimationType.dance || type == InteractableAnimationType.roulette);

  @override
  @protected
  List<Object?> get props => [type, duration, delay, manualTrigger, from, infinite];
}

/// Represents an interactable animation type.
enum InteractableAnimationType {
  /// Fade-in animation.
  fadeIn,

  /// Fade-in down animation.
  fadeInDown,

  /// Fade-in down big animation.
  fadeInDownBig,

  /// Fade-in up animation.
  fadeInUp,

  /// Fade-in up big animation.
  fadeInUpBig,

  /// Fade-in left animation.
  fadeInLeft,

  /// Fade-in left big animation.
  fadeInLeftBig,

  /// Fade-in right animation.
  fadeInRight,

  /// Fade-in right big animation.
  fadeInRightBig,

  /// Fade-out animation.
  fadeOut,

  /// Fade-out down animation.
  fadeOutDown,

  /// Fade-out down big animation.
  fadeOutDownBig,

  /// Fade-out up animation.
  fadeOutUp,

  /// Fade-out up big animation.
  fadeOutUpBig,

  /// Fade-out left animation.
  fadeOutLeft,

  /// Fade-out left big animation.
  fadeOutLeftBig,

  /// Fade-out right animation.
  fadeOutRight,

  /// Fade-out right big animation.
  fadeOutRightBig,

  /// Bounce in down animation.
  bounceInDown,

  /// Bounce in up animation.
  bounceInUp,

  /// Bounce in left animation.
  bounceInLeft,

  /// Bounce in right animation.
  bounceInRight,

  /// Elastic in animation.
  elasticIn,

  /// Elastic in down animation.
  elasticInDown,

  /// Elastic in up animation.
  elasticInUp,

  /// Elastic in left animation.
  elasticInLeft,

  /// Elastic in right animation.
  elasticInRight,

  /// Slide in down animation.
  slideInDown,

  /// Slide in up animation.
  slideInUp,

  /// Slide in left animation.
  slideInLeft,

  /// Slide in right animation.
  slideInRight,

  /// Flip in X animation.
  flipInX,

  /// Flip in Y animation.
  flipInY,

  /// Zoom in animation.
  zoomIn,

  /// Zoom out animation.
  zoomOut,

  /// Jello in animation.
  jelloIn,

  /// Bounce animation.
  bounce,

  /// Flash animation.
  flash,

  /// Pulse animation.
  pulse,

  /// Swing animation.
  swing,

  /// Spin animation.
  spin,

  /// Spin perfect animation.
  spinPerfect,

  /// Dance animation.
  dance,

  /// Roulette animation.
  roulette,
}
