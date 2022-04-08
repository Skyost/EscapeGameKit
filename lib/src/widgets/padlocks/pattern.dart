import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/padlocks/pattern.dart';
import 'package:escape_game_kit/src/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';

/// Allows to unlock a [PatternPadlock].
/// Thanks [https://github.com/baothg/pattern_lock_screen_flutter/blob/master/lib/main.dart](`pattern_lock_screen_flutter`).
class PatternPadlockDialog extends PadlockAlertDialog<PatternPadlock> {
  /// Padding of points area relative to distance between points.
  final double relativePadding;

  /// Color of selected points. `Theme.of(context).primaryColor` if null.
  final Color? selectedColor;

  /// Color of not selected points.
  final Color notSelectedColor;

  /// Whether show user's input and highlight selected points.
  final bool showInput;

  /// Whether fill points.
  final bool fillPoints;

  /// Creates a new [PatternPadlockDialog] instance.
  const PatternPadlockDialog({
    Key? key,
    required PatternPadlock padlock,
    this.relativePadding = 0.5,
    this.selectedColor,
    this.notSelectedColor = Colors.black45,
    this.showInput = true,
    this.fillPoints = false,
  }) : super(
          key: key,
          padlock: padlock,
        );

  @override
  State<StatefulWidget> createState() => _PatternPadlockDialogState();

  /// The [PatternPadlockDialog] builder.
  static PatternPadlockDialog builder(BuildContext context, Padlock padlock) => PatternPadlockDialog(
        padlock: padlock as PatternPadlock,
      );
}

/// The [PatternPadlockDialog] state.
class _PatternPadlockDialogState extends PadlockAlertDialogState<PatternPadlockDialog> {
  /// The current offset.
  Offset? offset;

  /// The current codes.
  List<int> codes = [];

  @override
  Widget build(BuildContext context) => EscapeGameAlertDialog(
        title: widget.padlock.title,
        children: [
          if (widget.padlock.unlockMessage != null)
            Text(
              widget.padlock.unlockMessage!,
              textAlign: TextAlign.center,
            ),
        ],
        bottom: isFirstTry ? null : EscapeGameAlertDialogPadlockNewTry(padlock: widget.padlock),
        actions: const [EscapeGameAlertDialogCloseButton()],
      );

  @override
  List<Widget> buildBody(BuildContext context) => [
        Center(
          child: GestureDetector(
            child: CustomPaint(
              painter: _PatternPainter(
                dimension: widget.padlock.dimension,
                codes: codes,
                offset: offset,
                onSelect: onSelect,
                relativePadding: widget.relativePadding,
                selectedColor: widget.selectedColor ?? Theme.of(context).primaryColor,
                notSelectedColor: widget.notSelectedColor,
                showInput: widget.showInput,
                fillPoints: widget.fillPoints,
              ),
              size: Size.square(MediaQuery.of(context).size.shortestSide / 2),
            ),
            onPanStart: onPanStart,
            onPanUpdate: onPanUpdate,
            onPanEnd: onPanEnd,
          ),
        ),
      ];

  @override
  dynamic getCode() => codes.map((index) => PatternCoordinate(x: index % widget.padlock.dimension, y: index ~/ widget.padlock.dimension)).toList();

  @override
  List<Widget> buildActions(BuildContext context) => const [EscapeGameAlertDialogCloseButton()];

  /// Triggered when the pan starts.
  void onPanStart(DragStartDetails event) => clearCodes();

  /// Triggered when the pan updates.
  void onPanUpdate(DragUpdateDetails event) => setState(() => offset = event.localPosition);

  /// Triggered when the pan ends.
  void onPanEnd(DragEndDetails event) {
    if (codes.isNotEmpty) {
      tryUnlock();
    }
    setState(() {
      codes = [];
      offset = null;
    });
  }

  /// Triggered when a [code] is selected.
  void onSelect(int code) {
    if (codes.isEmpty || codes.last != code) {
      codes.add(code);
    }
  }

  /// Allows to clear currently selected codes.
  void clearCodes() {
    setState(() {
      codes = [];
      offset = null;
    });
  }
}

/// Allows to paint the pattern.
class _PatternPainter extends CustomPainter {
  /// The canvas size.
  late Size size;

  /// The padlock dimension.
  final int dimension;

  /// The selected codes.
  final List<int> codes;

  /// The current offset.
  final Offset? offset;

  /// Triggered when a code has been selected.
  final Function(int code) onSelect;

  /// Padding of points area relative to distance between points.
  final double relativePadding;

  /// Color of selected points. `Theme.of(context).primaryColor` if null.
  final Color selectedColor;

  /// Color of not selected points.
  final Color notSelectedColor;

  /// Whether show user's input and highlight selected points.
  final bool showInput;

  /// Whether fill points.
  final bool fillPoints;

  /// Creates a new [_PatternPainter] instance.
  _PatternPainter({
    required this.dimension,
    required this.codes,
    this.offset,
    required this.onSelect,
    required this.relativePadding,
    required this.selectedColor,
    required this.notSelectedColor,
    required this.showInput,
    required this.fillPoints,
  });

  /// Returns the total dots count.
  int get total => dimension ^ 2;

  /// Returns the column count.
  int get columns => dimension;

  /// Returns the size code.
  double get sizeCode => size.width / columns;

  /// Creates a new [Paint] instance.
  Paint get painter => Paint()
    ..color = Colors.white
    ..strokeWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    this.size = Size.square(size.shortestSide);

    for (int i = 0; i < total; i++) {
      Offset offset = getOffsetByIndex(i);
      Color color = getColorByIndex(i);

      double radiusIn = sizeCode / 2.0 * 0.2;
      drawCircle(canvas, offset, radiusIn, color, true);

      double radiusOut = sizeCode / 2.0 * 0.6;
      drawCircle(canvas, offset, radiusOut, color);

      Path pathGesture = getCirclePath(offset, radiusOut);
      if (pathGesture.contains(offset)) {
        onSelect(i);
      }
    }

    if (showInput) {
      for (int i = 0; i < codes.length; i++) {
        Offset start = getOffsetByIndex(codes[i]);
        if (i + 1 < codes.length) {
          Offset end = getOffsetByIndex(codes[i + 1]);
          drawLine(canvas, start, end);
        } else if (offset != null) {
          Offset _end = offset!;
          drawLine(canvas, start, _end);
        }
      }
    }
  }

  /// Returns a circle path.
  Path getCirclePath(Offset offset, double radius) => Path()..addOval(Rect.fromCircle(radius: radius, center: offset));

  /// Draws a circle.
  void drawCircle(Canvas canvas, Offset offset, double radius, Color color, [bool isDot = false]) {
    Path path = getCirclePath(offset, radius);
    Paint painter = this.painter
      ..color = color
      ..style = isDot && fillPoints ? PaintingStyle.fill : PaintingStyle.stroke;
    canvas.drawPath(path, painter);
  }

  /// Draws a line.
  void drawLine(Canvas canvas, Offset start, Offset end) {
    Paint painter = this.painter
      ..color = selectedColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;
    Path path = Path();
    path.moveTo(start.dx, start.dy);
    path.lineTo(end.dx, end.dy);
    canvas.drawPath(path, painter);
  }

  /// Returns the color associated to the specified index.
  Color getColorByIndex(int i) => codes.contains(i) && showInput ? selectedColor : notSelectedColor;

  /// Returns the offset associated to the specified index.
  Offset getOffsetByIndex(int i) {
    double dxCode = sizeCode * (i % columns + relativePadding);
    double dyCode = sizeCode * ((i / columns).floor() + relativePadding);
    return Offset(dxCode, dyCode);
  }

  @override
  bool shouldRepaint(_PatternPainter oldDelegate) => offset != oldDelegate.offset;
}
