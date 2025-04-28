import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputHandler {
  final void Function(VoidCallback) setState;
  Offset bluePos = Offset.zero;
  Offset? redPos;
  final FocusNode focusNode = FocusNode();

  InputHandler(this.setState);

  void move(Offset offset) => setState(() => bluePos += offset);
  void moveLeft() => move(Offset(-10, 0));
  void moveRight() => move(Offset(10, 0));
  void moveUp() => move(Offset(0, -10));
  void moveDown() => move(Offset(0, 10));

  void handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;

    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        moveLeft();
      case LogicalKeyboardKey.arrowRight:
        moveRight();
      case LogicalKeyboardKey.arrowUp:
        moveUp();
      case LogicalKeyboardKey.arrowDown:
        moveDown();
    }
  }

  void handleTapDown(TapDownDetails tap) {
    setState(() => bluePos = tap.localPosition);
  }

  void handleHover(PointerHoverEvent pointer) {
    setState(() => redPos = pointer.localPosition);
  }

  void dispose() {
    focusNode.dispose();
  }
}
