import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/inventory/object.dart';
import 'package:escape_game_kit/src/widgets/alert_dialog.dart';
import 'package:escape_game_kit/src/widgets/inventory/widget.dart';
import 'package:flutter/material.dart';

/// Allows to display the inventory in a dialog.
class InventoryDialog extends InventoryWidget {
  /// Creates a new [InventoryDialog] instance.
  const InventoryDialog({
    super.key,
    required super.escapeGame,
    super.objectWidgetBuilder = InventoryWidget.defaultObjectWidgetBuilder,
  });

  @override
  State<StatefulWidget> createState() => _InventoryDialogState();

  /// Opens the dialog.
  static void openDialog(
    BuildContext context, {
    required EscapeGame escapeGame,
    EscapeGameObjectWidgetBuilder objectWidgetBuilder = InventoryWidget.defaultObjectWidgetBuilder,
  }) =>
      showDialog(
        context: context,
        builder: (context) => InventoryDialog(
          escapeGame: escapeGame,
          objectWidgetBuilder: objectWidgetBuilder,
        ),
      );
}

/// The [InventoryDialog] state.
class _InventoryDialogState extends InventoryWidgetState<InventoryDialog> {
  @override
  Widget build(BuildContext context) => EscapeGameAlertDialog.oneChild(
        title: widget.escapeGame.inventory.title,
        actions: const [
          EscapeGameAlertDialogCloseButton(cancel: false),
        ],
        child: widget.escapeGame.inventory.objects.isEmpty
            ? Text(
                widget.escapeGame.inventory.emptyMessage,
                textAlign: TextAlign.center,
              )
            : Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 10,
                spacing: 10,
                children: [
                  for (EscapeGameObject object in objects) //
                    widget.objectWidgetBuilder(context, widget.escapeGame, object)
                ],
              ),
      );
}
