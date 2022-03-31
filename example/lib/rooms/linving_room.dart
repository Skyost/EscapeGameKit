import 'package:escape_game_kit/escape_game_kit.dart';

final Room livingRoom = Room(
  id: 'living-room',
  interactables: [
    Door(
      id: 'bedroom-door',
      renderSettings: InteractableRenderSettings(
        asset: 'assets/interactables/arrow.svg',
        top: 100,
        left: 20,
        height: 80,
        width: 80,
        rotationAngle: -1,
        hoverAnimation: InteractableAnimation(type: InteractableAnimationType.pulse),
      ),
      onTooltip: (escapeGame) => const ActionResult<String>.success(object: 'Vers la chambre'),
      roomId: 'bedroom',
    ),
  ],
);