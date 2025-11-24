import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'game/snake_game.dart';

void main() {
  runApp(GameWidget(game: SnakeGame()));
}