import 'package:escape_game_kit/escape_game_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:just_audio/just_audio.dart' as audio;

/// A very special padlock that can be unlocked by entering a specific command.
class ComputerPadlock extends ObjectEqualPadlock<String> {
  ComputerPadlock()
      : super(
          title: 'MSDOS Console',
        );

  @override
  bool isObjectValid(String object) => object == 'reboot now';
}

/// Allows to unlock a [ComputerPadlock].
class ComputerPadlockDialog extends PadlockAlertDialog<ComputerPadlock> {
  /// Creates a new [ComputerPadlockDialog] instance.
  const ComputerPadlockDialog({
    super.key,
    required super.escapeGame,
    required super.padlock,
  });

  @override
  State<StatefulWidget> createState() => _ComputerPadlockkDialogState();

  /// The [ComputerPadlockDialog] builder.
  static ComputerPadlockDialog builder(BuildContext context, EscapeGame escapeGame, Padlock padlock) => ComputerPadlockDialog(
        escapeGame: escapeGame,
        padlock: padlock as ComputerPadlock,
      );
}

/// The [ComputerPadlockDialog] state.
class _ComputerPadlockkDialogState extends State<ComputerPadlockDialog> {
  /// Contains all previously entered commands.
  List<String> previouslyEnteredCommands = [
    commandToHtml('Starting MS-DOS...<br><br>', color: 'white'),
    commandToHtml('FATAL ERROR (1980)'),
    commandToHtml('Please restart system.<br><br>'),
  ];

  /// Whether the user has entered the good command.
  bool hasSucceeded = false;

  /// The command text editing focus node.
  late FocusNode commandFocus;

  /// The command text editing controller.
  TextEditingController commandController = TextEditingController();

  /// The current scroll controller.
  ScrollController scrollController = ScrollController();

  /// The glitch audio player.
  audio.AudioPlayer audioPlayer = audio.AudioPlayer();

  @override
  void initState() {
    super.initState();
    audioPlayer.setAsset('assets/glitch/noise.mp3');
    commandFocus = FocusNode();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () => Future.value(!hasSucceeded),
        child: GestureDetector(
          onTap: commandFocus.requestFocus,
          child: EscapeGameAlertDialog(
            title: widget.padlock.title,
            backgroundColor: Colors.black,
            scrollController: scrollController,
            children: [
              for (String command in previouslyEnteredCommands)
                HtmlWidget(
                  command,
                  textStyle: const TextStyle(fontFamily: 'SourceCodePro'),
                ),
              if (!hasSucceeded)
                TextField(
                  controller: commandController,
                  focusNode: commandFocus,
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
                    isDense: true,
                    // contentPadding: EdgeInsets.all(12),
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
                      response = commandToHtml('Command succeeded ! Please wait.<br><br>', color: '#4caf50');
                      setState(() => hasSucceeded = true);
                      onSuccess();
                    } else {
                      response = commandToHtml('Invalid command !<br><br>');
                    }
                    setState(() {
                      previouslyEnteredCommands.add(commandToHtml('C:\\>$value', color: 'white'));
                      previouslyEnteredCommands.add(response);
                    });
                    Future.delayed(const Duration(milliseconds: 100)).then((_) {
                      scrollController.position.jumpTo(scrollController.position.maxScrollExtent);
                      commandFocus.requestFocus();
                    });
                    commandController.clear();
                  },
                  maxLines: 1,
                  autofocus: true,
                ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    commandFocus.dispose();
    audioPlayer.dispose();
    commandController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  /// Converts a command to HTML.
  static String commandToHtml(String command, {String color = '#f44336'}) => '<p style="color: $color;">$command</p>';

  /// Triggered when the user has successfully unlocked this padlock.
  Future<void> onSuccess() async {
    audioPlayer.play();
    await Future.delayed(const Duration(seconds: 2));
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        contentPadding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(),
        content: Image.asset(
          'assets/glitch/image.webp',
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
    await Future.delayed(const Duration(seconds: 7));
    hasSucceeded = false;
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
