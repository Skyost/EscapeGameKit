/// Represents a padlock hint.
class PadlockHint {
  /// The hint text.
  final String text;

  /// The minimum try count before being able to read this hint.
  final int minimumTriesBeforeShowing;

  /// Creates a new [PadlockHint] instance.
  const PadlockHint({
    required this.text,
    required this.minimumTriesBeforeShowing,
  });
}
