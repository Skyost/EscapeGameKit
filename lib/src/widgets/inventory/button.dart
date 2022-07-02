import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/widgets/inventory/dialog.dart';
import 'package:flutter/material.dart';

/// The inventory button widget.
class InventoryButton extends StatefulWidget {
  /// The [EscapeGame] instance.
  final EscapeGame escapeGame;

  /// The inventory icon.
  final Icon? inventoryIcon;

  /// The button style.
  final ButtonStyle? buttonStyle;

  /// Triggered when this button has been pressed.
  final VoidCallback? onPressed;

  /// Shown when the inventory has changed.
  final String? changedText;

  /// Creates a new [InventoryButton] instance.
  const InventoryButton({
    super.key,
    required this.escapeGame,
    this.inventoryIcon = const Icon(Icons.work),
    this.buttonStyle,
    this.onPressed,
    this.changedText = ' 💡',
  });

  @override
  State<StatefulWidget> createState() => _InventoryButtonState();
}

/// The [InventoryButton] state.
class _InventoryButtonState extends State<InventoryButton> {
  /// Whether the inventory has changed.
  bool inventoryHasChanged = false;

  @override
  void initState() {
    super.initState();
    widget.escapeGame.inventory.addListener(onInventoryChanged);
  }

  @override
  Widget build(BuildContext context) => TextButton.icon(
        icon: Padding(
          padding: const EdgeInsets.only(
            top: 8,
            left: 10,
            bottom: 8,
          ).copyWith(right: widget.escapeGame.inventory.title == null ? 10 : 0),
          child: widget.inventoryIcon,
        ),
        label: widget.escapeGame.inventory.title == null
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(widget.escapeGame.inventory.title! + (inventoryHasChanged && widget.changedText != null ? widget.changedText! : '')),
              ),
        style: widget.buttonStyle ??
            ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black54),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(const RoundedRectangleBorder()),
            ),
        onPressed: () {
          if (inventoryHasChanged) {
            setState(() => inventoryHasChanged = false);
          }
          if (widget.onPressed == null) {
            InventoryDialog.openDialog(
              context,
              escapeGame: widget.escapeGame,
            );
          } else {
            widget.onPressed!();
          }
        },
      );

  @override
  void dispose() {
    widget.escapeGame.inventory.removeListener(onInventoryChanged);
    super.dispose();
  }

  void onInventoryChanged() {
    if (mounted) {
      setState(() => inventoryHasChanged = true);
    }
  }
}
