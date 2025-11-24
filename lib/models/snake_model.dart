import 'package:flame/game.dart';

class SnakeModel {
  List<Vector2> segments;
  Vector2 direction;
  
  SnakeModel({
    required this.segments,
    required this.direction,
  });
  
  Vector2 get head => segments.first;
  
  void move(Vector2 newHead, bool grow) {
    segments.insert(0, newHead);
    if (!grow) {
      segments.removeLast();
    }
  }
  
  bool checkSelfCollision(Vector2 head) {
    for (int i = 1; i < segments.length; i++) {
      if (head == segments[i]) return true;
    }
    return false;
  }
  
  void reset() {
    segments = [Vector2(5, 5), Vector2(4, 5), Vector2(3, 5)];
    direction = Vector2(1, 0);
  }
}
