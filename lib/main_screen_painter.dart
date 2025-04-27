import 'package:flutter/material.dart';

const double blueSquareSize = 50;
const double redShapeSize = 10;

class MainScreenPainter extends CustomPainter {
  final Offset bluePos;
  final Offset? redPos;
  MainScreenPainter(this.bluePos, this.redPos);

  @override
  void paint(Canvas canvas, Size size) {
    final blue = Paint()..color = Colors.blue;
    final red = Paint()..color = Colors.red;

    final rect = Rect.fromCenter(
      center: bluePos,
      width: blueSquareSize,
      height: blueSquareSize,
    );
    canvas.drawRect(rect, blue);

    if (redPos != null) {
      canvas.drawCircle(redPos!, redShapeSize, red);
    }
  }

  @override
  bool shouldRepaint(covariant MainScreenPainter oldDelegate) {
    return oldDelegate.bluePos != bluePos || oldDelegate.redPos != redPos;
  }
}
