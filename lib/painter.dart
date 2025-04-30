import 'package:flutter/material.dart';
import 'game_state.dart';

const double blueSize = 40;
const double redSize = 18;
final Paint blueColor = Paint()..color = Colors.blue;
final Paint redColor = Paint()..color = Colors.red;

class Painter extends CustomPainter {
  final GameState state;
  Painter(this.state);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(state.bluePos, blueSize, blueColor);
    if (state.redPos != null) {
      canvas.drawCircle(state.redPos!, redSize, redColor);
    }
  }

  @override
  bool shouldRepaint(covariant Painter old) {
    // TODO: Comparing old and new state doesn't work properly.
    // return old.state != state;
    return true;
  }
}
