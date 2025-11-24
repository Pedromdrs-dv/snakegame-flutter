import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../../core/constants.dart';
import 'text_renderer.dart';

class MenuRenderer {
  final TextRenderer _textRenderer = TextRenderer();
  
  void drawMainMenu(Canvas canvas, Vector2 screenSize, int highScore) {
    _textRenderer.drawTextWithShadow(
      canvas,
      'SNAKE GAME',
      Offset(screenSize.x / 2, screenSize.y / 2 - 120),
      const TextStyle(
        color: Color(GameConstants.colorPrimary),
        fontSize: 56,
        fontWeight: FontWeight.bold,
        letterSpacing: 4,
      ),
      centered: true,
    );
    
    if (highScore > 0) {
      _textRenderer.drawTextWithShadow(
        canvas,
        'Recorde: $highScore',
        Offset(screenSize.x / 2, screenSize.y / 2 - 40),
        const TextStyle(
          color: Color(GameConstants.colorGold),
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        centered: true,
      );
    }
    
    _textRenderer.drawTextWithShadow(
      canvas,
      'Pressione ESPAÇO para iniciar',
      Offset(screenSize.x / 2, screenSize.y / 2 + 30),
      const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      centered: true,
    );
    
    _textRenderer.drawTextWithShadow(
      canvas,
      'Setas: Mover  |  P: Pausar  |  ESC: Menu',
      Offset(screenSize.x / 2, screenSize.y / 2 + 80),
      const TextStyle(
        color: Colors.white70,
        fontSize: 18,
      ),
      centered: true,
    );
  }
  
  void drawPauseMenu(Canvas canvas, Vector2 screenSize, int score) {
    // Overlay semi-transparente
    canvas.drawRect(
      Rect.fromLTWH(0, 0, screenSize.x, screenSize.y),
      Paint()..color = Colors.black.withOpacity(0.7),
    );
    
    // Box do menu
    final boxRect = Rect.fromCenter(
      center: Offset(screenSize.x / 2, screenSize.y / 2),
      width: 400,
      height: 300,
    );
    
    // Sombra
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        boxRect.shift(const Offset(4, 4)),
        const Radius.circular(20)
      ),
      Paint()..color = Colors.black.withOpacity(0.5),
    );
    
    // Box principal
    canvas.drawRRect(
      RRect.fromRectAndRadius(boxRect, const Radius.circular(20)),
      Paint()
        ..color = const Color(GameConstants.colorDark2)
        ..style = PaintingStyle.fill,
    );
    
    // Borda
    canvas.drawRRect(
      RRect.fromRectAndRadius(boxRect, const Radius.circular(20)),
      Paint()
        ..color = const Color(GameConstants.colorPrimary)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
    
    _textRenderer.drawTextWithShadow(
      canvas,
      'PAUSADO',
      Offset(screenSize.x / 2, screenSize.y / 2 - 80),
      const TextStyle(
        color: Color(GameConstants.colorPrimary),
        fontSize: 42,
        fontWeight: FontWeight.bold,
        letterSpacing: 3,
      ),
      centered: true,
    );
    
    _textRenderer.drawTextWithShadow(
      canvas,
      'Pontuação: $score',
      Offset(screenSize.x / 2, screenSize.y / 2 - 10),
      const TextStyle(
        color: Colors.white,
        fontSize: 26,
        fontWeight: FontWeight.w500,
      ),
      centered: true,
    );
    
    _textRenderer.drawTextWithShadow(
      canvas,
      'P - Continuar',
      Offset(screenSize.x / 2, screenSize.y / 2 + 40),
      const TextStyle(
        color: Colors.white70,
        fontSize: 20,
      ),
      centered: true,
    );
    
    _textRenderer.drawTextWithShadow(
      canvas,
      'ESC - Voltar ao Menu',
      Offset(screenSize.x / 2, screenSize.y / 2 + 75),
      const TextStyle(
        color: Colors.white70,
        fontSize: 20,
      ),
      centered: true,
    );
  }
  
  void drawGameOver(Canvas canvas, Vector2 screenSize, int score, int highScore) {
    // Overlay
    canvas.drawRect(
      Rect.fromLTWH(0, 0, screenSize.x, screenSize.y),
      Paint()..color = Colors.black.withOpacity(0.8),
    );
    
    _textRenderer.drawTextWithShadow(
      canvas,
      'GAME OVER',
      Offset(screenSize.x / 2, screenSize.y / 2 - 120),
      const TextStyle(
        color: Color(GameConstants.colorDanger),
        fontSize: 52,
        fontWeight: FontWeight.bold,
        letterSpacing: 4,
      ),
      centered: true,
    );
    
    _textRenderer.drawTextWithShadow(
      canvas,
      'Pontuação Final: $score',
      Offset(screenSize.x / 2, screenSize.y / 2 - 30),
      TextStyle(
        color: score == highScore 
          ? const Color(GameConstants.colorGold) 
          : Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      centered: true,
    );
    
    if (score == highScore && score > 0) {
      _textRenderer.drawTextWithShadow(
        canvas,
        '★ NOVO RECORDE! ★',
        Offset(screenSize.x / 2, screenSize.y / 2 + 15),
        const TextStyle(
          color: Color(GameConstants.colorGold),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        centered: true,
      );
    }
    
    _textRenderer.drawTextWithShadow(
      canvas,
      'ESPAÇO - Jogar Novamente',
      Offset(screenSize.x / 2, screenSize.y / 2 + 80),
      const TextStyle(
        color: Colors.white,
        fontSize: 22,
      ),
      centered: true,
    );
    
    _textRenderer.drawTextWithShadow(
      canvas,
      'ESC - Voltar ao Menu',
      Offset(screenSize.x / 2, screenSize.y / 2 + 115),
      const TextStyle(
        color: Colors.white70,
        fontSize: 20,
      ),
      centered: true,
    );
  }
  
  void drawScore(Canvas canvas, Vector2 screenSize, int score, int highScore) {
    _textRenderer.drawTextWithShadow(
      canvas,
      'Pontuação: $score',
      const Offset(10, 10),
      const TextStyle(
        color: Color(GameConstants.colorPrimary),
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    );
    
    if (highScore > 0) {
      _textRenderer.drawTextWithShadow(
        canvas,
        'Recorde: $highScore',
        Offset(screenSize.x - 10, 10),
        const TextStyle(
          color: Color(GameConstants.colorGold),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        alignRight: true,
      );
    }
  }
}
