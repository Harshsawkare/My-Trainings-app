import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  final Axis axis;
  final double dashWidth;
  final double dashHeight;
  final double dashSpacing;
  final Color color;

  const DashedLine({
    Key? key,
    this.axis = Axis.vertical,
    this.dashWidth = 4.0,
    this.dashHeight = 1.0,
    this.dashSpacing = 4.0,
    this.color = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
        axis == Axis.vertical ? dashWidth : double.infinity,
        axis == Axis.horizontal ? dashHeight : double.infinity,
      ),
      painter: _DashedLinePainter(
        axis: axis,
        dashWidth: dashWidth,
        dashHeight: dashHeight,
        dashSpacing: dashSpacing,
        color: color,
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Axis axis;
  final double dashWidth;
  final double dashHeight;
  final double dashSpacing;
  final Color color;

  _DashedLinePainter({
    required this.axis,
    required this.dashWidth,
    required this.dashHeight,
    required this.dashSpacing,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = dashHeight
      ..style = PaintingStyle.stroke;

    double start = 0.0;
    final isVertical = axis == Axis.vertical;
    final maxLength = isVertical ? size.height : size.width;

    while (start < maxLength) {
      final end = start + (isVertical ? dashHeight : dashWidth);
      if (isVertical) {
        canvas.drawLine(
          Offset(0, start),
          Offset(0, end.clamp(0.0, maxLength)),
          paint,
        );
      } else {
        canvas.drawLine(
          Offset(start, 0),
          Offset(end.clamp(0.0, maxLength), 0),
          paint,
        );
      }
      start += (isVertical ? dashHeight : dashWidth) + dashSpacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
