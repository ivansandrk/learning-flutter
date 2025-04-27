import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const double blueSquareSize = 50;
const double redShapeSize = 100;

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
  double x = blueSquareSize / 2;
  double y = blueSquareSize / 2;
  Offset? pointer;
  final FocusNode _focusNode = FocusNode();

  void moveLeft() => setState(() => x -= 10);
  void moveRight() => setState(() => x += 10);
  void moveUp() => setState(() => y -= 10);
  void moveDown() => setState(() => y += 10);

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
      x = tap.localPosition.dx;
      y = tap.localPosition.dy;
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
            onHover: (event) => setState(() => pointer = event.localPosition),
            child: Column(
              children: [
                Expanded(
                  child: CustomPaint(
                    painter: SquarePainter(x, y, pointer),
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
  final double x;
  final double y;
  final Offset? pointer;
  SquarePainter(this.x, this.y, this.pointer);

  @override
  void paint(Canvas canvas, Size size) {
    final blue = Paint()..color = Colors.blue;
    final red = Paint()..color = Colors.red;

    // TODO(isandrk): L - 50/2, T - 50/2 (to account for square size, position it by the middle).
    final left = x - blueSquareSize / 2; // size.width / 2 + x
    final top = y - blueSquareSize / 2; // size.height / 2 - y
    final width = blueSquareSize;
    final height = blueSquareSize;
    canvas.drawRect(Rect.fromLTWH(left, top, width, height), blue);

    if (pointer != null) {
      canvas.drawCircle(pointer!, redShapeSize, red);
    }
  }

  @override
  bool shouldRepaint(covariant SquarePainter oldDelegate) {
    return oldDelegate.x != x ||
        oldDelegate.y != y ||
        oldDelegate.pointer != pointer;
  }
}
