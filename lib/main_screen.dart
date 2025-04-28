import 'package:flutter/material.dart';
import 'input_handler.dart';
import 'painter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late InputHandler inputHandler;

  @override
  void initState() {
    super.initState();
    inputHandler = InputHandler(setState);
  }

  @override
  void dispose() {
    inputHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Move the Square')),
      body: KeyboardListener(
        focusNode: inputHandler.focusNode,
        onKeyEvent: inputHandler.handleKeyEvent,
        autofocus: true,
        child: GestureDetector(
          onTapDown: inputHandler.handleTapDown,
          child: MouseRegion(
            onHover: inputHandler.handleHover,
            child: Column(
              children: [
                Expanded(
                  child: CustomPaint(
                    painter: Painter(inputHandler.state),
                    child: Container(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: inputHandler.moveLeft,
                      child: const Text('Left'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: inputHandler.moveRight,
                      child: const Text('Right'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
