import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:escape_game_kit_example/game/messages/messages.dart';
import 'package:flutter/material.dart';

/// Allows to display a message.
class MessageWidget extends StatefulWidget {
  /// The message info.
  final MessageInfo messageInfo;

  /// The child widget.
  final Widget child;

  /// The close button.
  final Widget? closeButton;

  /// Creates a new [MessageWidget] instance.
  const MessageWidget({
    super.key,
    required this.messageInfo,
    required this.child,
    this.closeButton,
  });

  @override
  State<StatefulWidget> createState() => _MessageWidgetState();
}

/// The [MessageWidget] state.
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
              title: widget.messageInfo.title,
              actions: [
                widget.closeButton ??
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(MaterialLocalizations.of(context).closeButtonLabel.toUpperCase()),
                    ),
              ],
              child: widget.child,
            ),
          );
        },
      );

  /// Add a leading zero to the specified [number], if necessary.
  String addLeadingZero(int number) => number < 10 ? '0$number' : number.toString();
}

/// A widget that displays a [TextMessageInfo].
class TextMessageWidget extends MessageWidget {
  /// Creates a new [TextMessageWidget] instance.
  TextMessageWidget({
    super.key,
    required TextMessageInfo messageInfo,
    super.closeButton,
  }) : super(
          messageInfo: messageInfo,
          child: Text(messageInfo.text),
        );
}
