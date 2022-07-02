import 'package:escape_game_kit/src/utils/properties_equatable.dart';
import 'package:flutter/material.dart';

/// Represents an in-game dialog.
class EscapeGameDialog<T> with PropertiesEquatable {
  /// The dialog title.
  final String? title;

  /// The dialog content.
  final T content;

  /// Creates a new [EscapeGameDialog] instance.
  const EscapeGameDialog({
    this.title,
    required this.content,
  });

  @override
  @protected
  List<Object?> get props => [title, content];
}
