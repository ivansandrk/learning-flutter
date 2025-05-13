import 'package:test/test.dart';
import 'package:flutter/material.dart';
import 'package:learning_flutter/game_state.dart';

GameState _create(Offset bluePos, Offset? redPos) {
  var state = GameState();
  state.bluePos = bluePos;
  state.redPos = redPos;
  return state;
}

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
    final state = _create(Offset(-1, -2), Offset(10, 20));
    var copy = state.copy();
    expect(copy, isNot(same(state))); // Not same instance.
    expect(copy.bluePos, state.bluePos);
    expect(copy.redPos, state.redPos);
    copy.bluePos = Offset(-3, -4);
    copy.redPos = null;
    expect(copy.bluePos, isNot(state.bluePos));
    expect(copy.redPos, isNot(state.redPos));
  });

  test('Equality', () {
    final state = _create(Offset(-1, -2), Offset(10, 20));
    final equal = _create(Offset(-1, -2), Offset(10, 20));
    final notEqual = _create(Offset(1, 2), Offset(3, 4));
    expect(equal, state);
    expect(equal, isNot(same(state))); // Not same instance.
    expect(notEqual, isNot(state));
  });

  test('Hash', () {
    final state = _create(Offset(1, 2), Offset(3, 4));
    final sameHash = _create(Offset(1, 2), Offset(3, 4));
    final diffHash = _create(Offset(1, 2), null);
    expect(sameHash.hashCode, state.hashCode);
    expect(diffHash.hashCode, isNot(state.hashCode));
  });

  test('ToStr', () {
    final state = _create(Offset(1, 2), Offset(3, 4));
    final toStr =
        'GameState(bluePos: Offset(1.0, 2.0), redPos: Offset(3.0, 4.0))';
    expect(state.toString(), toStr);
  });
}
