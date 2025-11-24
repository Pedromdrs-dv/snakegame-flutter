import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(GameWidget(game: SnakeGame()));
}

class SnakeGame extends FlameGame with KeyboardEvents {
  static const int gridSize = 20;
  static const double stepTime = 0.15;

  List<Vector2> snake = [Vector2(5, 5), Vector2(4, 5), Vector2(3, 5)];
  Vector2 food = Vector2(10, 10);
  Vector2 direction = Vector2(1, 0);
  double _timer = 0;
  final Random _rnd = Random();
  late Vector2 screenSize;

  @override
  Future<void> onLoad() async {
    screenSize = size;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _timer += dt;
    if (_timer > stepTime) {
      _moveSnake();
      _timer = 0;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _drawBackground(canvas);
    _drawFood(canvas);
    _drawSnake(canvas);
  }

  void _moveSnake() {
    var newHead = snake.first + direction;

    final cols = (screenSize.x / gridSize).floor();
    final rows = (screenSize.y / gridSize).floor();

    if (newHead.x < 0) {
      newHead.x = cols - 1.0;
    } else if (newHead.x >= cols) {
      newHead.x = 0;
    }

    if (newHead.y < 0) {
      newHead.y = rows - 1.0;
    } else if (newHead.y >= rows) {
      newHead.y = 0;
    }

    if (newHead == food) {
      snake.insert(0, newHead);
      _respawnFood();
    } else {
      snake.insert(0, newHead);
      snake.removeLast();
    }

    if (_checkCollision(newHead)) {
      _resetGame();
    }
  }

  bool _checkCollision(Vector2 head) {
    for (int i = 1; i < snake.length; i++) {
      if (head == snake[i]) return true;
    }
    return false;
  }

  void _respawnFood() {
    final cols = (screenSize.x / gridSize).floor();
    final rows = (screenSize.y / gridSize).floor();
    food = Vector2(_rnd.nextInt(cols).toDouble(), _rnd.nextInt(rows).toDouble());
  }

  void _resetGame() {
    snake = [Vector2(5, 5), Vector2(4, 5), Vector2(3, 5)];
    direction = Vector2(1, 0);
    _respawnFood();
  }

  void _drawBackground(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, screenSize.x, screenSize.y),
      Paint()..color = const Color(0xFF000000),
    );
  }

  void _drawFood(Canvas canvas) {
    canvas.drawRect(
      Rect.fromLTWH(
          food.x * gridSize, food.y * gridSize, gridSize.toDouble(), gridSize.toDouble()),
      Paint()..color = const Color(0xFFFF0000),
    );
  }

  void _drawSnake(Canvas canvas) {
    final paint = Paint()..color = const Color(0xFF00FF00);
    for (final segment in snake) {
      canvas.drawRect(
        Rect.fromLTWH(segment.x * gridSize, segment.y * gridSize, gridSize.toDouble(),
            gridSize.toDouble()),
        paint,
      );
    }
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is KeyDownEvent) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowUp) && direction.y == 0) {
        direction = Vector2(0, -1);
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown) && direction.y == 0) {
        direction = Vector2(0, 1);
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) && direction.x == 0) {
        direction = Vector2(-1, 0);
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight) && direction.x == 0) {
        direction = Vector2(1, 0);
      }
    }
    return KeyEventResult.handled;
  }
}