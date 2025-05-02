import 'dart:async';
import 'package:flutter/material.dart' hide KeyEvent;
import 'package:flutter/services.dart' hide KeyEvent;
import 'package:flutter/services.dart' as flutter show KeyEvent;
import 'input_event.dart' as internal;

// The name 'KeyEvent' is defined in the libraries
// 'package:empty_app/input_event.dart' and
// 'package:flutter/src/services/hardware_keyboard.dart
// (via package:flutter/services.dart)'.

class InputHandler {
  final FocusNode focusNode = FocusNode();
  // TODO: StreamController / StreamController.broadcast().
  // TODO: internal.InputEventBus? Another middle-man class, probably overkill.
  //       But that does go in the direction of my Event based system...
  //       (everything becomes an event).
  final _stream = StreamController<internal.InputEvent>.broadcast();

  Stream<internal.InputEvent> get stream => _stream.stream;

  InputHandler();

  void emit(internal.InputEvent event) {
    _stream.add(event);
  }

  // TODO(isandrk): When is dispose needed?
  void dispose() {
    _stream.close();
    focusNode.dispose();
  }

  void handleKeyEvent(flutter.KeyEvent event) {
    internal.InputEventKey? key;
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowUp:
        key = internal.InputEventKey.up;
      case LogicalKeyboardKey.arrowDown:
        key = internal.InputEventKey.down;
      case LogicalKeyboardKey.arrowLeft:
        key = internal.InputEventKey.left;
      case LogicalKeyboardKey.arrowRight:
        key = internal.InputEventKey.right;
    }
    // TODO: This is gonna blow on any other key.
    if (event is KeyDownEvent) {
      return emit(internal.KeyDownEvent(key!));
    } else {
      return emit(internal.KeyUpEvent(key!));
    }
  }

  void handleTapDown(TapDownDetails tap) {
    emit(internal.MouseClickEvent(tap.localPosition));
  }

  void handleHover(PointerHoverEvent pointer) {
    emit(internal.MouseMoveEvent(pointer.localPosition));
  }
}
