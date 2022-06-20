import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/inventory/object.dart';
import 'package:escape_game_kit/src/utils/assets_extension.dart';
import 'package:escape_game_kit/src/utils/auto_image.dart';
import 'package:flutter/material.dart';

/// Allows to build the widget that displays an [EscapeGameObject].
typedef EscapeGameObjectWidgetBuilder = Widget Function(BuildContext context, EscapeGame escapeGame, EscapeGameObject object);

/// Base class that allows to create a widget that display an [Inventory].
abstract class InventoryWidget extends StatefulWidget {
  /// The [EscapeGame] instance.
  final EscapeGame escapeGame;

  /// The [EscapeGameObject] widget builder.
  final EscapeGameObjectWidgetBuilder objectWidgetBuilder;

  /// Creates a new [InventoryWidget] instance.
  const InventoryWidget({
    Key? key,
    required this.escapeGame,
    this.objectWidgetBuilder = defaultObjectWidgetBuilder,
  }) : super(
          key: key,
        );

  /// The default [EscapeGameObject] widget builder.
  static Widget defaultObjectWidgetBuilder(BuildContext context, EscapeGame escapeGame, EscapeGameObject object) => Tooltip(
        message: object.name,
        child: AutoImage.fromRenderSettings(
          renderSettings: object.inventoryRenderSettings,
          defaultAssetPath: object.defaultAssetPath,
        ),
      );
}

/// Base class that allows to create the state of a widget that display an [Inventory].
abstract class InventoryWidgetState<T extends InventoryWidget> extends State<T> {
  /// The currently displayed objects.
  List<EscapeGameObject> objects = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
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

  /// Refreshes the currently displayed objects.
  void refreshObjects() {
    if (mounted && objects != widget.escapeGame.inventory.objects) {
      setState(() {
        objects = widget.escapeGame.inventory.objects;
      });
    }
  }
}
