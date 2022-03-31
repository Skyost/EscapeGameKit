import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatefulWidget {
  final String author;
  final String title;
  final Widget child;
  final DateTime date;
  final bool unread;
  final Widget? closeButton;

  const MessageWidget({
    Key? key,
    required this.author,
    required this.title,
    required this.date,
    required this.child,
    this.unread = false,
    this.closeButton,
  }) : super(
          key: key,
        );

  @override
  State<StatefulWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  late bool unread;

  @override
  void initState() {
    super.initState();
    unread = widget.unread;
  }

  @override
  Widget build(BuildContext context) => ListTile(
        leading: Icon(
          unread ? Icons.mark_email_unread : Icons.email,
          color: unread ? Colors.redAccent : null,
        ),
        tileColor: unread ? Colors.black12 : null,
        trailing: Text(
          '${addLeadingZero(widget.date.day)}/${addLeadingZero(widget.date.month)}/${addLeadingZero(widget.date.year)} ${addLeadingZero(widget.date.hour)}:${addLeadingZero(widget.date.minute)}',
          style: const TextStyle(
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
        ),
        title: Text(widget.author),
        subtitle: Text(widget.title),
        onTap: () {
          setState(() => unread = false);
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => EscapeGameAlertDialog.oneChild(
              child: widget.child,
              actions: [
                widget.closeButton ??
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(MaterialLocalizations.of(context).closeButtonLabel.toUpperCase()),
                    ),
              ],
            ),
          );
        },
      );

  String addLeadingZero(int number) => number < 10 ? '0$number' : number.toString();
}

class TextMessageWidget extends MessageWidget {
  TextMessageWidget({
    Key? key,
    required String author,
    required String title,
    required DateTime date,
    required String text,
    bool unread = false,
    Widget? closeButton,
  }) : super(
          key: key,
          author: author,
          title: title,
          date: date,
          child: Text(text),
          unread: unread,
          closeButton: closeButton,
        );
}
