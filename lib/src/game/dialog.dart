import 'package:escape_game_kit/src/game/render/render_settings.dart';

class EscapeGameDialog {
  final String? title;
  final RenderSettings? imageRenderSettings;
  final String message;

  const EscapeGameDialog({
    this.title,
    this.imageRenderSettings,
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (other is! EscapeGameDialog) {
      return super == other;
    }
    return identical(this, other) || (title == other.title && imageRenderSettings == other.imageRenderSettings && message == other.message);
  }

  @override
  int get hashCode => title.hashCode + imageRenderSettings.hashCode + message.hashCode;
}
