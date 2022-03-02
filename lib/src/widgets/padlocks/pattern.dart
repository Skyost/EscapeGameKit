import 'package:escape_game_kit/src/game/padlocks/credentials.dart';
import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/padlocks/pattern.dart';
import 'package:escape_game_kit/src/widgets/padlocks/alert_dialog.dart';
import 'package:flutter/material.dart';

/// Thanks [https://github.com/qwert2603/pattern_lock/blob/master/lib/src/pattern_lock.dart](`pattern_lock`).
class PatternPadlockDialog extends StatefulWidget {
  /// The pattern padlock.
  final PatternPadlock padlock;

  /// Padding of points area relative to distance between points.
  final double relativePadding;

  /// Color of selected points. `Theme.of(context).primaryColor` if null.
  final Color? selectedColor;

  /// Color of not selected points.
  final Color notSelectedColor;

  /// Radius of points.
  final double pointRadius;

  /// Whether show user's input and highlight selected points.
  final bool showInput;

  /// Needed distance from input to point to select point.
  final int selectThreshold;

  /// Whether fill points.
  final bool fillPoints;

  const PatternPadlockDialog({
    Key? key,
    required this.padlock,
    required this.relativePadding,
    this.selectedColor,
    required this.notSelectedColor,
    required this.pointRadius,
    required this.showInput,
    required this.selectThreshold,
    required this.fillPoints,
  }) : super(
          key: key,
        );

  @override
  State<StatefulWidget> createState() => _PatternPadlockDialogState();

  static PatternPadlockDialog builder(
    BuildContext context,
    Padlock padlock, {
    double relativePadding = 0.7,
    Color? selectedColor,
    Color notSelectedColor = Colors.black45,
    double pointRadius = 10,
    bool showInput = true,
    int selectThreshold = 25,
    bool fillPoints = false,
  }) =>
      PatternPadlockDialog(
        padlock: padlock as PatternPadlock,
        relativePadding: relativePadding,
        selectedColor: selectedColor,
        notSelectedColor: notSelectedColor,
        pointRadius: pointRadius,
        showInput: showInput,
        selectThreshold: selectThreshold,
        fillPoints: fillPoints,
      );
}

class _PatternPadlockDialogState extends State<PatternPadlockDialog> {
  List<int> used = [];
  Offset? currentPoint;
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
          GestureDetector(
            onPanEnd: (DragEndDetails details) {
              if (used.isNotEmpty) {
                List<PatternCoordinate> coordinates = used.map((index) => PatternCoordinate(x: index % widget.padlock.dimension, y: index ~/ widget.padlock.dimension)).toList();
                bool unlockResult = widget.padlock.tryUnlock(coordinates);
                if (unlockResult) {
                  Navigator.pop(context);
                } else {
                  setState(() => isFirstTry = false);
                }
              }
              setState(() {
                used = [];
                currentPoint = null;
              });
            },
            onPanUpdate: (DragUpdateDetails details) {
              RenderBox referenceBox = context.findRenderObject() as RenderBox;
              Offset localPosition = referenceBox.globalToLocal(details.globalPosition);

              Offset circlePosition(int n) => _LockPainter.calcCirclePosition(
                    n,
                    referenceBox.size,
                    widget.padlock.dimension,
                    widget.relativePadding,
                  );

              setState(() {
                currentPoint = localPosition;
                for (int i = 0; i < widget.padlock.dimension * widget.padlock.dimension; ++i) {
                  final toPoint = (circlePosition(i) - localPosition).distance;
                  if (!used.contains(i) && toPoint < widget.selectThreshold) {
                    used.add(i);
                  }
                }
              });
            },
            child: CustomPaint(
              painter: _LockPainter(
                dimension: widget.padlock.dimension,
                used: used,
                currentPoint: currentPoint,
                relativePadding: widget.relativePadding,
                selectedColor: widget.selectedColor ?? Theme.of(context).primaryColor,
                notSelectedColor: widget.notSelectedColor,
                pointRadius: widget.pointRadius,
                showInput: widget.showInput,
                fillPoints: widget.fillPoints,
              ),
              size: Size.infinite,
            ),
          ),
        ],
        bottom: isFirstTry ? null : const EscapeGameAlertDialogNewTry(),
        actions: const [EscapeGameAlertDialogCloseButton()],
      );
}

@immutable
class _LockPainter extends CustomPainter {
  final int dimension;
  final List<int> used;
  final Offset? currentPoint;
  final double relativePadding;
  final double pointRadius;
  final bool showInput;

  final Paint circlePaint;
  final Paint selectedPaint;

  _LockPainter({
    required this.dimension,
    required this.used,
    this.currentPoint,
    required this.relativePadding,
    required Color selectedColor,
    required Color notSelectedColor,
    required this.pointRadius,
    required this.showInput,
    required bool fillPoints,
  })  : circlePaint = Paint()
          ..color = notSelectedColor
          ..style = fillPoints ? PaintingStyle.fill : PaintingStyle.stroke
          ..strokeWidth = 2,
        selectedPaint = Paint()
          ..color = selectedColor
          ..style = fillPoints ? PaintingStyle.fill : PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 2;

  @override
  void paint(Canvas canvas, Size size) {
    Offset circlePosition(int n) => calcCirclePosition(n, size, dimension, relativePadding);

    for (int i = 0; i < dimension; ++i) {
      for (int j = 0; j < dimension; ++j) {
        canvas.drawCircle(
          circlePosition(i * dimension + j),
          pointRadius,
          showInput && used.contains(i * dimension + j) ? selectedPaint : circlePaint,
        );
      }
    }

    if (showInput) {
      for (int i = 0; i < used.length - 1; ++i) {
        canvas.drawLine(
          circlePosition(used[i]),
          circlePosition(used[i + 1]),
          selectedPaint,
        );
      }

      final currentPoint = this.currentPoint;
      if (used.isNotEmpty && currentPoint != null) {
        canvas.drawLine(
          circlePosition(used[used.length - 1]),
          currentPoint,
          selectedPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  static Offset calcCirclePosition(int n, Size size, int dimension, double relativePadding) {
    final o = size.width > size.height ? Offset((size.width - size.height) / 2, 0) : Offset(0, (size.height - size.width) / 2);
    return o +
        Offset(
          size.shortestSide / (dimension - 1 + relativePadding * 2) * (n % dimension + relativePadding),
          size.shortestSide / (dimension - 1 + relativePadding * 2) * (n ~/ dimension + relativePadding),
        );
  }
}
