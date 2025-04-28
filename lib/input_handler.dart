import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game_state.dart';

class InputHandler {
  final void Function(VoidCallback) setState;
  final FocusNode focusNode = FocusNode();
  // TODO(isandrk): Game state should be owned by logic? Or even one lvl above.
  GameState state = GameState();

  // TODO(isandrk): setState goes in the logic. or state itself?
  InputHandler(this.setState);

  void move(Offset offset) => setState(() => state.bluePos += offset);
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
    setState(() => state.bluePos = tap.localPosition);
  }

  void handleHover(PointerHoverEvent pointer) {
    setState(() => state.redPos = pointer.localPosition);
  }

  void dispose() {
    focusNode.dispose();
  }
}
