import 'package:escape_game_kit/src/game/room/room.dart';
import 'package:escape_game_kit/src/widgets/render_settings_stack.dart';
import 'package:flutter/material.dart';
import 'package:escape_game_kit/src/utils/assets_extension.dart';

class RoomBackgroundWidget extends StatelessWidget {
  final Room room;

  const RoomBackgroundWidget({
    Key? key,
    required this.room,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) => Image.asset(
        room.renderSettings?.asset ?? room.defaultAssetPath,
        height: room.renderSettings?.height,
        width: room.renderSettings?.width,
        errorBuilder: RenderSettingsStackWidget.getImageErrorWidgetBuilder(room.renderSettings),
      );
}
