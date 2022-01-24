import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomWave extends CustomPainter {
  double diameter;
  Color colorUp;
  Color colorDown;
  double width;
  CustomWave({this.diameter, this.colorUp, this.colorDown, this.width});
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0, 0, diameter, diameter);
    final startAngle = -math.pi;
    final sweepAngle = math.pi;
    final useCenter = false;
    final paint = Paint()
      ..color = colorUp
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
    final rect1 = Rect.fromLTRB(0, 0, diameter, diameter);
    final startAngle1 = math.pi;
    final sweepAngle1 = -math.pi;
    final useCenter1 = false;
    final paint1 = Paint()
      ..color = colorDown
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    canvas.drawArc(rect1, startAngle1, sweepAngle1, useCenter1, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
