import 'package:flutter/material.dart';

class GameState {
  final bluePos = ValueNotifier<Offset>(Offset.zero);
  final redPos = ValueNotifier<Offset?>(null);
}
