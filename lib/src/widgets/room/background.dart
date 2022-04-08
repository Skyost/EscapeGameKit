import 'package:escape_game_kit/src/game/room/room.dart';
import 'package:escape_game_kit/src/utils/assets_extension.dart';
import 'package:escape_game_kit/src/utils/auto_image.dart';
import 'package:escape_game_kit/src/widgets/render_settings.dart';
import 'package:flutter/material.dart';

/// Allows to render the background of a [Room].
class RoomBackgroundWidget extends StatelessWidget {
  /// The room.
  final Room room;

  /// Creates a new [RoomBackgroundWidget] instance.
  RoomBackgroundWidget({
    Key? key,
    required this.room,
  }) : super(
          key: key ?? ValueKey<String>('background-${room.id}'),
        );

  @override
  Widget build(BuildContext context) => AutoImage(
        asset: room.renderSettings?.asset ?? room.defaultAssetPath,
        height: room.renderSettings?.height,
        width: room.renderSettings?.width,
        errorBuilder: RenderSettingsWidget.getImageErrorWidgetBuilder(room.renderSettings),
      );
}
