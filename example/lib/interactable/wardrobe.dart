import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/padlocks/painting_padlock.dart';

final PaintingInteractable painting = PaintingInteractable();

class PaintingInteractable extends Interactable {
  PaintingInteractable()
      : super(
          id: 'painting',
          renderSettings: const InteractableRenderSettings(
            top: 40,
            left: 280,
            height: 80,
            width: 100,
          ),
        );

  @override
  ActionResult onTap(EscapeGame escapeGame) {
    if (paintingPadlock.state.isLocked) {
      return ActionResult.needAction(object: paintingPadlock);
    }
    escapeGame.openDialog(const EscapeGameDialog(message: "Il y a un manuel d'informatique !<br><br>Pour redémarrer un ordinateur, utiliser la commande <pre>reboot now</pre>."));
    escapeGame.currentRoom.removeInteractable(this, notify: false);
    escapeGame.currentRoom.addInteractable(Interactable(
        id: id,
        renderSettings: renderSettings,
        onTooltip: (escapeGame) {
          if (!paintingPadlock.state.isLocked) {
            return const ActionResult.success(object: InteractableTooltip(text: 'Vous avez trouvé un indice dans cette armoire.'));
          }
          return const ActionResult.failed();
        }));

    return const ActionResult.success();
  }
}
