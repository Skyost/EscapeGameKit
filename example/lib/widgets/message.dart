import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/game/messages/messages.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatefulWidget {
  final MessageInfo messageInfo;
  final Widget child;
  final Widget? closeButton;

  const MessageWidget({
    Key? key,
    required this.messageInfo,
    required this.child,
    this.closeButton,
  }) : super(
          key: key,
        );

  @override
  State<StatefulWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {

  @override
  Widget build(BuildContext context) => ListTile(
        leading: Icon(
          widget.messageInfo.unread ? Icons.mark_email_unread : Icons.email,
          color: widget.messageInfo.unread ? Colors.redAccent : null,
        ),
        tileColor: widget.messageInfo.unread ? Colors.black12 : null,
        trailing: Text(
          '${addLeadingZero(widget.messageInfo.date.day)}/${addLeadingZero(widget.messageInfo.date.month)}/${addLeadingZero(widget.messageInfo.date.year)} ${addLeadingZero(widget.messageInfo.date.hour)}:${addLeadingZero(widget.messageInfo.date.minute)}',
          style: const TextStyle(
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
        ),
        title: Text(widget.messageInfo.author),
        subtitle: Text(widget.messageInfo.title),
        onTap: () {
          setState(() => widget.messageInfo.unread = false);
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
    required TextMessageInfo messageInfo,
    Widget? closeButton,
  }) : super(
          key: key,
          messageInfo: messageInfo,
          child: Text(messageInfo.text),
          closeButton: closeButton,
        );
}
