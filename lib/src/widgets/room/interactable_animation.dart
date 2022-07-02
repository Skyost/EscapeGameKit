import 'package:animate_do/animate_do.dart';
import 'package:escape_game_kit/src/game/room/interactables/render_settings.dart';
import 'package:flutter/material.dart';

/// Allows to render an [InteractableAnimation] thanks to `animate_do`.
class InteractableAnimationWidget extends StatelessWidget {
  /// The animation.
  final InteractableAnimation? animation;

  /// The child widget.
  final Widget child;

  /// The animation controller.
  final Function(AnimationController)? controller;

  /// Whether to animate.
  final bool animate;

  /// Creates a new [InteractableAnimationWidget] instance.
  const InteractableAnimationWidget({
    super.key,
    required this.animation,
    required this.child,
    this.controller,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    if (animation == null) {
      return child;
    }

    switch (animation!.type) {
      case InteractableAnimationType.fadeIn:
        return FadeIn(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          child: child,
        );
      case InteractableAnimationType.fadeInDown:
        return FadeInDown(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.fadeInDownBig:
        return FadeInDownBig(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.fadeInUp:
        return FadeInUp(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.fadeInUpBig:
        return FadeInUpBig(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.fadeInLeft:
        return FadeInLeft(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.fadeInLeftBig:
        return FadeInLeftBig(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.fadeInRight:
        return FadeInRight(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.fadeInRightBig:
        return FadeInRightBig(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.fadeOut:
        return FadeOut(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          child: child,
        );
      case InteractableAnimationType.fadeOutDown:
        return FadeOutDown(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.fadeOutDownBig:
        return FadeOutDownBig(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.fadeOutUp:
        return FadeOutUp(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.fadeOutUpBig:
        return FadeOutUpBig(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.fadeOutLeft:
        return FadeOutLeft(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.fadeOutLeftBig:
        return FadeOutLeftBig(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.fadeOutRight:
        return FadeOutRight(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.fadeOutRightBig:
        return FadeOutRightBig(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.bounceInDown:
        return BounceInDown(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.bounceInUp:
        return BounceInUp(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.bounceInLeft:
        return BounceInLeft(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.bounceInRight:
        return BounceInRight(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.elasticIn:
        return ElasticIn(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          child: child,
        );
      case InteractableAnimationType.elasticInDown:
        return ElasticInDown(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.elasticInUp:
        return ElasticInUp(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.elasticInLeft:
        return ElasticInLeft(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.elasticInRight:
        return ElasticInRight(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.slideInDown:
        return SlideInDown(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.slideInUp:
        return SlideInUp(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.slideInLeft:
        return SlideInLeft(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.slideInRight:
        return SlideInRight(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.flipInX:
        return FlipInX(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          child: child,
        );
      case InteractableAnimationType.flipInY:
        return FlipInY(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          child: child,
        );
      case InteractableAnimationType.zoomIn:
        return ZoomIn(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.zoomOut:
        return ZoomOut(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          child: child,
        );
      case InteractableAnimationType.jelloIn:
        return JelloIn(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          child: child,
        );
      case InteractableAnimationType.bounce:
        return Bounce(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          infinite: animation!.infinite,
          child: child,
        );
      case InteractableAnimationType.flash:
        return Flash(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          infinite: animation!.infinite,
          child: child,
        );
      case InteractableAnimationType.pulse:
        return Pulse(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          infinite: animation!.infinite,
          child: child,
        );
      case InteractableAnimationType.swing:
        return Swing(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          infinite: animation!.infinite,
          child: child,
        );
      case InteractableAnimationType.spin:
        return Spin(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          infinite: animation!.infinite,
          child: child,
        );
      case InteractableAnimationType.spinPerfect:
        return SpinPerfect(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          infinite: animation!.infinite,
          child: child,
        );
      case InteractableAnimationType.dance:
        return Dance(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          infinite: animation!.infinite,
          child: child,
        );
      case InteractableAnimationType.roulette:
        return Roulette(
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          infinite: animation!.infinite,
          child: child,
        );
      default:
        return child;
    }
  }
}
