/// The default title of a padlock hint.
const String kDefaultPadlockHintTitle = 'Hint';

/// Represents a padlock hint.
class PadlockHint {
  /// The hint title.
  final String title;

  /// The hint text.
  final String text;

  /// Creates a new [PadlockHint] instance.
  const PadlockHint({
    this.title = kDefaultPadlockHintTitle,
    required this.text,
  });
}
