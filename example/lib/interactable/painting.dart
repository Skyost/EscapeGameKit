import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/objects/painting_key.dart';
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
    if (escapeGame.inventory.objects.contains(paintingKey)) {
      if (paintingPadlock.state.isLocked) {
        return ActionResult.needAction(object: paintingPadlock);
      }
      escapeGame.openDialog(const EscapeGameDialog(message: "Nous sommes bloqués en 1980 !? Mais comment sortir d'ici ?<br>Tiens, il y a un autre message dans le coffre...<br><br>« 1! = 1 ; 2! = 2 ; 3! = 6 ; 4! = 24 ; 5! = <em>?</em> »"));
      escapeGame.currentRoom.removeInteractable(this, notify: false);
      escapeGame.currentRoom.addInteractable(Interactable(
        id: id,
        renderSettings: renderSettings,
        onTooltip: (escapeGame) {
          if (!paintingPadlock.state.isLocked) {
            return const ActionResult.success(object: InteractableTooltip(text: 'Vous avez trouvé un indice derrière ce tableau.'));
          }
          return const ActionResult.failed();
        }
      ));
    } else {
      escapeGame.openDialog(const EscapeGameDialog(message: 'Le coffre derrière ce tableau est protégé par un cadenas fermé à clé...'));
    }
    return const ActionResult.success();
  }
}
