import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../models/snake_model.dart';

class GameRenderer {
  void drawBackground(Canvas canvas, Vector2 screenSize) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, screenSize.x, screenSize.y),
      Paint()..color = const Color(GameConstants.colorBackground),
    );
  }
  
  void drawBackgroundGradient(Canvas canvas, Vector2 screenSize) {
    final gradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(GameConstants.colorDark1),
        Color(GameConstants.colorDark2),
      ],
    );
    
    canvas.drawRect(
      Rect.fromLTWH(0, 0, screenSize.x, screenSize.y),
      Paint()..shader = gradient.createShader(
        Rect.fromLTWH(0, 0, screenSize.x, screenSize.y)
      ),
    );
  }
  
  void drawSnake(Canvas canvas, SnakeModel snake) {
    final paint = Paint()..color = const Color(GameConstants.colorSnake);
    for (final segment in snake.segments) {
      canvas.drawRect(
        Rect.fromLTWH(
          segment.x * GameConstants.gridSize,
          segment.y * GameConstants.gridSize,
          GameConstants.gridSize.toDouble(),
          GameConstants.gridSize.toDouble(),
        ),
        paint,
      );
    }
  }
  
  void drawFood(Canvas canvas, Vector2 food) {
    canvas.drawRect(
      Rect.fromLTWH(
        food.x * GameConstants.gridSize,
        food.y * GameConstants.gridSize,
        GameConstants.gridSize.toDouble(),
        GameConstants.gridSize.toDouble(),
      ),
      Paint()..color = const Color(GameConstants.colorFood),
    );
  }
}
