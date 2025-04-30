import 'package:flutter/material.dart';

class GameState {
  final Offset bluePos;
  final Offset? redPos;

  const GameState(this.bluePos, this.redPos);

  GameState copyWith({Offset? bluePos, Offset? redPos}) {
    return GameState(
      // Usual Dartlang copy method.
      bluePos ?? this.bluePos,
      redPos ?? this.redPos,
    );
  }
}
