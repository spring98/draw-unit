import 'package:flutter/material.dart';

class MyPaint extends CustomPainter {
  final List<List<Offset>> pointss;
  final List<Offset> points;
  MyPaint({required this.pointss, required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    // List<Offset> point = this.point;
    // point.removeAt(0);

    // 1
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path prePath = Path();
    prePath.moveTo(points[0].dx, points[0].dy);
    for (int i = 0; i < points.length; i++) {
      prePath.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(prePath, paint);

    // for (int i = 0; i < pointss.length; i++) {
    //   Path path = Path();
    //
    //   path.moveTo(pointss[i][0].dx, pointss[i][0].dy);
    //   for (int j = 0; j < pointss[i].length; j++) {
    //     path.lineTo(pointss[i][j].dx, pointss[i][j].dy);
    //   }
    //   canvas.drawPath(path, paint);
    // }

    ///
    ///
    // path.moveTo(0, 250);
    // path.lineTo(100, 200);
    //
    // path.lineTo(150, 150);
    // path.lineTo(200, 50);
    //
    // Path path2 = Path();
    // path2.lineTo(250, 150);
    // path2.lineTo(300, 200);
    // path2.lineTo(size.width, 250);
    // path2.lineTo(0, 250);

    // // 4
    // path.moveTo(100, 100);
    // path.addOval(Rect.fromCircle(center: Offset(100, 100), radius: 25));

    // 5
    // canvas.drawPath(path, paint);
    // canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // throw UnimplementedError();
    return true;
  }
}
