import 'package:escape_game_kit/src/game/dialog.dart';
import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/padlocks/hint.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/utils/widget_factory_with_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

/// An [AlertDialog], built for escape games.
class EscapeGameAlertDialog extends StatelessWidget {
  /// The default content padding.
  static const _defaultContentPadding = EdgeInsets.fromLTRB(24, 20, 24, 24);

  /// The dialog title.
  final String? title;

  /// The text to show when [children.isEmpty] is `true`.
  final String? empty;

  /// The dialog background color.
  final Color? backgroundColor;

  /// The dialog content padding.
  final EdgeInsets contentPadding;

  /// The dialog children.
  final List<Widget> children;

  /// The dialog actions.
  final List<Widget>? actions;

  /// The bottom child.
  final Widget? bottom;

  /// The dialog scroll controller.
  final ScrollController? scrollController;

  /// Creates a new [EscapeGameAlertDialog] instance.
  const EscapeGameAlertDialog({
    super.key,
    this.title,
    this.empty,
    this.backgroundColor,
    this.contentPadding = _defaultContentPadding,
    required this.children,
    this.actions,
    this.bottom,
    this.scrollController,
  });

  /// Creates a new [EscapeGameAlertDialog] instance with only one [child].
  EscapeGameAlertDialog.oneChild({
    Key? key,
    String? title,
    Color? backgroundColor,
    EdgeInsets contentPadding = _defaultContentPadding,
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

  /// Creates a new [EscapeGameAlertDialog] instance from the specified [escapeGameDialog].
  EscapeGameAlertDialog.fromEscapeGameDialog({
    Key? key,
    required EscapeGameDialog escapeGameDialog,
  }) : this.oneChild(
          key: key,
          title: escapeGameDialog.title,
          child: escapeGameDialog.content is Widget
              ? escapeGameDialog.content
              : HtmlWidget(
                  '<div align="center">${escapeGameDialog.content}</div>',
                  factoryBuilder: WidgetFactoryWithSVG.new,
                ),
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

  /// Creates the child widget.
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

/// Allows to create an _OK_ button easily.
class EscapeGameAlertDialogOkButton<T> extends StatelessWidget {
  /// Triggered when pressed.
  final VoidCallback? onPressed;

  /// Creates a new [EscapeGameAlertDialogOkButton] instance.
  const EscapeGameAlertDialogOkButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onPressed,
        child: Text(MaterialLocalizations.of(context).okButtonLabel.toUpperCase()),
      );
}

/// Allows to create a _Close_ button easily.
class EscapeGameAlertDialogCloseButton extends StatelessWidget {
  /// Whether it is a cancel or a close button.
  final bool cancel;

  /// Creates a new [EscapeGameAlertDialogCloseButton] instance.
  const EscapeGameAlertDialogCloseButton({
    super.key,
    this.cancel = true,
  });

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          (cancel ? MaterialLocalizations.of(context).cancelButtonLabel : MaterialLocalizations.of(context).closeButtonLabel).toUpperCase(),
        ),
      );
}

/// Allows to easily create dialogs to unlock padlocks.
abstract class PadlockAlertDialog<T extends Padlock> extends StatefulWidget {
  /// The escape game instance.
  final EscapeGame escapeGame;

  /// The padlock.
  final T padlock;

  /// Creates a new [PadlockAlertDialog] instance.
  const PadlockAlertDialog({
    super.key,
    required this.escapeGame,
    required this.padlock,
  });
}

/// Base state for a [PadlockAlertDialog] widget.
abstract class PadlockAlertDialogState<T extends PadlockAlertDialog> extends State<T> {
  /// Whether this is the first try.
  int tryCount = 0;

  @override
  Widget build(BuildContext context) => EscapeGameAlertDialog(
        title: widget.padlock.title,
        bottom: buildBottom(context),
        actions: buildActions(context),
        children: [
          if (widget.padlock.unlockMessage != null)
            HtmlWidget(
              '<div align="center">${widget.padlock.unlockMessage!}</div>',
              factoryBuilder: WidgetFactoryWithSVG.new,
            ),
          ...buildBody(context),
        ],
      );

  /// Builds the dialog body.
  List<Widget> buildBody(BuildContext context);

  /// Creates the hint button.
  Widget createHintButton(BuildContext context, PadlockHint hint) => TextButton(
        onPressed: () => showHintDialog(hint),
        child: Text(hint.title.toUpperCase()),
      );

  /// Builds the dialog actions.
  List<Widget> buildActions(BuildContext context) {
    PadlockHint? hint = widget.padlock.hintBuilder?.call(widget.escapeGame, widget.padlock, tryCount);
    return [
      EscapeGameAlertDialogOkButton(onPressed: tryUnlock),
      const EscapeGameAlertDialogCloseButton(),
      if (hint != null)
        createHintButton(context, hint),
    ];
  }

  /// Builds the dialog bottom widget.
  Widget? buildBottom(BuildContext context) => isFirstTry ? null : EscapeGameAlertDialogPadlockNewTry(padlock: widget.padlock);

  /// Returns the entered code.
  dynamic getCode();

  /// Shows the hint dialog.
  void showHintDialog(PadlockHint hint, {String? dialogTitle}) {
    showDialog(
      context: context,
      builder: (context) => EscapeGameAlertDialog.oneChild(
        title: dialogTitle ?? hint.title,
        child: Text(
          hint.text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  /// Tries to unlock the padlock.
  void tryUnlock() {
    bool unlockResult = widget.padlock.tryUnlock(getCode());
    if (unlockResult) {
      Navigator.pop(context);
    } else {
      setState(() => tryCount++);
    }
  }

  /// Returns whether this is the first try.
  bool get isFirstTry => tryCount == 0;
}

/// Displays the [padlock.failedToUnlockMessage].
class EscapeGameAlertDialogPadlockNewTry extends StatelessWidget {
  /// The padlock.
  final Padlock? padlock;

  /// The text style.
  final TextStyle textStyle;

  /// The text align.
  final TextAlign textAlign;

  /// Creates a new [EscapeGameAlertDialogPadlockNewTry] instance.
  const EscapeGameAlertDialogPadlockNewTry({
    super.key,
    this.padlock,
    this.textStyle = const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) => padlock?.failedToUnlockMessage == null
      ? const SizedBox.shrink()
      : Text(
          padlock!.failedToUnlockMessage!,
          style: textStyle,
          textAlign: textAlign,
        );
}
