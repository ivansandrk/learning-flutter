import 'dart:async';
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
  late final Stream<InputEvent> _stream;

  GameLogic(Stream<InputEvent> stream) {
    // TODO: Having a queue here to collect the events would be nice, so they
    // could be processed when the GameLogic would normally be run by the timer.
    _sub = stream.listen(handleInputEvent);
    // _sub.pause();
    // _stream = stream;
    // Start the game loop.
    _timer = Timer.periodic(const Duration(milliseconds: 16), update);
  }

  @override
  void dispose() {
    _timer.cancel();
    _sub.cancel();
    super.dispose();
  }

  void handleInputEvent(InputEvent event) {
    // TODO: Can be switch?
    if (event is KeyDownInputEvent) {
      if (event.key == InputEventKey.up) moveBlue(Offset(0, -10));
      if (event.key == InputEventKey.down) moveBlue(Offset(0, 10));
      if (event.key == InputEventKey.left) moveBlue(Offset(-10, 0));
      if (event.key == InputEventKey.right) moveBlue(Offset(10, 0));
    }
    if (event is MouseClickInputEvent) {
      state.bluePos = event.pos;
    }
    if (event is MouseMoveInputEvent) {
      state.redPos = event.pos;
    }
    notifyListeners();
  }

  void update(Timer timer) {
    // _sub = _stream.listen(handleInputEvent);
    // _sub.cancel();
    // notifyListeners();
    _sub.resume();
    Future.microtask(_sub.pause);
  }

  void moveBlue(Offset offset) {
    state.bluePos += offset;
  }
}
