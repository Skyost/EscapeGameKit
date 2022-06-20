import 'package:escape_game_kit/src/game/game.dart';
import 'package:escape_game_kit/src/game/room/room.dart';
import 'package:escape_game_kit/src/utils/countdown.dart';
import 'package:escape_game_kit/src/widgets/alert_dialog.dart';
import 'package:escape_game_kit/src/widgets/inventory/button.dart';
import 'package:escape_game_kit/src/widgets/render_settings.dart';
import 'package:escape_game_kit/src/widgets/room/room.dart';
import 'package:escape_game_kit/src/widgets/room_transition.dart';
import 'package:flutter/material.dart';

/// Allows to build a widget according to the specified [escapeGame].
typedef GameWidgetBuilder = Widget Function(BuildContext context, EscapeGame escapeGame);

/// Allows to render a specified [room].
typedef RoomWidgetBuilder = Widget Function(BuildContext context, EscapeGame escapeGame, Room room);

/// Should be triggered when the user tries to exit the current [escapeGame].
typedef TryExitCallback = Future<bool> Function(EscapeGame escapeGame);

/// Builds a [RoomTransition] according to the [previousRoom] and the [newRoom].
typedef RoomTransitionBuilder = RoomTransition Function(EscapeGame escapeGame, Room? previousRoom, Room newRoom);

/// The main widget, that allows to render an [escapeGame].
class EscapeGameWidget extends StatefulWidget {
  /// The [EscapeGame] instance.
  final EscapeGame escapeGame;

  /// Whether to start automatically the game.
  final bool autostart;

  /// Builds the widget that is rendered before the game start.
  final GameWidgetBuilder? beforeGameStartBuilder;

  /// Builds a widget that renders the [escapeGame.currentRoom].
  final RoomWidgetBuilder roomWidgetBuilder;

  /// Builds a widget that renders the [escapeGame.inventory].
  final GameWidgetBuilder inventoryWidgetBuilder;

  /// Builds a widget that renders the [escapeGame.countdown].
  final GameWidgetBuilder countdownWidgetBuilder;

  /// Builds the widget that is rendered after the game end.
  final GameWidgetBuilder? afterGameFinishedBuilder;

  /// Called when the user tried to exit the game.
  final TryExitCallback? onTryToExit;

  /// Allows to build the [RoomTransition] that corresponds to the current room and the previous room.
  final RoomTransitionBuilder roomTransitionBuilder;

  /// Creates a new [EscapeGameWidget] instance.
  const EscapeGameWidget({
    Key? key,
    required this.escapeGame,
    this.autostart = false,
    this.beforeGameStartBuilder,
    this.roomWidgetBuilder = defaultRoomWidgetBuilder,
    this.inventoryWidgetBuilder = defaultInventoryWidgetBuilder,
    this.countdownWidgetBuilder = defaultCountdownWidgetBuilder,
    this.afterGameFinishedBuilder,
    this.onTryToExit,
    this.roomTransitionBuilder = defaultRoomTransitionBuilder,
  }) : super(
          key: key,
        );

  @override
  State<StatefulWidget> createState() => _EscapeGameWidgetState();

  /// The default [Room] widget builder.
  static Widget defaultRoomWidgetBuilder(BuildContext context, EscapeGame escapeGame, Room room) => RoomWidget(
        escapeGame: escapeGame,
        room: room,
      );

  /// The default [Inventory] widget builder.
  static Widget defaultInventoryWidgetBuilder(BuildContext context, EscapeGame escapeGame) => InventoryButton(
        escapeGame: escapeGame,
      );

  /// The default [Countdown] widget builder.
  static Widget defaultCountdownWidgetBuilder(BuildContext context, EscapeGame escapeGame) => escapeGame.countdown == null
      ? const SizedBox.shrink()
      : Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          color: Colors.black54,
          child: CountdownWidget(
            countdown: escapeGame.countdown!,
            textStyle: const TextStyle(color: Colors.white),
          ),
        );

  /// The default [RoomTransition] builder.
  static RoomTransition defaultRoomTransitionBuilder(EscapeGame escapeGame, Room? previousRoom, Room newRoom) => const RoomTransition();
}

/// The [EscapeGameWidget] state.
class _EscapeGameWidgetState extends State<EscapeGameWidget> {
  /// The current room transition.
  RoomTransition roomTransition = const RoomTransition();

  /// Whether a dialog is opened.
  bool isDialogOpened = false;

  /// The current room to display.
  Room? currentRoom;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.autostart && !widget.escapeGame.isStarted) {
        widget.escapeGame.start();
      }
      refreshCurrentRoom();
      refreshDialog();
      widget.escapeGame.addListener(refreshCurrentRoom);
      widget.escapeGame.addListener(refreshDialog);
    });
  }

  @override
  void didUpdateWidget(covariant EscapeGameWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.escapeGame != widget.escapeGame || oldWidget.escapeGame.currentRoom != widget.escapeGame.currentRoom || oldWidget.escapeGame.openedDialog != widget.escapeGame.openedDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        refreshCurrentRoom();
        refreshDialog();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (!widget.escapeGame.isStarted && widget.beforeGameStartBuilder != null) {
      child = widget.beforeGameStartBuilder!(context, widget.escapeGame);
    } else if (widget.escapeGame.isFinished && widget.afterGameFinishedBuilder != null) {
      child = widget.afterGameFinishedBuilder!(context, widget.escapeGame);
    } else if (currentRoom != null) {
      child = widget.roomWidgetBuilder(context, widget.escapeGame, currentRoom!);

      if (widget.escapeGame.inventory.renderSettings != null) {
        child = Stack(
          key: ValueKey('stack-room-${currentRoom!.id}'),
          children: [
            child,
            RenderSettingsWidget(
              renderSettings: widget.escapeGame.inventory.renderSettings,
              child: widget.inventoryWidgetBuilder(context, widget.escapeGame),
            ),
            if (widget.escapeGame.countdown != null)
              RenderSettingsWidget(
                renderSettings: widget.escapeGame.countdown!.renderSettings,
                child: widget.countdownWidgetBuilder(context, widget.escapeGame),
              ),
          ],
        );
      }
    } else {
      child = const SizedBox.shrink();
    }

    return WillPopScope(
      onWillPop: widget.onTryToExit == null ? null : () => widget.onTryToExit!(widget.escapeGame),
      child: roomTransition.createAnimatedSwitch(child: child),
    );
  }

  @override
  void dispose() {
    widget.escapeGame.removeListener(refreshCurrentRoom);
    widget.escapeGame.removeListener(refreshDialog);
    super.dispose();
  }

  /// Refreshes the current dialog.
  Future<void> refreshDialog() async {
    if (mounted && widget.escapeGame.isDialogOpened && !isDialogOpened) {
      isDialogOpened = true;
      await showDialog(
        context: context,
        builder: (context) => EscapeGameAlertDialog.fromEscapeGameDialog(escapeGameDialog: widget.escapeGame.openedDialog!),
      );
      isDialogOpened = false;
      widget.escapeGame.closeDialog();
    }
  }

  /// Refreshes the current room.
  void refreshCurrentRoom() {
    if (mounted) {
      setState(() {
        roomTransition = widget.roomTransitionBuilder(widget.escapeGame, currentRoom, widget.escapeGame.currentRoom);
        currentRoom = widget.escapeGame.currentRoom;
      });
    }
  }
}
