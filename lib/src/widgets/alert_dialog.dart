import 'package:escape_game_kit/src/game/dialog.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/utils/auto_image.dart';
import 'package:escape_game_kit/src/widgets/render_settings_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class EscapeGameAlertDialog extends StatelessWidget {
  static const _contentPadding = EdgeInsets.fromLTRB(24, 20, 24, 24);

  final String? title;
  final String? empty;
  final Color? backgroundColor;
  final EdgeInsets contentPadding;
  final List<Widget> children;
  final List<Widget>? actions;
  final Widget? bottom;
  final ScrollController? scrollController;

  const EscapeGameAlertDialog({
    Key? key,
    this.title,
    this.empty,
    this.backgroundColor,
    this.contentPadding = _contentPadding,
    required this.children,
    this.actions,
    this.bottom,
    this.scrollController,
  }) : super(
          key: key,
        );

  EscapeGameAlertDialog.oneChild({
    Key? key,
    String? title,
    Color? backgroundColor,
    EdgeInsets contentPadding = _contentPadding,
    required Widget child,
    List<Widget>? actions,
    Widget? bottom,
    ScrollController? scrollController,
  }) : this(
          key: key,
          title: title,
          backgroundColor: backgroundColor,
          contentPadding: contentPadding,
          children: [child],
          actions: actions,
          bottom: bottom,
          scrollController: scrollController,
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
        backgroundColor: backgroundColor,
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
      controller: scrollController,
      padding: contentPadding,
      children: children,
    );
  }
}

class EscapeGameAlertDialogPadlockNewTry extends StatelessWidget {
  final Padlock? padlock;

  const EscapeGameAlertDialogPadlockNewTry({
    Key? key,
    this.padlock,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) => Text(
        padlock?.failedToUnlockMessage ?? kDefaultFailedToUnlockMessage,
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

abstract class PadlockAlertDialog<T extends Padlock> extends StatefulWidget {
  final T padlock;

  const PadlockAlertDialog({
    Key? key,
    required this.padlock,
  }) : super(
          key: key,
        );
}

abstract class PadlockAlertDialogState<T extends PadlockAlertDialog> extends State<T> {
  bool isFirstTry = true;

  @override
  Widget build(BuildContext context) => EscapeGameAlertDialog(
        title: widget.padlock.title,
        children: [
          if (widget.padlock.unlockMessage != null)
            Text(
              widget.padlock.unlockMessage!,
              textAlign: TextAlign.center,
            ),
          ...buildBody(context),
        ],
        bottom: buildBottom(context),
        actions: buildActions(context),
      );

  List<Widget> buildBody(BuildContext context);

  List<Widget> buildActions(BuildContext context) => [
        EscapeGameAlertDialogOkButton(onPressed: tryUnlock),
        const EscapeGameAlertDialogCloseButton(),
      ];

  Widget? buildBottom(BuildContext context) => isFirstTry ? null : EscapeGameAlertDialogPadlockNewTry(padlock: widget.padlock);

  dynamic getCode();

  void tryUnlock() {
    bool unlockResult = widget.padlock.tryUnlock(getCode());
    if (unlockResult) {
      Navigator.pop(context);
    } else {
      setState(() => isFirstTry = false);
    }
  }
}
