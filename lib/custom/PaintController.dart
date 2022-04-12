import 'dart:ui';
import 'package:drawing_unit/custom/utils/path_history.dart';
import 'package:flutter/material.dart';
import 'package:drawing_unit/custom/example_page.dart';

class MyPainterController extends ChangeNotifier {
  Color _drawColor = const Color.fromARGB(255, 0, 0, 0);
  Color _backgroundColor = const Color.fromARGB(255, 255, 255, 255);

  double _thickness = 1.0;
  PictureDetails? _cached;
  final MyPathHistory pathHistory = MyPathHistory();

  // painter 에서 초기화 됨
  late ValueGetter<Size> widgetFinish;

  Color getDrawColor() {
    return _drawColor;
  }

  void setDrawColor(Color color) {
    _drawColor = color;
    _updatePaint();
  }

  Color getBackgroundColor() {
    return _backgroundColor;
  }

  void setBackgroundColor(Color color) {
    _backgroundColor = color;
    _updatePaint();
  }

  double getThickness() {
    return _thickness;
  }

  void setThickness(double t) {
    _thickness = t;
    _updatePaint();
  }

  void _updatePaint() {
    Paint paint = Paint();
    paint.color = getDrawColor();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = getThickness();
    paint.strokeCap = StrokeCap.round;
    paint.strokeJoin = StrokeJoin.round;
    pathHistory.currentPaint = paint;
    pathHistory.setBackgroundColor(getBackgroundColor());
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

  PictureDetails? finish() {
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
