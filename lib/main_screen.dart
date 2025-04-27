import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main_screen_painter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  Offset bluePos = Offset.zero;
  Offset? redPos;
  final FocusNode _focusNode = FocusNode();

  void move(Offset offset) => setState(() => bluePos += offset);
  void moveLeft() => move(Offset(-10, 0));
  void moveRight() => move(Offset(10, 0));
  void moveUp() => move(Offset(0, -10));
  void moveDown() => move(Offset(0, 10));

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) {
      return;
    }
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        moveLeft();
      case LogicalKeyboardKey.arrowRight:
        moveRight();
      case LogicalKeyboardKey.arrowUp:
        moveUp();
      case LogicalKeyboardKey.arrowDown:
        moveDown();
    }
  }

  void _handleTapDown(TapDownDetails tap) {
    setState(() {
      bluePos = tap.localPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Move the Square')),
      body: KeyboardListener(
        focusNode: _focusNode,
        onKeyEvent: _handleKeyEvent,
        autofocus: true,
        child: GestureDetector(
          onTapDown: _handleTapDown,
          child: MouseRegion(
            onHover: (event) => setState(() => redPos = event.localPosition),
            child: Column(
              children: [
                Expanded(
                  child: CustomPaint(
                    painter: MainScreenPainter(bluePos, redPos),
                    child: Container(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: moveLeft,
                      child: const Text('Left'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: moveRight,
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
