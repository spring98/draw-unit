import 'package:drawing_unit/custom/utils/painter_painter.dart';
import 'package:flutter/material.dart';
import 'PaintViewModel.dart';

class MyPainter extends StatefulWidget {
  final MyPainterController painterController;

  MyPainter(this.painterController)
      : super(key: ValueKey<MyPainterController>(painterController));

  @override
  _MyPainterState createState() => _MyPainterState();
}

class _MyPainterState extends State<MyPainter> {
  bool _finished = false;

  @override
  void initState() {
    super.initState();
    widget.painterController.widgetFinish = _finish;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: _child(),
      width: double.infinity,
      height: double.infinity,
    );
  }

  Widget _child() {
    Widget child = CustomPaint(
      willChange: true,
      painter: MyPainterPainter(widget.painterController.pathHistory,
          repaint: widget.painterController),
    );
    child = ClipRect(child: child);
    if (!_finished) {
      child = GestureDetector(
        child: child,
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
      );
    }
    return child;
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
    // print('🏻🏻');
    // print(pos);
  }

  void _onPanEnd(DragEndDetails end) {
    widget.painterController.pathHistory.endCurrent();
    widget.painterController.setNotifyListeners();
    // print('👇🏻');
    // print(context.size!);
  }

  Size _finish() {
    setState(() {
      _finished = true;
    });
    return context.size!;
  }
}
