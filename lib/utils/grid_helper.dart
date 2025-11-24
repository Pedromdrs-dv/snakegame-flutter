import 'package:flame/game.dart';
import '../core/constants.dart';

class GridHelper {
  static int getCols(Vector2 screenSize) {
    return (screenSize.x / GameConstants.gridSize).floor();
  }
  
  static int getRows(Vector2 screenSize) {
    return (screenSize.y / GameConstants.gridSize).floor();
  }
  
  static Vector2 wrapPosition(Vector2 position, Vector2 screenSize) {
    final cols = getCols(screenSize);
    final rows = getRows(screenSize);
    
    var newPos = position.clone();
    
    if (newPos.x < 0) {
      newPos.x = cols - 1.0;
    } else if (newPos.x >= cols) {
      newPos.x = 0;
    }
    
    if (newPos.y < 0) {
      newPos.y = rows - 1.0;
    } else if (newPos.y >= rows) {
      newPos.y = 0;
    }
    
    return newPos;
  }
}
