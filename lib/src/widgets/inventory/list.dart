import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/inventory/object.dart';
import 'package:escape_game_kit/src/widgets/inventory/widget.dart';
import 'package:escape_game_kit/src/widgets/render_settings_stack.dart';
import 'package:flutter/material.dart';

class InventoryList extends InventoryWidget {
  const InventoryList({
    Key? key,
    required EscapeGame escapeGame,
    EscapeGameObjectWidgetBuilder objectWidgetBuilder = InventoryWidget.defaultObjectWidgetBuilder,
  }) : super(
          key: key,
          escapeGame: escapeGame,
          objectWidgetBuilder: objectWidgetBuilder,
        );

  @override
  State<StatefulWidget> createState() => _InventoryListState();
}

class _InventoryListState extends InventoryWidgetState<InventoryList> {
  @override
  Widget build(BuildContext context) => ListView(
        shrinkWrap: true,
        children: [
          if (widget.escapeGame.inventory.objects.isEmpty)
            Text(
              widget.escapeGame.inventory.emptyMessage,
              textAlign: TextAlign.center,
            ),
          for (EscapeGameObject object in objects) //
            RenderSettingsStackWidget(
              renderSettings: object.inventoryRenderSettings,
              child: widget.objectWidgetBuilder(context, widget.escapeGame, object),
            ),
        ],
      );
}
