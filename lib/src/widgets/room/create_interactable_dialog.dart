import 'package:escape_game_kit/src/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateInteractableDialog extends StatefulWidget {
  final Rect translucentRectangle;

  const CreateInteractableDialog({
    Key? key,
    required this.translucentRectangle,
  }) : super(
          key: key,
        );

  @override
  State<StatefulWidget> createState() => _CreateInteractableDialogState();
}

class _CreateInteractableDialogState extends State<CreateInteractableDialog> {
  TextEditingController idController = TextEditingController();
  TextEditingController tooltipController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    idController.addListener(updateCode);
    tooltipController.addListener(updateCode);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      updateCode();
    });
  }

  @override
  Widget build(BuildContext context) => EscapeGameAlertDialog(
        title: 'Interactable creator',
        children: [
          const Text(
            'This dialog allows you to quickly create an Interactable object.',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          TextField(
            controller: idController,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              labelText: 'Identifier',
            ),
          ),
          TextField(
            controller: tooltipController,
            decoration: const InputDecoration(
              icon: Icon(Icons.info),
              labelText: 'Tooltip',
            ),
          ),
          TextField(
            controller: codeController,
            maxLines: null,
            decoration: const InputDecoration(
              icon: Icon(Icons.code),
              labelText: 'Code',
            ),
          ),
        ],
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: codeController.text));
              ScaffoldMessenger.maybeOf(context)?.showSnackBar(const SnackBar(
                content: Text('Done !'),
              ));
            },
            child: const Text('COPY TO CLIPBOARD'),
          ),
          const EscapeGameAlertDialogCloseButton(cancel: false),
        ],
      );

  @override
  void dispose() {
    idController.dispose();
    tooltipController.dispose();
    codeController.dispose();
    super.dispose();
  }

  void updateCode() {
    codeController.text = '''Interactable(
  id: ${buildDartString(idController)},
  renderSettings: const InteractableRenderSettings(
    top: ${widget.translucentRectangle.top.round()},
    left: ${widget.translucentRectangle.left.round()},
    height: ${widget.translucentRectangle.height.round()},
    width: ${widget.translucentRectangle.width.round()},
  ),$tooltipCode
),''';
  }

  String get tooltipCode => tooltipController.text.isEmpty ? '' : "\n  onTooltip: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: ${buildDartString(tooltipController)})),";

  String buildDartString(TextEditingController controller) => "'${controller.text.replaceAll("'", "\\'")}'";
}
