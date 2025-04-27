import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const double blueSquareSize = 50;
const double redShapeSize = 10;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const MainScreen());
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  Offset bluePos = Offset(0, 0);
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
                    painter: SquarePainter(bluePos, redPos),
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

class SquarePainter extends CustomPainter {
  final Offset bluePos;
  final Offset? redPos;
  SquarePainter(this.bluePos, this.redPos);

  @override
  void paint(Canvas canvas, Size size) {
    final blue = Paint()..color = Colors.blue;
    final red = Paint()..color = Colors.red;

    final rect = Rect.fromCenter(
      center: bluePos,
      width: blueSquareSize,
      height: blueSquareSize,
    );
    canvas.drawRect(rect, blue);

    if (redPos != null) {
      canvas.drawCircle(redPos!, redShapeSize, red);
    }
  }

  @override
  bool shouldRepaint(covariant SquarePainter oldDelegate) {
    return oldDelegate.bluePos != bluePos || oldDelegate.redPos != redPos;
  }
}
