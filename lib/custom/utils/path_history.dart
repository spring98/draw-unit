import 'dart:ui';
import 'package:flutter/widgets.dart' hide Image;

class MyPathHistory {
  final List<MapEntry<Path, Paint>> _paths = [];
  final Paint _backgroundPaint = Paint();
  bool _inDrag = false;

  // controller 의 update paint() 에서 초기화
  // setDrawColor setBackgroundColor setThickness 이때 update paint() 호출
  late Paint currentPaint;

  void setBackgroundColor(Color backgroundColor) {
    _backgroundPaint.color = backgroundColor;
  }

  void undo() {
    if (!_inDrag) {
      _paths.removeLast();
    }
  }

  void clear() {
    if (!_inDrag) {
      _paths.clear();
    }
  }

  // GestureDetector onPanStart
  void add(Offset startPoint) {
    if (!_inDrag) {
      _inDrag = true;
      Path path = Path();
      path.moveTo(startPoint.dx, startPoint.dy);
      _paths.add(MapEntry<Path, Paint>(path, currentPaint));
    }
  }

  // GestureDetector _onPanUpdate
  void updateCurrent(Offset nextPoint) {
    if (_inDrag) {
      // 제일 마지막으로 저장된 path(위의 add 로 추가한 path)
      Path path = _paths.last.key;
      path.lineTo(nextPoint.dx, nextPoint.dy);
    }
  }

  // GestureDetector _onPanEnd
  void endCurrent() {
    _inDrag = false;
  }

  void draw(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromLTWH(0.0, 0.0, size.width, size.height), _backgroundPaint);
    for (MapEntry<Path, Paint> path in _paths) {
      canvas.drawPath(path.key, path.value);
    }
  }
}
