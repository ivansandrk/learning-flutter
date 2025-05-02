import 'package:flutter/material.dart';

abstract class InputEvent {}

enum InputEventKey { up, down, left, right }

// TODO: Combine KeyDown and KeyUp events.
// Lol that's exactly what Flutter framework does.

class KeyEvent extends InputEvent {
  final InputEventKey key;
  KeyEvent(this.key);
}

class KeyDownEvent extends KeyEvent {
  KeyDownEvent(super.key);
}

class KeyUpEvent extends KeyEvent {
  KeyUpEvent(super.key);
}

class MouseClickEvent extends InputEvent {
  final Offset pos;
  MouseClickEvent(this.pos);
}

class MouseMoveEvent extends InputEvent {
  final Offset pos;
  MouseMoveEvent(this.pos);
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
