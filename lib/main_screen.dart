import 'package:flutter/material.dart';
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
    _inputHandler = InputHandler();
    _gameLogic = GameLogic(_inputHandler.stream);
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
      body: _buildInputHandlerWidget(),
    );
  }

  Widget _buildInputHandlerWidget() {
    return KeyboardListener(
      focusNode: _inputHandler.focusNode,
      onKeyEvent: _inputHandler.handleKeyEvent,
      autofocus: true,
      child: GestureDetector(
        onTapDown: _inputHandler.handleTapDown,
        child: MouseRegion(
          onHover: _inputHandler.handleHover,
          child: _buildGameCanvas(),
        ),
      ),
    );
  }

  Widget _buildGameCanvas() {
    return ListenableBuilder(
      listenable: _gameLogic,
      builder: (context, _) {
        return CustomPaint(
          painter: Painter(_gameLogic.state),
          child: Container(),
        );
      },
    );
  }
}
