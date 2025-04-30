import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'game_logic.dart';
import 'input.dart';

class InputHandler {
  Input input = Input();
  final GameLogic _gameLogic;
  final FocusNode focusNode = FocusNode();

  InputHandler(this._gameLogic);

  void handleKeyEvent(KeyEvent event) {
    input = Input();
    final isKeyDown = event is KeyDownEvent;
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowUp:
        input.up = isKeyDown;
      case LogicalKeyboardKey.arrowDown:
        input.down = isKeyDown;
      case LogicalKeyboardKey.arrowLeft:
        input.left = isKeyDown;
      case LogicalKeyboardKey.arrowRight:
        input.right = isKeyDown;
    }

    _gameLogic.updateInput(input);
  }

  void handleTapDown(TapDownDetails tap) {
    input = Input();
    input.tap = tap.localPosition;
    // setState(() => state.bluePos = tap.localPosition);

    _gameLogic.updateInput(input);
  }

  void handleHover(PointerHoverEvent pointer) {
    input = Input();
    input.hover = pointer.localPosition;
    // setState(() => state.redPos = pointer.localPosition);

    _gameLogic.updateInput(input);
  }

  // TODO(isandrk): When is dispose needed?
  void dispose() {
    focusNode.dispose();
  }
}
