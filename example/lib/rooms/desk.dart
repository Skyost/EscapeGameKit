import 'dart:math';

import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/interactable/painting.dart';

final Room desk = Room(
  id: 'desk',
  interactables: [
    Door(
      id: 'bedroom-door',
      renderSettings: InteractableRenderSettings(
        asset: 'assets/interactables/arrow.svg',
        top: 200,
        right: 20,
        height: 80,
        width: 80,
        rotationAngle: pi / 2 + 0.2,
        hoverAnimation: InteractableAnimation(type: InteractableAnimationType.pulse),
      ),
      onTooltip: (escapeGame) => const ActionResult.success(
        object: InteractableTooltip(
          text: 'Vers la chambre',
          xShift: -20,
        ),
      ),
      roomId: 'bedroom',
    ),
    painting,
    Interactable(
      id: 'wardrobe',
      renderSettings: const InteractableRenderSettings(
        top: 48,
        left: 106,
        height: 238,
        width: 157,
      ),
    ),
  ],
);
