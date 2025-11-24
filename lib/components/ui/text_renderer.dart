import 'dart:ui';
import 'package:flutter/material.dart';

class TextRenderer {
  void drawTextWithShadow(
    Canvas canvas,
    String text,
    Offset position,
    TextStyle style, {
    bool centered = false,
    bool alignRight = false,
  }) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    
    // Sombra
    textPainter.text = TextSpan(
      text: text,
      style: style.copyWith(
        color: Colors.black.withOpacity(0.6),
        shadows: [],
      ),
    );
    textPainter.layout();
    
    Offset shadowOffset = position + const Offset(3, 3);
    if (centered) {
      shadowOffset = Offset(position.dx - textPainter.width / 2 + 3, position.dy + 3);
    } else if (alignRight) {
      shadowOffset = Offset(position.dx - textPainter.width + 3, position.dy + 3);
    }
    textPainter.paint(canvas, shadowOffset);
    
    // Texto principal
    textPainter.text = TextSpan(text: text, style: style);
    textPainter.layout();
    
    Offset textOffset = position;
    if (centered) {
      textOffset = Offset(position.dx - textPainter.width / 2, position.dy);
    } else if (alignRight) {
      textOffset = Offset(position.dx - textPainter.width, position.dy);
    }
    textPainter.paint(canvas, textOffset);
  }
}
