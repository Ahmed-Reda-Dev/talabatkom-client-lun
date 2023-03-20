import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';

class CirclePainter extends CustomPainter {
  final int numSlices;
  final double progress;

  CirclePainter({
    required this.numSlices,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = HexColor('#F5504C')
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double angle = (2 * pi) / 3;

    for (int i = 0; i < numSlices; i++) {
      double startAngle = i * angle;
      double sweepAngle = angle;

      if (i == numSlices - 1) {
        sweepAngle *= progress;
      }

      canvas.drawArc(
        Rect.fromCircle(
          //put the center of the circle in the center of the canvas
          center: Offset(size.width / 2, size.height / 2),
          radius: 13.w,
        ),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
