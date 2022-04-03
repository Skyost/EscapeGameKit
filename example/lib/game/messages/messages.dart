class Messages {
  final TextMessageInfo endMessage = TextMessageInfo(
    author: 'DELAUNAY Hugo',
    title: 'Bug',
    date: DateTime.now(),
    text: "Il paraît que le fichier a fait planter l'ordinateur de certains d'entre-vous... En conséquence l'évaluation de demain est annulée, nous en reparlerons plus tard."
  );

  final MessageInfo glitchMessage = MessageInfo(
    author: 'DELAUNAY Hugo',
    title: 'Fichier audio',
    date: DateTime.now(),
    unread: true,
  );

  final List<TextMessageInfo> textMessages = [
    TextMessageInfo(
      author: 'SERVICE INFORMATIQUE',
      title: 'Attention',
      date: DateTime.now().subtract(const Duration(hours: 1)),
      unread: true,
      text: "Le réseau informatique du collège est très instable aujourd'hui.\nVous êtes donc priés de faire attention à ce que vous faîtes dessus.\n\nBien cordialement.\nLe service informatique",
    ),
    TextMessageInfo(
      author: 'DESPREZ Jean',
      title: 'URGENT !!',
      date: DateTime(2022, 4, 6, 8, 24),
      text: "J'ai perdu mon sac, tu saurais pas où il est ?? 😭😭",
    ),
    TextMessageInfo(
      author: 'AUBIN Alix',
      title: 'Leçons pour demain',
      date: DateTime(2022, 4, 5, 18, 47),
      text: "Salut !\n\nC'est quoi le travail à faire pour demain ?",
    ),
    TextMessageInfo(
      author: 'PITEL Noé',
      title: 'Exo de math',
      date: DateTime(2022, 4, 5, 17, 59),
      text: "Hello\n\nJ'ai pas compris l'exo sur la proportionnalité de ce matin, tu pourrais me donner un coup de main ? 🤓",
    ),
  ];
}

class MessageInfo {
  final String author;
  final String title;
  DateTime date;
  bool unread;

  MessageInfo({
    required this.author,
    required this.title,
    required this.date,
    this.unread = false,
  });
}

class TextMessageInfo extends MessageInfo {
  final String text;

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