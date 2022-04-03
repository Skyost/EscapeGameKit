import 'package:escape_game_kit/src/game/render/positioned.dart';

class InteractableRenderSettings extends PositionedRenderSettings {
  final InteractableAnimation? hoverAnimation;
  final InteractableAnimation? enterAnimation;

  const InteractableRenderSettings({
    double? top,
    double? right,
    double? bottom,
    double? left,
    double? width,
    double? height,
    double? rotationAngle,
    String? asset,
    bool? isInvisible,
    this.hoverAnimation,
    this.enterAnimation,
  }) : super(
          top: top,
          right: right,
          bottom: bottom,
          left: left,
          width: width,
          height: height,
          rotationAngle: rotationAngle,
          asset: asset,
          isInvisible: isInvisible,
        );

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
  int get hashCode => super.hashCode + hoverAnimation.hashCode + enterAnimation.hashCode;
}

class InteractableAnimation {
  final InteractableAnimationType type;
  final Duration duration;
  final Duration delay;
  final bool manualTrigger;
  final double from;
  final bool infinite;

  const InteractableAnimation({
    required this.type,
    this.duration = const Duration(seconds: 1),
    this.delay = Duration.zero,
    this.manualTrigger = false,
    this.from = 0,
    bool? infinite,
  }) : infinite = infinite ?? (type == InteractableAnimationType.bounce || type == InteractableAnimationType.flash || type == InteractableAnimationType.pulse || type == InteractableAnimationType.swing || type == InteractableAnimationType.spin || type == InteractableAnimationType.spinPerfect || type == InteractableAnimationType.dance || type == InteractableAnimationType.roulette);

  @override
  bool operator ==(Object other) {
    if (other is! InteractableAnimation) {
      return super == other;
    }
    return identical(this, other) || (type == other.type && duration == other.duration && delay == other.delay && manualTrigger == other.manualTrigger && from == other.from && infinite == other.infinite);
  }

  @override
  int get hashCode => type.hashCode + duration.hashCode + delay.hashCode + manualTrigger.hashCode + from.hashCode + infinite.hashCode;
}

enum InteractableAnimationType {
  fadeIn,
  fadeInDown,
  fadeInDownBig,
  fadeInUp,
  fadeInUpBig,
  fadeInLeft,
  fadeInLeftBig,
  fadeInRight,
  fadeInRightBig,
  fadeOut,
  fadeOutDown,
  fadeOutDownBig,
  fadeOutUp,
  fadeOutUpBig,
  fadeOutLeft,
  fadeOutLeftBig,
  fadeOutRight,
  fadeOutRightBig,
  bounceInDown,
  bounceInUp,
  bounceInLeft,
  bounceInRight,
  elasticIn,
  elasticInDown,
  elasticInUp,
  elasticInLeft,
  elasticInRight,
  slideInDown,
  slideInUp,
  slideInLeft,
  slideInRight,
  flipInX,
  flipInY,
  zoomIn,
  zoomOut,
  jelloIn,
  bounce,
  flash,
  pulse,
  swing,
  spin,
  spinPerfect,
  dance,
  roulette,
}
