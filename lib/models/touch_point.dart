import 'dart:ui';

class TouchPoints {
  TouchPoints({required this.points, required this.paint});
  
  Paint paint;
  Offset points;

  Map<String, dynamic> toJson() {
    return {
      'point': {"dx": "${points.dx}", "dy": "${points.dy}"},
    };
  }
}
