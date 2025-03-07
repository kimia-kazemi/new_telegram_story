import 'dart:math';
import 'package:flutter/material.dart';

class DottedBorder extends CustomPainter {
  final int numberOfStories;
  final int spaceLength;
  final int numberOfSeen;
  double startOfArcInDegree = 0;

  DottedBorder({
    required this.numberOfStories,
    required this.numberOfSeen,
    this.spaceLength = 10,
  });

  double inRads(double degree) {
    return (degree * pi) / 180;
  }

  @override
  bool shouldRepaint(DottedBorder oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = size.width * 0.05; // Adjust stroke width based on size
    double padding = strokeWidth / 2; // Ensure stroke stays within bounds
    Rect rect = Rect.fromLTWH(padding, padding, size.width - strokeWidth, size.height - strokeWidth);

    double arcLength = (360 - (numberOfStories * spaceLength)) / numberOfStories;
    if (arcLength <= 0) {
      arcLength = 360 / spaceLength - 1;
    }

    for (int i = 0; i < numberOfStories; i++) {
      canvas.drawArc(
        rect,
        inRads(startOfArcInDegree),
        inRads(arcLength),
        false,
        Paint()
          ..color = i < numberOfSeen ?   Colors.grey:Colors.teal
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke,
      );
      startOfArcInDegree += arcLength + spaceLength;
    }
  }
}
