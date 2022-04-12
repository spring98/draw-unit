import 'package:drawing_unit/custom/utils/painter_painter.dart';
import 'package:flutter/material.dart';
import 'PaintController.dart';

class MyPainter extends StatefulWidget {
  final MyPainterController painterController;

  MyPainter(this.painterController)
      : super(key: ValueKey<MyPainterController>(painterController));

  @override
  _MyPainterState createState() => _MyPainterState();
}

class _MyPainterState extends State<MyPainter> {
  @override
  void initState() {
    super.initState();
    initSize();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GestureDetector(
        child: CustomPaint(
          willChange: true,
          painter: MyPainterPainter(widget.painterController.pathHistory,
              repaint: widget.painterController),
        ),
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
      ),
      width: double.infinity,
      height: double.infinity,
    );
  }

  void _onPanStart(DragStartDetails start) {
    Offset pos = (context.findRenderObject() as RenderBox)
        .globalToLocal(start.globalPosition);
    widget.painterController.pathHistory.add(pos);
    widget.painterController.setNotifyListeners();
  }

  void _onPanUpdate(DragUpdateDetails update) {
    Offset pos = (context.findRenderObject() as RenderBox)
        .globalToLocal(update.globalPosition);
    widget.painterController.pathHistory.updateCurrent(pos);
    widget.painterController.setNotifyListeners();
  }

  void _onPanEnd(DragEndDetails end) {
    widget.painterController.pathHistory.endCurrent();
    widget.painterController.setNotifyListeners();
  }

  // print('🏻👇🏻');
  void initSize() {
    widget.painterController.widgetFinish = () => context.size!;
  }
}
