import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../PaintController.dart';

class ColorPickerButton extends StatefulWidget {
  final MyPainterController _controller;
  final bool _background;

  ColorPickerButton(this._controller, this._background);

  @override
  _ColorPickerButtonState createState() => _ColorPickerButtonState();
}

class _ColorPickerButtonState extends State<ColorPickerButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(getIconData(), color: getColor()),
        tooltip: widget._background
            ? 'Change background color'
            : 'Change draw color',
        onPressed: () {
          _pickColor();
        });
  }

  void _pickColor() {
    Color pickerColor = getColor();
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Pick color'),
            ),
            body: Container(
              alignment: Alignment.center,
              child: ColorPicker(
                pickerColor: pickerColor,
                onColorChanged: (Color c) => pickerColor = c,
              ),
            ),
          );
        },
      ),
    )
        .then((_) {
      setState(() {
        setColor(pickerColor);
      });
    });
  }

  Color getColor() {
    return widget._background
        ? widget._controller.getBackgroundColor()
        : widget._controller.getDrawColor();
  }

  IconData getIconData() {
    return widget._background ? Icons.format_color_fill : Icons.brush;
  }

  void setColor(Color color) {
    if (widget._background) {
      widget._controller.setBackgroundColor(color);
    } else {
      widget._controller.setDrawColor(color);
    }
  }
}
