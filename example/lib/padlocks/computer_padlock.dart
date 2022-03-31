import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:flutter/material.dart';

final ComputerPadlock computerPadlock = ComputerPadlock();

class ComputerPadlock extends ObjectEqualPadlock<String> {
  ComputerPadlock()
      : super(
          title: 'MSDOS Console',
        );

  @override
  bool isObjectValid(String object) => object == 'reboot now';
}

class ComputerPadlockDialog extends StatefulWidget {
  final ComputerPadlock padlock;

  const ComputerPadlockDialog({
    Key? key,
    required this.padlock,
  }) : super(
          key: key,
        );

  @override
  State<StatefulWidget> createState() => _ComputerPadlockkDialogState();

  static ComputerPadlockDialog builder(BuildContext context, Padlock padlock) => ComputerPadlockDialog(
        padlock: padlock as ComputerPadlock,
      );
}

class _ComputerPadlockkDialogState extends State<ComputerPadlockDialog> {
  static const kInvalidCommand = 'Invalid command. ';
  static const kSuccess = 'Success ! ';

  List<String> previouslyEnteredCommands = ['Starting MS-DOS...\n'];
  TextEditingController commandController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) => EscapeGameAlertDialog(
        title: widget.padlock.title,
        backgroundColor: Colors.black,
        scrollController: scrollController,
        children: [
          for (String command in previouslyEnteredCommands)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                command,
                style: TextStyle(
                  color: getTextColor(command),
                  fontFamily: 'SourceCodePro',
                ),
              ),
            ),
          TextField(
            controller: commandController,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'SourceCodePro',
            ),
            cursorColor: Colors.white,
            cursorHeight: 24,
            cursorWidth: 16,
            maxLength: 80,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(12),
              prefix: Text(
                'C:\\>',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'SourceCodePro',
                ),
              ),
            ),
            onSubmitted: (value) {
              value = value.trim();
              String response;
              if (widget.padlock.tryUnlock(value)) {
                // TODO
                response = kSuccess;
                Future.delayed(const Duration(seconds: 1)).then((_) => Navigator.pop(context));
              }
              else {
                response = kInvalidCommand;
              }
              setState(() {
                previouslyEnteredCommands.add('C:\\>$value');
                previouslyEnteredCommands.add(response);
              });
              Future.delayed(const Duration(milliseconds: 100)).then((_) => scrollController.position.jumpTo(scrollController.position.maxScrollExtent));
              commandController.clear();
            },
            maxLines: 1,
            autofocus: true,
          ),
        ],
      );

  @override
  void dispose() {
    commandController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Color getTextColor(String text) {
    if (text == kSuccess) {
      return Colors.green;
    }
    if( text == kInvalidCommand) {
      return Colors.red;
    }
    return Colors.white;
  }
}
