import 'package:flutter/material.dart';

GestureDetector buildCurrentPath(BuildContext context) {
  return GestureDetector(
    onPanStart: (DragStartDetails details) {
      print('User started drawing');
      final box = context.findRenderObject() as RenderBox;
      final point = box.globalToLocal(details.globalPosition);
      print(point);
    },
    onPanUpdate: (DragUpdateDetails details) {
      final box = context.findRenderObject() as RenderBox;
      final point = box.globalToLocal(details.globalPosition);
      print(point);
    },
    onPanEnd: (DragEndDetails details) {
      print('User ended drawing');
    },
    child: RepaintBoundary(
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // CustomPaint widget will go here
      ),
    ),
  );
}

// // 사용자가 화면을 터치하고 손가락으로 화면 주위를 끌기 시작할 때 실행
// void onPanStart(DragStartDetails details) {
//   print('User started drawing');
//   final box = context.findRenderObject() as RenderBox;
//   final point = box.globalToLocal(details.globalPosition);
//   print(point);
// }
//
// // 사용자가 화면에서 손가락을 떼지 않고 화면에서 드래그하면 앱이 실행
// void onPanUpdate(DragUpdateDetails details) {
//   final box = context.findRenderObject() as RenderBox;
//   final point = box.globalToLocal(details.globalPosition);
//   print(point);
// }
//
// // 사용자가 화면에서 손가락을 떼면 실행
// void onPanEnd(DragEndDetails details) {
//   print('User ended drawing');
// }
