import 'package:flutter/material.dart';
import 'main_screen_controller.dart';
import 'main_screen_painter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late MainScreenController controller;

  @override
  void initState() {
    super.initState();
    controller = MainScreenController(setState);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Move the Square')),
      body: KeyboardListener(
        focusNode: controller.focusNode,
        onKeyEvent: controller.handleKeyEvent,
        autofocus: true,
        child: GestureDetector(
          onTapDown: controller.handleTapDown,
          child: MouseRegion(
            onHover: controller.handleHover,
            child: Column(
              children: [
                Expanded(
                  child: CustomPaint(
                    painter: MainScreenPainter(
                      controller.bluePos,
                      controller.redPos,
                    ),
                    child: Container(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: controller.moveLeft,
                      child: const Text('Left'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: controller.moveRight,
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
