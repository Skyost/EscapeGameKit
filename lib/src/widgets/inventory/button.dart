import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/widgets/inventory/dialog.dart';
import 'package:flutter/material.dart';

class InventoryButton extends StatelessWidget {
  final EscapeGame escapeGame;
  final Icon inventoryIcon;
  final ButtonStyle? buttonStyle;
  final VoidCallback? onPressed;

  const InventoryButton({
    Key? key,
    required this.escapeGame,
    this.inventoryIcon = const Icon(Icons.work),
    this.buttonStyle,
    this.onPressed,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) => TextButton.icon(
        icon: Padding(
          padding: const EdgeInsets.only(
            top: 8,
            left: 10,
            bottom: 8,
          ).copyWith(right: escapeGame.inventory.title == null ? 10 : 0),
          child: inventoryIcon,
        ),
        label: escapeGame.inventory.title == null
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(escapeGame.inventory.title!),
              ),
        style: buttonStyle ??
            ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black54),
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
        onPressed: onPressed ??
            () => InventoryDialog.openDialog(
                  context,
                  escapeGame: escapeGame,
                ),
      );
}
