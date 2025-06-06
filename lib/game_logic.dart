import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'input_event.dart';
import 'game_state.dart';

class GameLogic extends ChangeNotifier {
  // GameLogic could be just one UpdateState pure function;
  // takes previous state and input and outputs next state.
  // (probably also needs time delta).
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
    bool shouldNotifyListeners = _events.isNotEmpty;
    while (_events.isNotEmpty) {
      final event = _events.removeFirst();
      _handleInputEvent(event);
    }
    if (shouldNotifyListeners) notifyListeners();
  }

  void _handleInputEvent(InputEvent event) {
    switch (event) {
      case KeyDownEvent keyDown:
        switch (keyDown.key) {
          case InputEventKey.up:
            _moveBlue(Offset(0, -10));
          case InputEventKey.down:
            _moveBlue(Offset(0, 10));
          case InputEventKey.left:
            _moveBlue(Offset(-10, 0));
          case InputEventKey.right:
            _moveBlue(Offset(10, 0));
        }
      case MouseClickEvent mouseClick:
        state.bluePos = mouseClick.pos;
      case MouseMoveEvent mouseMove:
        state.redPos = mouseMove.pos;
    }
  }

  void _moveBlue(Offset offset) {
    state.bluePos += offset;
  }
}
