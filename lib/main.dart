import 'package:drawing_unit/draw_view.dart';
import 'package:drawing_unit/open/example_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    const GetMaterialApp(
      home: DrawUnit(),
    ),
  );
}

class DrawUnit extends StatefulWidget {
  const DrawUnit({Key? key}) : super(key: key);

  @override
  _DrawUnitState createState() => _DrawUnitState();
}

class _DrawUnitState extends State<DrawUnit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Get.to(() => ExamplePage());
              },
              child: Container(
                width: 100,
                height: 100,
                color: Colors.yellow,
                child: Text('asdf'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
