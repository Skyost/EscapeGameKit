import 'package:escape_game_kit/src/game/dialog.dart';
import 'package:escape_game_kit/src/utils/auto_image.dart';
import 'package:escape_game_kit/src/widgets/render_settings_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class EscapeGameAlertDialog extends StatelessWidget {
  static const _contentPadding = EdgeInsets.fromLTRB(24, 20, 24, 24);

  final String? title;
  final String? empty;
  final EdgeInsets contentPadding;
  final List<Widget> children;
  final List<Widget>? actions;
  final Widget? bottom;

  const EscapeGameAlertDialog({
    Key? key,
    this.title,
    this.empty,
    this.contentPadding = _contentPadding,
    required this.children,
    this.actions,
    this.bottom,
  }) : super(
          key: key,
        );

  EscapeGameAlertDialog.oneChild({
    Key? key,
    String? title,
    EdgeInsets contentPadding = _contentPadding,
    required Widget child,
    List<Widget>? actions,
    Widget? bottom,
  }) : this(
          key: key,
          title: title,
          contentPadding: contentPadding,
          children: [child],
          actions: actions,
          bottom: bottom,
        );

  EscapeGameAlertDialog.fromEscapeGameDialog({
    Key? key,
    required EscapeGameDialog escapeGameDialog,
  }) : this(
          key: key,
          title: escapeGameDialog.title,
          children: [
            if (escapeGameDialog.imageRenderSettings?.asset != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: RenderSettingsStackWidget(
                  child: AutoImage(
                    asset: escapeGameDialog.imageRenderSettings!.asset!,
                    width: escapeGameDialog.imageRenderSettings!.width,
                    height: escapeGameDialog.imageRenderSettings!.height,
                  ),
                  renderSettings: escapeGameDialog.imageRenderSettings,
                ),
              ),
            HtmlWidget('<div align="center">${escapeGameDialog.message}</div>'),
          ],
          actions: [
            const EscapeGameAlertDialogCloseButton(cancel: false),
          ],
        );

  @override
  Widget build(BuildContext context) => AlertDialog(
        titlePadding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(),
        contentPadding: children.isEmpty ? contentPadding : EdgeInsets.zero,
        title: title == null
            ? null
            : Container(
                color: Theme.of(context).primaryColorDark,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: _createChildWidget(context),
        ),
        actions: actions,
      );

  Widget _createChildWidget(BuildContext context) {
    List<Widget> children = [];
    if (this.children.isEmpty && empty != null) {
      children.add(Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(
          empty!,
          style: const TextStyle(fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
      ));
    }

    children.addAll(this.children);

    if (bottom != null) {
      children.add(Padding(
        padding: const EdgeInsets.only(top: 10),
        child: bottom!,
      ));
    }

    return ListView(
      shrinkWrap: true,
      padding: contentPadding,
      children: children,
    );
  }
}

class EscapeGameAlertDialogNewTry extends StatelessWidget {
  final String text;

  const EscapeGameAlertDialogNewTry({
    Key? key,
    this.text = 'Oops, looks like you have to try again !',
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        textAlign: TextAlign.center,
      );
}

class EscapeGameAlertDialogOkButton<T> extends StatelessWidget {
  final VoidCallback? onPressed;

  const EscapeGameAlertDialogOkButton({
    Key? key,
    this.onPressed,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onPressed,
        child: Text(MaterialLocalizations.of(context).okButtonLabel.toUpperCase()),
      );
}

class EscapeGameAlertDialogCloseButton extends StatelessWidget {
  final bool cancel;

  const EscapeGameAlertDialogCloseButton({
    Key? key,
    this.cancel = true,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          (cancel ? MaterialLocalizations.of(context).cancelButtonLabel : MaterialLocalizations.of(context).closeButtonLabel).toUpperCase(),
        ),
      );
}
