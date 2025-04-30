import 'dart:async';
import 'package:flutter/material.dart';
import 'input.dart';
import 'game_state.dart';

class GameLogic extends ChangeNotifier {
  // final void Function(VoidCallback) setState;

  // TODO(isandrk): Here or one level up?
  // GameLogic could be just one UpdateState pure function;
  // takes previous state and input and outputs next state.
  // (probably also needs time delta).
  // final bluePos = ValueNotifier<Offset>(Offset.zero);
  final state = GameState();
  late Timer _timer;
  Input _input = Input();

  // TODO(isandrk): setState goes in the logic. or game state itself?
  // GameLogic(this.setState);
  GameLogic() {
    // Start the game loop.
    _timer = Timer.periodic(const Duration(milliseconds: 16), updateTimer);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // TODO(isandrk): Game logic should be run every frame.
  void updateInput(Input input) {
    _input = input;
    // update();
  }

  void updateTimer(Timer timer) {
    update();
  }

  void update() {
    // Process input events.
    if (_input.up) moveBlue(Offset(0, -10));
    if (_input.down) moveBlue(Offset(0, 10));
    if (_input.left) moveBlue(Offset(-10, 0));
    if (_input.right) moveBlue(Offset(10, 0));

    if (_input.tap != null) {
      state.bluePos = _input.tap!;
    }

    if (_input.hover != null) {
      state.redPos = _input.hover!;
    }

    notifyListeners();
  }

  void moveBlue(Offset offset) {
    // TODO: Update UI in GameState directly?
    // GameState.setBlue() { blue = newBlue; notifyListeners(); }

    state.bluePos += offset;
  }
}
