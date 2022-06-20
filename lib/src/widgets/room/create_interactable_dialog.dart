import 'package:escape_game_kit/src/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A debug dialog that allows to easily create an [Interactable].
class CreateInteractableDialog extends StatefulWidget {
  /// Where to create the [Interactable].
  final Rect translucentRectangle;

  /// Creates a new [CreateInteractableDialog] instance.
  const CreateInteractableDialog({
    Key? key,
    required this.translucentRectangle,
  }) : super(
          key: key,
        );

  @override
  State<StatefulWidget> createState() => _CreateInteractableDialogState();

  /// Opens the dialog.
  static void openDialog(BuildContext context, {required Rect translucentRectangle}) => showDialog(
        context: context,
        builder: (context) => CreateInteractableDialog(
          translucentRectangle: translucentRectangle,
        ),
      );
}

/// The [CreateInteractableDialog] state.
class _CreateInteractableDialogState extends State<CreateInteractableDialog> {
  /// The id text editing controller.
  TextEditingController idController = TextEditingController();

  /// The tooltip text editing controller.
  TextEditingController tooltipController = TextEditingController();

  /// The code text editing controller.
  TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    idController.addListener(updateCode);
    tooltipController.addListener(updateCode);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      updateCode();
    });
  }

  @override
  Widget build(BuildContext context) => EscapeGameAlertDialog(
        title: 'Interactable creator',
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
      );

  @override
  void dispose() {
    idController.dispose();
    tooltipController.dispose();
    codeController.dispose();
    super.dispose();
  }

  /// Updates the code.
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

  /// Returns the tooltip code.
  String get tooltipCode => tooltipController.text.isEmpty ? '' : "\n  onHover: (escapeGame) => const ActionResult.success(object: InteractableTooltip(text: ${buildDartString(tooltipController)})),";

  /// Builds a Dart string, already escaped.
  String buildDartString(TextEditingController controller) => "'${controller.text.replaceAll("'", "\\'")}'";
}
