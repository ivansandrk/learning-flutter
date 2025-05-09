import 'package:test/test.dart';
import 'package:flutter/material.dart';
import 'package:learning_flutter/game_state.dart';

void main() {
  test('Constructor', () {
    final state = GameState();
    expect(state.bluePos, Offset.zero);
    expect(state.redPos, null);
  });

  test('Setting members', () {
    var state = GameState();
    state.bluePos = Offset(1, 2);
    state.redPos = Offset(3, 4);
    expect(state.bluePos, Offset(1, 2));
    expect(state.redPos, Offset(3, 4));
  });

  test('Copy', () {
    var state = GameState();
    state.bluePos = Offset(-1, -2);
    state.redPos = Offset(10, 20);
    var copy = state.copy();
    expect(copy, isNot(same(state)));
    expect(copy, state);
    expect(copy.bluePos, state.bluePos);
    expect(copy.redPos, state.redPos);
    copy.bluePos = Offset(-3, -4);
    copy.redPos = null;
    expect(copy, isNot(state));
    expect(copy.bluePos, isNot(state.bluePos));
    expect(copy.redPos, isNot(state.redPos));
  });

  // TODO: eq hash tostr tests
}

// class GameState {
//   Offset bluePos = Offset.zero;
//   Offset? redPos;

//   GameState copy() {
//     var newState = GameState();
//     newState.bluePos = bluePos;
//     newState.redPos = redPos;
//     return newState;
//   }

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is GameState && other.bluePos == bluePos && other.redPos == redPos;

//   @override
//   int get hashCode => Object.hash(bluePos, redPos);

//   @override
//   String toString() => 'GameState($bluePos, $redPos)';
// }
