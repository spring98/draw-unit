import 'dart:typed_data';
import 'dart:ui';
import 'package:drawing_unit/custom/painter.dart';
import 'package:drawing_unit/custom/utils/image_output.dart';
import 'package:flutter/material.dart';
import 'package:drawing_unit/custom/utils/draw_bar.dart';
import 'PaintController.dart';
import 'package:get/get.dart';

class MyExamplePage extends StatefulWidget {
  @override
  _MyExamplePageState createState() => _MyExamplePageState();
}

class _MyExamplePageState extends State<MyExamplePage> {
  bool _finished = false;
  MyPainterController _controller = MyPainterController();

  @override
  void initState() {
    super.initState();
    _controller.setBackgroundColor(Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello232 Flutter'),
        actions: [
          _action(),
        ],
        bottom: PreferredSize(
          child: DrawBar(_controller),
          preferredSize: Size(MediaQuery.of(context).size.width, 30.0),
        ),
      ),
      body: Center(
        child: MyPainter(_controller),
      ),
    );
  }

  Widget _action() {
    return Row(
      children: [
        if (_finished) ...[
          IconButton(
            icon: const Icon(Icons.content_copy),
            tooltip: 'New Painting',
            onPressed: () {
              setState(() {
                _finished = false;
                _controller = MyPainterController();
                _controller.setBackgroundColor(Colors.white);
              });
            },
          ),
        ] else ...[
          IconButton(
              icon: const Icon(Icons.undo),
              tooltip: 'Undo',
              onPressed: _controller.undo),
          IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Clear',
              onPressed: _controller.clear),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              Uint8List thumb = await _controller.finish()!.toImage();
              setState(() {
                _finished = true;
              });
              Get.to(() => ImageOutput(thumb: thumb));
            },
          ),
          const SizedBox(width: 10),
        ]
      ],
    );
  }
}

typedef PictureCallback = PictureDetails Function();

class PictureDetails {
  final Picture picture;
  final int width;
  final int height;

  const PictureDetails(this.picture, this.width, this.height);

  Future<Uint8List> toImage() async {
    var image = await picture.toImage(width, height);
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    return pngBytes;
  }
}
