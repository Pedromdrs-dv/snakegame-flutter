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
      Offset(screenSize.x / 2, screenSize.y / 2 - 150),
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
        Offset(screenSize.x / 2, screenSize.y / 2 - 70),
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
      'ESPAÇO - Jogar',
      Offset(screenSize.x / 2, screenSize.y / 2 + 10),
      const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      centered: true,
    );
    
    _textRenderer.drawTextWithShadow(
      canvas,
      'C - Controles',
      Offset(screenSize.x / 2, screenSize.y / 2 + 50),
      const TextStyle(
        color: Colors.white70,
        fontSize: 22,
      ),
      centered: true,
    );
    
    _textRenderer.drawTextWithShadow(
      canvas,
      'A - Sobre',
      Offset(screenSize.x / 2, screenSize.y / 2 + 85),
      const TextStyle(
        color: Colors.white70,
        fontSize: 22,
      ),
      centered: true,
    );
  }

  void drawControlsScreen(Canvas canvas, Vector2 screenSize) {
    // Título
    _textRenderer.drawTextWithShadow(
      canvas,
      'CONTROLES',
      Offset(screenSize.x / 2, 80),
      const TextStyle(
        color: Color(GameConstants.colorPrimary),
        fontSize: 48,
        fontWeight: FontWeight.bold,
        letterSpacing: 3,
      ),
      centered: true,
    );
    
    // Box de controles
    final boxRect = Rect.fromCenter(
      center: Offset(screenSize.x / 2, screenSize.y / 2 + 20),
      width: 500,
      height: 400,
    );
    
    _drawBox(canvas, boxRect);
    
    final startY = screenSize.y / 2 - 140;
    final lineHeight = 50.0;
    
    // Lista de controles
    final controls = [
      {'key': '↑ ↓ ← →', 'action': 'Mover a cobra'},
      {'key': 'ESPAÇO', 'action': 'Iniciar/Reiniciar jogo'},
      {'key': 'P', 'action': 'Pausar/Continuar'},
      {'key': 'ESC', 'action': 'Voltar ao menu'},
      {'key': 'C', 'action': 'Tela de controles'},
      {'key': 'A', 'action': 'Sobre o jogo'},
    ];
    
    for (int i = 0; i < controls.length; i++) {
      final y = startY + (i * lineHeight);
      
      // Tecla
      _textRenderer.drawTextWithShadow(
        canvas,
        controls[i]['key']!,
        Offset(screenSize.x / 2 - 150, y),
        const TextStyle(
          color: Color(GameConstants.colorPrimary),
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: 'monospace',
        ),
      );
      
      // Separador
      _textRenderer.drawTextWithShadow(
        canvas,
        '→',
        Offset(screenSize.x / 2 - 30, y),
        const TextStyle(
          color: Colors.white60,
          fontSize: 20,
        ),
      );
      
      // Ação
      _textRenderer.drawTextWithShadow(
        canvas,
        controls[i]['action']!,
        Offset(screenSize.x / 2 + 10, y),
        const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      );
    }
    
    // Instrução de volta
    _textRenderer.drawTextWithShadow(
      canvas,
      'Pressione ESC para voltar',
      Offset(screenSize.x / 2, screenSize.y - 60),
      const TextStyle(
        color: Colors.white70,
        fontSize: 18,
      ),
      centered: true,
    );
  }

  void drawAboutScreen(Canvas canvas, Vector2 screenSize) {
    // Título
    _textRenderer.drawTextWithShadow(
      canvas,
      'SOBRE O JOGO',
      Offset(screenSize.x / 2, 80),
      const TextStyle(
        color: Color(GameConstants.colorPrimary),
        fontSize: 48,
        fontWeight: FontWeight.bold,
        letterSpacing: 3,
      ),
      centered: true,
    );
    
    // Box principal
    final boxRect = Rect.fromCenter(
      center: Offset(screenSize.x / 2, screenSize.y / 2 + 20),
      width: 600,
      height: 450,
    );
    
    _drawBox(canvas, boxRect);
    
    final startY = screenSize.y / 2 - 170;
    final lineHeight = 35.0;
    
    // Informações sobre o jogo
    final aboutLines = [
      'Snake Game é um clássico jogo de arcade',
      'onde você controla uma cobra que cresce',
      'ao comer alimentos.',
      '',
      'OBJETIVO:',
      'Coma o máximo de comida possível sem',
      'colidir com seu próprio corpo.',
      '',
      'DICAS:',
      '• Cada comida vale 10 pontos',
      '• A cobra atravessa as bordas da tela',
      '• Planeje seus movimentos com cuidado',
      '• Tente bater seu recorde!',
    ];
    
    for (int i = 0; i < aboutLines.length; i++) {
      final y = startY + (i * lineHeight);
      final isTitle = aboutLines[i].endsWith(':');
      final isEmpty = aboutLines[i].isEmpty;
      
      if (!isEmpty) {
        _textRenderer.drawTextWithShadow(
          canvas,
          aboutLines[i],
          Offset(screenSize.x / 2, y),
          TextStyle(
            color: isTitle 
              ? const Color(GameConstants.colorGold)
              : Colors.white,
            fontSize: isTitle ? 24 : 20,
            fontWeight: isTitle ? FontWeight.bold : FontWeight.normal,
          ),
          centered: true,
        );
      }
    }
    
    // Versão e créditos
    _textRenderer.drawTextWithShadow(
      canvas,
      'Versão 1.0  •  Feito com Flutter & Flame',
      Offset(screenSize.x / 2, screenSize.y - 90),
      const TextStyle(
        color: Colors.white60,
        fontSize: 16,
      ),
      centered: true,
    );
    
    // Instrução de volta
    _textRenderer.drawTextWithShadow(
      canvas,
      'Pressione ESC para voltar',
      Offset(screenSize.x / 2, screenSize.y - 60),
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
  
  void _drawBox(Canvas canvas, Rect boxRect) {
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
  }
}
