import 'package:flutter/material.dart';
import 'main_screen.dart';

/// * main:
/// * screen:
///   * ?
/// * canvas:
///   * ?
/// * input:
///   * handling input (setting state)
/// * painter:
///   * drawing the snake on the canvas
/// * logic:
///   * handling input
///   * advancing game state
/// * state:
///   * input (like key up pressed, or touch/mouse click at xy)
///   * snake position

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MainScreen());
  }
}
