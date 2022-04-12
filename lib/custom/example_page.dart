import 'package:drawing_unit/custom/painter.dart';
import 'package:flutter/material.dart';
import 'package:drawing_unit/custom/utils/draw_bar.dart';
import 'PaintViewModel.dart';

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
    _controller.backgroundColor = Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello232 Flutter'),
        actions: [_action()],
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
          // IconButton(
          //     icon: const Icon(Icons.check),
          //     onPressed: () => _show(_controller.finish(), context)),
          const SizedBox(width: 10),
        ]
      ],
    );
  }

  // void _show(PictureDetails picture, BuildContext context) {
  //   setState(() {
  //     _finished = true;
  //   });
  //   Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (BuildContext context) {
  //     return Scaffold(
  //       appBar: AppBar(
  //         title: const Text('View your image'),
  //       ),
  //       body: Container(
  //           alignment: Alignment.center,
  //           child: FutureBuilder<Uint8List>(
  //             future: picture.toPNG(),
  //             builder:
  //                 (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
  //               switch (snapshot.connectionState) {
  //                 case ConnectionState.done:
  //                   if (snapshot.hasError) {
  //                     return Text('Error: ${snapshot.error}');
  //                   } else {
  //                     return Image.memory(snapshot.data);
  //                   }
  //                   break;
  //                 default:
  //                   return Container(
  //                       child: FractionallySizedBox(
  //                     widthFactor: 0.1,
  //                     child: const AspectRatio(
  //                         aspectRatio: 1.0, child: CircularProgressIndicator()),
  //                     alignment: Alignment.center,
  //                   ));
  //               }
  //             },
  //           )),
  //     );
  //   }));
  // }
}
