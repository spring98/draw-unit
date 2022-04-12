import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageOutput extends StatefulWidget {
  const ImageOutput({Key? key, required this.thumb}) : super(key: key);
  final Uint8List thumb;
  @override
  _ImageOutputState createState() => _ImageOutputState();
}

class _ImageOutputState extends State<ImageOutput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('전송할 이미지 미리보기'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(widget.thumb),
              ),
            ),
            width: 1000,
            height: 500,
          ),
        ],
      ),
    );
  }
}
