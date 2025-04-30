import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'input_event.dart';

class InputHandler {
  final FocusNode focusNode = FocusNode();
  // TODO: StreamController / StreamController.broadcast().
  // TODO: InputEventBus? Another middle-man class, probably overkill.
  //       But that does go in the direction of my Event based system...
  //       (everything becomes an event).
  final _stream = StreamController<InputEvent>.broadcast();

  Stream<InputEvent> get stream => _stream.stream;

  InputHandler();

  void emit(InputEvent event) {
    _stream.add(event);
  }

  // TODO(isandrk): When is dispose needed?
  void dispose() {
    _stream.close();
    focusNode.dispose();
  }

  void handleKeyEvent(KeyEvent event) {
    InputEventKey? key;
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowUp:
        key = InputEventKey.up;
      case LogicalKeyboardKey.arrowDown:
        key = InputEventKey.down;
      case LogicalKeyboardKey.arrowLeft:
        key = InputEventKey.left;
      case LogicalKeyboardKey.arrowRight:
        key = InputEventKey.right;
    }
    // TODO: This is gonna blow on any other key.
    if (event is KeyDownEvent) {
      return emit(KeyDownInputEvent(key!));
    } else {
      return emit(KeyUpInputEvent(key!));
    }
  }

  void handleTapDown(TapDownDetails tap) {
    emit(MouseClickInputEvent(tap.localPosition));
  }

  void handleHover(PointerHoverEvent pointer) {
    emit(MouseMoveInputEvent(pointer.localPosition));
  }
}
