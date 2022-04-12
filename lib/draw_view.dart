// ignore_for_file: avoid_print

import 'package:drawing_unit/paint.dart';
import 'package:flutter/material.dart';

class Draw extends StatefulWidget {
  const Draw({Key? key}) : super(key: key);

  @override
  _DrawState createState() => _DrawState();
}

class _DrawState extends State<Draw> {
  double x = 0;
  double y = 0;
  List<List<Offset>> pointss = [];
  List<Offset> points = [];
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: buildCurrentPath(context),
      // Container(
      //   color: Colors.yellow,
      //   child: CustomPaint(
      //     painter: MyPaint(),
      //   ),
      // ),
    );
  }

  GestureDetector buildCurrentPath(BuildContext context) {
    return GestureDetector(
      onPanStart: (DragStartDetails details) {
        print('User started drawing');
        final box = context.findRenderObject() as RenderBox;
        final point = box.globalToLocal(details.globalPosition);
        print(point);

        ///
        setState(() {
          // pointss.add(points);
        });
      },
      onPanUpdate: (DragUpdateDetails details) {
        final box = context.findRenderObject() as RenderBox;
        final point = box.globalToLocal(details.globalPosition);
        // print('👇🏻');
        setState(() {
          x = point.dx;
          y = point.dy;
          points.add(point);
          // pointss[pointss.length + 1] = points;
        });
      },
      onPanEnd: (DragEndDetails details) {
        print('User ended drawing');
        setState(() {
          pointss.add(points);

          // points = [];
        });
      },
      child: RepaintBoundary(
        child: Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // CustomPaint widget will go here
          child: CustomPaint(
            painter: MyPaint(pointss: pointss, points: points),
            // painter: Sketcher(line: [line]),
          ),
        ),
      ),
    );
  }
}
