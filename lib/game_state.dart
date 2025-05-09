import 'package:flutter/material.dart';

class GameState {
  Offset bluePos = Offset.zero;
  Offset? redPos;

  GameState copy() {
    var newState = GameState();
    newState.bluePos = bluePos;
    newState.redPos = redPos;
    return newState;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameState && other.bluePos == bluePos && other.redPos == redPos;

  @override
  int get hashCode => Object.hash(bluePos, redPos);

  @override
  String toString() => 'GameState($bluePos, $redPos)';
}
