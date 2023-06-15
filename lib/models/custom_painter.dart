import 'package:gips/models/touch_point.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MyCustomPainter extends CustomPainter {
  MyCustomPainter({required this.pointsList});

  List<TouchPoints?> pointsList;

  List<Offset> offsetPoints = List.empty(growable: true);

  @override
  void paint(Canvas canvas, Size size) {
    Paint background = Paint()..color = Colors.white;

    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawRect(rect, background);
    canvas.clipRect(rect);

    for (int i = 0; i < pointsList.length - 1; i++) {
      final isPointListValid = pointsList[i] != null;

      if (isPointListValid && pointsList[i + 1] != null) {
        //Drawing line when two consecutive points are available
        canvas.drawLine(pointsList[i]!.points, pointsList[i + 1]!.points,
            pointsList[i]!.paint);
      } else if (isPointListValid && pointsList[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList[i]!.points);
        offsetPoints.add(Offset(
            pointsList[i]!.points.dx + 0.1, pointsList[i]!.points.dy + 0.1));

        //Draw points when two points are not next to each other
        canvas.drawPoints(
            ui.PointMode.points, offsetPoints, pointsList[i]!.paint);
      }
    }
  }

  //Called when CustomPainter is rebuilt.
  //Returning true because we want canvas to be rebuilt to reflect new changes.
  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) => true;
}
