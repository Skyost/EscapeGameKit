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
    Key? key,
    required this.animation,
    required this.child,
    this.controller,
    this.animate = true,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    if (animation == null) {
      return child;
    }

    switch (animation!.type) {
      case InteractableAnimationType.fadeIn:
        return FadeIn(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
        );
      case InteractableAnimationType.fadeInDown:
        return FadeInDown(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.fadeInDownBig:
        return FadeInDownBig(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.fadeInUp:
        return FadeInUp(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.fadeInUpBig:
        return FadeInUpBig(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.fadeInLeft:
        return FadeInLeft(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.fadeInLeftBig:
        return FadeInLeftBig(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.fadeInRight:
        return FadeInRight(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.fadeInRightBig:
        return FadeInRightBig(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.fadeOut:
        return FadeOut(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
        );
      case InteractableAnimationType.fadeOutDown:
        return FadeOutDown(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.fadeOutDownBig:
        return FadeOutDownBig(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.fadeOutUp:
        return FadeOutUp(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.fadeOutUpBig:
        return FadeOutUpBig(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.fadeOutLeft:
        return FadeOutLeft(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.fadeOutLeftBig:
        return FadeOutLeftBig(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.fadeOutRight:
        return FadeOutRight(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.fadeOutRightBig:
        return FadeOutRightBig(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.bounceInDown:
        return BounceInDown(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.bounceInUp:
        return BounceInUp(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.bounceInLeft:
        return BounceInLeft(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.bounceInRight:
        return BounceInRight(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.elasticIn:
        return ElasticIn(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
        );
      case InteractableAnimationType.elasticInDown:
        return ElasticInDown(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.elasticInUp:
        return ElasticInUp(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.elasticInLeft:
        return ElasticInLeft(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.elasticInRight:
        return ElasticInRight(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.slideInDown:
        return SlideInDown(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.slideInUp:
        return SlideInUp(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.slideInLeft:
        return SlideInLeft(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.slideInRight:
        return SlideInRight(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.flipInX:
        return FlipInX(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
        );
      case InteractableAnimationType.flipInY:
        return FlipInY(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
        );
      case InteractableAnimationType.zoomIn:
        return ZoomIn(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.zoomOut:
        return ZoomOut(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
        );
      case InteractableAnimationType.jelloIn:
        return JelloIn(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
        );
      case InteractableAnimationType.bounce:
        return Bounce(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          from: animation!.from,
          infinite: animation!.infinite,
        );
      case InteractableAnimationType.flash:
        return Flash(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          infinite: animation!.infinite,
        );
      case InteractableAnimationType.pulse:
        return Pulse(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          infinite: animation!.infinite,
        );
      case InteractableAnimationType.swing:
        return Swing(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          infinite: animation!.infinite,
        );
      case InteractableAnimationType.spin:
        return Spin(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          infinite: animation!.infinite,
        );
      case InteractableAnimationType.spinPerfect:
        return SpinPerfect(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          infinite: animation!.infinite,
        );
      case InteractableAnimationType.dance:
        return Dance(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          infinite: animation!.infinite,
        );
      case InteractableAnimationType.roulette:
        return Roulette(
          child: child,
          duration: animation!.duration,
          delay: animation!.delay,
          controller: controller,
          manualTrigger: animation!.manualTrigger,
          animate: animate,
          infinite: animation!.infinite,
        );
      default:
        return child;
    }
  }
}
