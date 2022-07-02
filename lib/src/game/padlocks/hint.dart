/// The default title of a padlock hint.
const String kDefaultPadlockHintTitle = 'Hint';

/// Represents a padlock hint.
class PadlockHint {
  /// The hint title.
  final String title;

  /// The hint text.
  final String text;

  /// The minimum try count before being able to read this hint.
  final int minimumTriesBeforeShowing;

  /// Creates a new [PadlockHint] instance.
  const PadlockHint({
    this.title = kDefaultPadlockHintTitle,
    required this.text,
    required this.minimumTriesBeforeShowing,
  });
}
