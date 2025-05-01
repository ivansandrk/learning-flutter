import 'package:flutter/material.dart';

abstract class InputEvent {}

enum InputEventKey { up, down, left, right }

// TODO: Combine KeyDown and KeyUp events.
// Lol that's exactly what Flutter framework does.
class KeyDownInputEvent extends InputEvent {
  final InputEventKey key;
  KeyDownInputEvent(this.key);
}

class KeyUpInputEvent extends InputEvent {
  final InputEventKey key;
  KeyUpInputEvent(this.key);
}

class MouseClickInputEvent extends InputEvent {
  final Offset pos;
  MouseClickInputEvent(this.pos);
}

class MouseMoveInputEvent extends InputEvent {
  final Offset pos;
  MouseMoveInputEvent(this.pos);
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
