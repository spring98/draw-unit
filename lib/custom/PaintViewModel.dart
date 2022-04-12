import 'dart:ui';

import 'package:drawing_unit/custom/painter.dart';
import 'package:drawing_unit/custom/utils/path_history.dart';
import 'package:flutter/material.dart';

class MyPainterController extends ChangeNotifier {
  Color _drawColor = const Color.fromARGB(255, 0, 0, 0);
  Color _backgroundColor = const Color.fromARGB(255, 255, 255, 255);

  double _thickness = 1.0;
  late PictureDetails _cached;
  late MyPathHistory pathHistory;
  late ValueGetter<Size> widgetFinish;

  MyPainterController() {
    pathHistory = MyPathHistory();
  }

  Color get drawColor => _drawColor;
  set drawColor(Color color) {
    _drawColor = color;
    _updatePaint();
  }

  Color get backgroundColor => _backgroundColor;
  set backgroundColor(Color color) {
    _backgroundColor = color;
    _updatePaint();
  }

  double get thickness => _thickness;
  set thickness(double t) {
    _thickness = t;
    _updatePaint();
  }

  void _updatePaint() {
    Paint paint = Paint();
    paint.color = drawColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = thickness;
    paint.strokeCap = StrokeCap.round;
    paint.strokeJoin = StrokeJoin.round;
    pathHistory.currentPaint = paint;
    pathHistory.setBackgroundColor(backgroundColor);
    notifyListeners();
  }

  void undo() {
    if (!isFinished()) {
      pathHistory.undo();
      notifyListeners();
    }
  }

  void setNotifyListeners() {
    notifyListeners();
  }

  void clear() {
    if (!isFinished()) {
      pathHistory.clear();
      notifyListeners();
    }
  }

  PictureDetails finish() {
    if (!isFinished()) {
      _cached = _render(widgetFinish());
    }
    return _cached;
  }

  PictureDetails _render(Size size) {
    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);
    pathHistory.draw(canvas, size);
    return PictureDetails(
        recorder.endRecording(), size.width.floor(), size.height.floor());
  }

  bool isFinished() {
    return _cached != null;
  }
}
