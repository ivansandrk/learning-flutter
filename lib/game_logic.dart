import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'input_event.dart';
import 'game_state.dart';

class GameLogic extends ChangeNotifier {
  // TODO: Update UI in GameState directly?
  //       GameState.setBlue() { blue = newBlue; notifyListeners(); }
  // GameLogic could be just one UpdateState pure function;
  // takes previous state and input and outputs next state.
  // (probably also needs time delta).
  // TODO: Here or one level up?
  final state = GameState();

  // Run the game loop on a ticker connected to vsync.
  late final Ticker _ticker;

  // Subscribe to input events, store them in a queue for later processing.
  late final StreamSubscription<InputEvent> _sub;
  final _events = Queue<InputEvent>();

  GameLogic(TickerProvider vsync, Stream<InputEvent> stream) {
    _ticker = vsync.createTicker(_onTick)..start();
    _sub = stream.listen((event) => _events.add(event));
  }

  @override
  void dispose() {
    _sub.cancel();
    _ticker.dispose();
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    while (_events.isNotEmpty) {
      final event = _events.removeFirst();
      _handleInputEvent(event);
    }
    notifyListeners();
  }

  void _handleInputEvent(InputEvent event) {
    // TODO: Can be switch?
    if (event is KeyDownEvent) {
      if (event.key == InputEventKey.up) _moveBlue(Offset(0, -10));
      if (event.key == InputEventKey.down) _moveBlue(Offset(0, 10));
      if (event.key == InputEventKey.left) _moveBlue(Offset(-10, 0));
      if (event.key == InputEventKey.right) _moveBlue(Offset(10, 0));
    }
    if (event is MouseClickEvent) {
      state.bluePos = event.pos;
    }
    if (event is MouseMoveEvent) {
      state.redPos = event.pos;
    }
    notifyListeners();
  }

  void _moveBlue(Offset offset) {
    state.bluePos += offset;
  }
}
