import 'package:flutter/material.dart';

// TODO: Kill this class and simply replace with Flutter framework?
abstract class InputEvent {}

enum InputEventKey { up, down, left, right }

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

class MouseEvent extends InputEvent {
  final Offset pos;
  MouseEvent(this.pos);
}

class MouseClickEvent extends MouseEvent {
  MouseClickEvent(super.pos);
}

class MouseMoveEvent extends MouseEvent {
  MouseMoveEvent(super.pos);
}

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
