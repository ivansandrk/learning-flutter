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
  final GameState state = GameState();
  late Timer _timer;
  Input _input = Input();

  // TODO(isandrk): setState goes in the logic. or game state itself?
  // GameLogic(this.setState);
  GameLogic() {
    // Start the game loop.
    _timer = Timer.periodic(const Duration(milliseconds: 16), updateTimer);
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
      // TODO(isandrk): Update UI?
      // var newState = GameState(
      //   // bluePos: // TODO?
      // );
      // newState.bluePos.value = state.bluePos.value;
      // newState.redPos.value = state.redPos.value;
      // newState.bluePos.value = _input.tap!;
      // state = newState;
      // state.bluePos = newState.bluePos;
      state.bluePos.value = _input.tap!;
    }

    if (_input.hover != null) {
      // TODO(isandrk): Update UI?
      state.redPos.value = _input.hover!;
      // print('_input.hover: ${_input.hover!}');
    }

    //notifyListeners();
  }

  void moveBlue(Offset offset) {
    // TODO(isandrk): This needs to update UI somehow?
    // Could either be here, or in GameState.
    state.bluePos.value += offset;

    // setState(() => state.bluePos += offset);
    //notifyListeners();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
