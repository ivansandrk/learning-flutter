import 'package:flutter/material.dart';

class Input {
  bool up = false;
  bool down = false;
  bool left = false;
  bool right = false;

  Offset? tap;
  Offset? hover;
}

// input_handler writes to input
// logic reads from input (and resets it?)
// TODO(isandrk): Or who resets input?
// Must be logic, when it processes and input event.
// InputHandler queues input events, logic processes them.
// Alternately, Input is turned into InputEvent, and processed one by one in
// GameLogic.

/**
 * class Event {}
 * class KeyDownEvent extends Event {}
 * class KeyUpEvent extends Event {}
 * class MouseMoveEvent extends Event {}
 * class MouseDownEvent extends Event {}
 * ... Copying the logic already in Flutter?
 * ... Might be a good exercise anyway, then 
 *     later remove code.
 */
