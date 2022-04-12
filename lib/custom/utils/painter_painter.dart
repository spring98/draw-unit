import 'package:drawing_unit/custom/utils/path_history.dart';
import 'package:flutter/material.dart';

class MyPainterPainter extends CustomPainter {
  final MyPathHistory _path;

  MyPainterPainter(this._path, {required Listenable repaint})
      : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    _path.draw(canvas, size);
  }

  @override
  bool shouldRepaint(MyPainterPainter oldDelegate) {
    return true;
  }
}
