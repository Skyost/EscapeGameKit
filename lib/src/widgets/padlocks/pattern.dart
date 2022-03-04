import 'package:escape_game_kit/src/game/padlocks/padlock.dart';
import 'package:escape_game_kit/src/game/padlocks/pattern.dart';
import 'package:escape_game_kit/src/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';

/// Thanks [https://github.com/baothg/pattern_lock_screen_flutter/blob/master/lib/main.dart](`pattern_lock_screen_flutter`).
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
    double pointRadius = 20,
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
  Offset? offset;
  List<int> codes = [];
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
            child: CustomPaint(
              painter: _LockScreenPainter(
                color: Theme.of(context).primaryColorDark,
                codes: codes,
                offset: offset,
                onSelect: _onSelect,
              ),
              size: Size.square(MediaQuery.of(context).size.width),
            ),
            onPanStart: _onPanStart,
            onPanUpdate: _onPanUpdate,
            onPanEnd: _onPanEnd,
          ),
        ],
        bottom: isFirstTry ? null : const EscapeGameAlertDialogNewTry(),
        actions: const [EscapeGameAlertDialogCloseButton()],
      );

  void _onPanStart(DragStartDetails event) => _clearCodes();

  void _onPanUpdate(DragUpdateDetails event) => setState(() => offset = event.localPosition);

  void _onPanEnd(DragEndDetails event) {
    if (codes.isNotEmpty) {
      List<PatternCoordinate> coordinates = codes.map((index) => PatternCoordinate(x: index % widget.padlock.dimension, y: index ~/ widget.padlock.dimension)).toList();
      coordinates.forEach((coordinate) => print([coordinate.x, coordinate.y]));
      bool unlockResult = widget.padlock.tryUnlock(coordinates);
      if (unlockResult) {
        Navigator.pop(context);
      } else {
        setState(() => isFirstTry = false);
      }
    }
    setState(() {
      codes = [];
      offset = null;
    });
  }

  void _onSelect(int code) {
    if (codes.isEmpty || codes.last != code) {
      codes.add(code);
    }
  }

  void _clearCodes() => setState(() {
        codes = [];
        offset = null;
      });
}

class _LockScreenPainter extends CustomPainter {
  final int _total = 9;
  final int _col = 3;
  late Size size;

  final Color color;
  final List<int> codes;
  final Offset? offset;
  final Function(int code) onSelect;

  _LockScreenPainter({
    required this.color,
    required this.codes,
    this.offset,
    required this.onSelect,
  });

  double get _sizeCode => size.width / _col;

  Paint get _painter => Paint()
    ..color = Colors.white
    ..strokeWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    this.size = size;

    for (var i = 0; i < _total; i++) {
      var _offset = _getOffetByIndex(i);
      var _color = _getColorByIndex(i);

      var _radiusIn = _sizeCode / 2.0 * 0.2;
      _drawCircle(canvas, _offset, _radiusIn, _color, true);

      var _radiusOut = _sizeCode / 2.0 * 0.6;
      _drawCircle(canvas, _offset, _radiusOut, _color);

      var _pathGesture = _getCirclePath(_offset, _radiusOut);
      if (offset != null && _pathGesture.contains(offset!)) onSelect(i);
    }

    for (var i = 0; i < codes.length; i++) {
      var _start = _getOffetByIndex(codes[i]);
      if (i + 1 < codes.length) {
        var _end = _getOffetByIndex(codes[i + 1]);
        _drawLine(canvas, _start, _end);
      } else if (offset != null) {
        Offset _end = offset!;
        _drawLine(canvas, _start, _end);
      }
    }
  }

  Path _getCirclePath(Offset offset, double radius) {
    var _rect = Rect.fromCircle(radius: radius, center: offset);
    return Path()..addOval(_rect);
  }

  void _drawCircle(Canvas canvas, Offset offset, double radius, Color color, [bool isDot = false]) {
    var _path = _getCirclePath(offset, radius);
    var _painter = this._painter
      ..color = color
      ..style = isDot ? PaintingStyle.fill : PaintingStyle.stroke;
    canvas.drawPath(_path, _painter);
  }

  void _drawLine(Canvas canvas, Offset start, Offset end) {
    var _painter = this._painter
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;
    var _path = Path();
    _path.moveTo(start.dx, start.dy);
    _path.lineTo(end.dx, end.dy);
    canvas.drawPath(_path, _painter);
  }

  Color _getColorByIndex(int i) {
    return codes.contains(i) ? Colors.indigo : Colors.grey;
  }

  Offset _getOffetByIndex(int i) {
    var _dxCode = _sizeCode * (i % _col + .5);
    var _dyCode = _sizeCode * ((i / _col).floor() + .5);
    var _offsetCode = Offset(_dxCode, _dyCode);
    return _offsetCode;
  }

  @override
  bool shouldRepaint(_LockScreenPainter oldDelegate) {
    return offset != oldDelegate.offset;
  }
}
