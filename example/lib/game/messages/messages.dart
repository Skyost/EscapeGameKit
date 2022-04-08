/// The messages, shown in the [MessagesDialog].
class Messages {
  /// The message shown at the end.
  final TextMessageInfo endMessage = TextMessageInfo(
    author: 'DELAUNAY Hugo',
    title: 'Bug',
    date: DateTime.now(),
    text: "Apparently the audio file has made the computer of some of you completely crazy... Consequently the exam of tomorrow is cancelled, we will talk about it soon.\n\nHave a nice day.\nH. Delaunay",
    unread: true,
  );

  /// The glitch message.
  final MessageInfo glitchMessage = MessageInfo(
    author: 'DELAUNAY Hugo',
    title: 'Audio file',
    date: DateTime.now(),
    unread: true,
  );

  /// All text messages.
  final List<TextMessageInfo> textMessages = [
    TextMessageInfo(
      author: 'IT SERVICE',
      title: 'Warning',
      date: DateTime.now().subtract(const Duration(hours: 1)),
      unread: true,
      text: "The IT network is particularly unstable today.\nPlease be careful at what you're doing on it.\n\nBest regards.\nThe IT service",
    ),
    TextMessageInfo(
      author: 'DESJARDINS Nils',
      title: 'URGENT !!',
      date: DateTime(2022, 4, 5, 8, 24),
      text: "I've lost my bag, do you know where it is ?? 😭😭",
    ),
    TextMessageInfo(
      author: 'NABOT Axel',
      title: 'Work for tomorrow',
      date: DateTime(2022, 4, 4, 18, 47),
      text: "Hi !\n\nWhat do we have to do for tomorrow ?",
    ),
    TextMessageInfo(
      author: 'LEPTI Leo',
      title: 'Math exercise',
      date: DateTime(2022, 4, 4, 17, 59),
      text: "Hello\n\nI haven't understood the exercise about proportionality, can you help me please ? 🤓",
    ),
  ];
}

/// Contains some info about a message.
class MessageInfo {
  /// The author.
  final String author;

  /// The title.
  final String title;

  /// The date.
  DateTime date;

  /// Whether this message has been read or not.
  bool unread;

  /// Creates a new [MessageInfo] instance.
  MessageInfo({
    required this.author,
    required this.title,
    required this.date,
    this.unread = false,
  });
}

/// A [MessageInfo] that contains a [text].
class TextMessageInfo extends MessageInfo {
  /// The text.
  final String text;

  /// Creates a new [TextMessageInfo] instance.
  TextMessageInfo({
    required String author,
    required String title,
    required DateTime date,
    bool unread = false,
    required this.text,
  }) : super(
          author: author,
          title: title,
          date: date,
          unread: unread,
        );
}
