import 'package:escape_game_kit/src/game/render/render_settings.dart';
import 'package:escape_game_kit/src/utils/properties_equatable.dart';
import 'package:flutter/foundation.dart';

/// Represents an in-game dialog.
class EscapeGameDialog with PropertiesEquatable {
  /// The dialog title.
  final String? title;

  /// The dialog image render settings. Pass `null` to display no image.
  final RenderSettings? imageRenderSettings;

  /// The dialog message.
  final String message;

  /// Creates a new [EscapeGameDialog] instance.
  const EscapeGameDialog({
    this.title,
    this.imageRenderSettings,
    required this.message,
  });

  @override
  @protected
  List<Object?> get props => [title, imageRenderSettings, message];
}
