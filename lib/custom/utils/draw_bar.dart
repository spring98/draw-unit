import 'package:flutter/material.dart';
import 'package:drawing_unit/custom/utils/color_picker_button.dart';
import '../PaintController.dart';

class DrawBar extends StatelessWidget {
  final MyPainterController _controller;

  DrawBar(this._controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                  child: Text(_controller.getThickness().toStringAsPrecision(2),
                      style: const TextStyle(color: Colors.white))),
              Flexible(
                child: Slider(
                  value: _controller.getThickness(),
                  onChanged: (double value) {
                    setState(() {
                      _controller.setThickness(value);
                    });
                  },
                  min: 1.0,
                  max: 20.0,
                  activeColor: Colors.white,
                ),
              ),
              ColorPickerButton(_controller, false),
              ColorPickerButton(_controller, true),
            ],
          );
        },
      ),
    );
  }
}
