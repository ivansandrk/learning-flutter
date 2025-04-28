import 'package:flutter/material.dart';

const double blueSize = 40;
const double redSize = 18;
final Paint blueColor = Paint()..color = Colors.blue;
final Paint redColor = Paint()..color = Colors.red;

class Painter extends CustomPainter {
  final Offset bluePos;
  final Offset? redPos;
  Painter(this.bluePos, this.redPos);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(bluePos, blueSize, blueColor);
    if (redPos != null) {
      canvas.drawCircle(redPos!, redSize, redColor);
    }
  }

  @override
  bool shouldRepaint(covariant Painter old) {
    return old.bluePos != bluePos || old.redPos != redPos;
  }
}
