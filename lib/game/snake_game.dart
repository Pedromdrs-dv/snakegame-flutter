import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/constants.dart';
import '../core/game_state.dart';
import '../models/snake_model.dart';
import '../utils/grid_helper.dart';
import '../components/renderers/game_renderer.dart';
import '../components/ui/menu_renderer.dart';

class SnakeGame extends FlameGame with KeyboardEvents {
  late SnakeModel snake;
  late Vector2 food;
  late Vector2 screenSize;
  
  GameState gameState = GameState.menu;
  int score = 0;
  int highScore = 0;
  double _timer = 0;
  
  final Random _rnd = Random();
  final GameRenderer _gameRenderer = GameRenderer();
  final MenuRenderer _menuRenderer = MenuRenderer();

  @override
  Future<void> onLoad() async {
    screenSize = size;
    snake = SnakeModel(
      segments: [Vector2(5, 5), Vector2(4, 5), Vector2(3, 5)],
      direction: Vector2(1, 0),
    );
    food = Vector2(10, 10);
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    if (gameState != GameState.playing) return;
    
    _timer += dt;
    if (_timer > GameConstants.stepTime) {
      _moveSnake();
      _timer = 0;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    
    if (gameState == GameState.menu) {
      _gameRenderer.drawBackgroundGradient(canvas, screenSize);
      _menuRenderer.drawMainMenu(canvas, screenSize, highScore);
    } else if (gameState == GameState.controls) {
      _gameRenderer.drawBackgroundGradient(canvas, screenSize);
      _menuRenderer.drawControlsScreen(canvas, screenSize);
    } else if (gameState == GameState.about) {
      _gameRenderer.drawBackgroundGradient(canvas, screenSize);
      _menuRenderer.drawAboutScreen(canvas, screenSize);
    } else if (gameState == GameState.playing) {
      _gameRenderer.drawBackground(canvas, screenSize);
      _gameRenderer.drawFood(canvas, food);
      _gameRenderer.drawSnake(canvas, snake);
      _menuRenderer.drawScore(canvas, screenSize, score, highScore);
    } else if (gameState == GameState.paused) {
      _gameRenderer.drawBackground(canvas, screenSize);
      _gameRenderer.drawFood(canvas, food);
      _gameRenderer.drawSnake(canvas, snake);
      _menuRenderer.drawScore(canvas, screenSize, score, highScore);
      _menuRenderer.drawPauseMenu(canvas, screenSize, score);
    } else if (gameState == GameState.gameOver) {
      _gameRenderer.drawBackground(canvas, screenSize);
      _gameRenderer.drawFood(canvas, food);
      _gameRenderer.drawSnake(canvas, snake);
      _menuRenderer.drawGameOver(canvas, screenSize, score, highScore);
    }
  }

  void _moveSnake() {
    var newHead = snake.head + snake.direction;
    newHead = GridHelper.wrapPosition(newHead, screenSize);

    final grow = newHead == food;
    
    if (grow) {
      score += GameConstants.pointsPerFood;
      _respawnFood();
    }
    
    snake.move(newHead, grow);

    if (snake.checkSelfCollision(newHead)) {
      gameState = GameState.gameOver;
      if (score > highScore) {
        highScore = score;
      }
    }
  }

  void _respawnFood() {
    final cols = GridHelper.getCols(screenSize);
    final rows = GridHelper.getRows(screenSize);
    food = Vector2(
      _rnd.nextInt(cols).toDouble(),
      _rnd.nextInt(rows).toDouble(),
    );
  }

  void _resetGame() {
    snake.reset();
    score = 0;
    _respawnFood();
    gameState = GameState.playing;
  }

  void _backToMenu() {
    if (score > highScore) {
      highScore = score;
    }
    snake.reset();
    score = 0;
    _respawnFood();
    gameState = GameState.menu;
  }

  @override
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is KeyDownEvent) {
      // ESC - Voltar ao menu ou navegar de volta
      if (keysPressed.contains(LogicalKeyboardKey.escape)) {
        if (gameState == GameState.playing || 
            gameState == GameState.paused || 
            gameState == GameState.gameOver) {
          _backToMenu();
          return KeyEventResult.handled;
        } else if (gameState == GameState.controls || 
                   gameState == GameState.about) {
          gameState = GameState.menu;
          return KeyEventResult.handled;
        }
      }
      
      // Navegação no menu principal
      if (gameState == GameState.menu) {
        if (keysPressed.contains(LogicalKeyboardKey.keyC)) {
          gameState = GameState.controls;
          return KeyEventResult.handled;
        } else if (keysPressed.contains(LogicalKeyboardKey.keyA)) {
          gameState = GameState.about;
          return KeyEventResult.handled;
        }
      }
      
      // P - Pausar/Despausar
      if (keysPressed.contains(LogicalKeyboardKey.keyP)) {
        if (gameState == GameState.playing) {
          gameState = GameState.paused;
          return KeyEventResult.handled;
        } else if (gameState == GameState.paused) {
          gameState = GameState.playing;
          return KeyEventResult.handled;
        }
      }
      
      // ESPAÇO - Iniciar/Reiniciar jogo
      if (keysPressed.contains(LogicalKeyboardKey.space)) {
        if (gameState == GameState.menu || gameState == GameState.gameOver) {
          _resetGame();
          return KeyEventResult.handled;
        }
      }
      
      // Controles durante o jogo
      if (gameState == GameState.playing) {
        if (keysPressed.contains(LogicalKeyboardKey.arrowUp) && snake.direction.y == 0) {
          snake.direction = Vector2(0, -1);
        } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown) && snake.direction.y == 0) {
          snake.direction = Vector2(0, 1);
        } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft) && snake.direction.x == 0) {
          snake.direction = Vector2(-1, 0);
        } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight) && snake.direction.x == 0) {
          snake.direction = Vector2(1, 0);
        }
      }
    }
    return KeyEventResult.handled;
  }
}
