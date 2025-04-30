import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_logic.dart';
import 'input_handler.dart';
import 'painter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late GameLogic _gameLogic;
  late InputHandler _inputHandler;

  @override
  void initState() {
    super.initState();
    _gameLogic = GameLogic();
    _inputHandler = InputHandler(_gameLogic);
  }

  @override
  void dispose() {
    _gameLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Move the Square')),
      body: KeyboardListener(
        focusNode: _inputHandler.focusNode,
        onKeyEvent: _inputHandler.handleKeyEvent,
        autofocus: true,
        child: GestureDetector(
          onTapDown: _inputHandler.handleTapDown,
          child: MouseRegion(
            onHover: _inputHandler.handleHover,
            child: Column(
              children: [
                Expanded(
                  child: ChangeNotifierProvider<GameLogic>.value(

                  )
                  
                  CustomPaint(
                    painter: Painter(_gameLogic.state),
                    child: Container(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _gameLogic.moveBlue(Offset(-10, 0)),
                      child: const Text('Left'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () => _gameLogic.moveBlue(Offset(10, 0)),
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
