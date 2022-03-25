import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/inventory/object.dart';
import 'package:escape_game_kit/src/utils/assets_extension.dart';
import 'package:escape_game_kit/src/utils/auto_image.dart';
import 'package:escape_game_kit/src/widgets/render_settings_stack.dart';
import 'package:flutter/material.dart';

typedef EscapeGameObjectWidgetBuilder = Widget Function(BuildContext context, EscapeGame escapeGame, EscapeGameObject object);

abstract class InventoryWidget extends StatefulWidget {
  final EscapeGame escapeGame;
  final EscapeGameObjectWidgetBuilder objectWidgetBuilder;

  const InventoryWidget({
    Key? key,
    required this.escapeGame,
    this.objectWidgetBuilder = defaultObjectWidgetBuilder,
  }) : super(
          key: key,
        );

  static Widget defaultObjectWidgetBuilder(BuildContext context, EscapeGame escapeGame, EscapeGameObject object) => Tooltip(
        message: object.name,
        child: AutoImage(
          asset: object.inventoryRenderSettings?.asset ?? object.defaultAssetPath,
          width: object.inventoryRenderSettings?.width,
          height: object.inventoryRenderSettings?.height,
          errorBuilder: RenderSettingsStackWidget.getImageErrorWidgetBuilder(object.inventoryRenderSettings),
        ),
      );
}

abstract class InventoryWidgetState<T extends InventoryWidget> extends State<T> {
  List<EscapeGameObject> objects = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      refreshObjects();
      widget.escapeGame.addListener(refreshObjects);
    });
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.escapeGame != widget.escapeGame || oldWidget.escapeGame.inventory != widget.escapeGame.inventory) {
      refreshObjects();
    }
  }

  @override
  void dispose() {
    widget.escapeGame.removeListener(refreshObjects);
    super.dispose();
  }

  void refreshObjects() {
    if (mounted && objects != widget.escapeGame.inventory.objects) {
      setState(() {
        objects = widget.escapeGame.inventory.objects;
      });
    }
  }
}
