import 'dart:async';
import 'dart:collection' show Queue;
import 'package:flutter/material.dart';
import 'input_event.dart';
import 'game_state.dart';

class GameLogic extends ChangeNotifier {
  // TODO: Update UI in GameState directly?
  //       GameState.setBlue() { blue = newBlue; notifyListeners(); }
  // GameLogic could be just one UpdateState pure function;
  // takes previous state and input and outputs next state.
  // (probably also needs time delta).
  // TODO(isandrk): Here or one level up?
  final state = GameState();

  late Timer _timer;

  late final StreamSubscription<InputEvent> _sub;
  var _events = Queue<InputEvent>();

  GameLogic(Stream<InputEvent> stream) {
    // Start the game loop.
    _timer = Timer.periodic(const Duration(milliseconds: 16), _update);

    // Subscribe to input events, store them in a queue for later processing.
    _sub = stream.listen((event) => _events.add(event));
  }

  @override
  void dispose() {
    _timer.cancel();
    _sub.cancel();
    super.dispose();
  }

  void _update(Timer timer) {
    while (_events.isNotEmpty) {
      final event = _events.removeFirst();
      handleInputEvent(event);
    }
    notifyListeners();
  }

  void handleInputEvent(InputEvent event) {
    // TODO: Can be switch?
    if (event is KeyDownInputEvent) {
      if (event.key == InputEventKey.up) _moveBlue(Offset(0, -10));
      if (event.key == InputEventKey.down) _moveBlue(Offset(0, 10));
      if (event.key == InputEventKey.left) _moveBlue(Offset(-10, 0));
      if (event.key == InputEventKey.right) _moveBlue(Offset(10, 0));
    }
    if (event is MouseClickInputEvent) {
      state.bluePos = event.pos;
    }
    if (event is MouseMoveInputEvent) {
      state.redPos = event.pos;
    }
    notifyListeners();
  }

  void _moveBlue(Offset offset) {
    state.bluePos += offset;
  }
}
