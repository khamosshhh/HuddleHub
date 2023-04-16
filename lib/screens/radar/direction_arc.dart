import 'package:flutter/material.dart';
import 'dart:math' as math;

class DirectionArc extends StatelessWidget {
  final double size;
  final Color color;
  const DirectionArc({
    Key? key,
    this.size = 200,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const RadialGradient(
        radius: 0.75,
        stops: [0.3, 0.7],
        colors: [
          Colors.white,
          Colors.white10,
        ],
      ).createShader(bounds),
      child: CustomPaint(
        painter: MyPainter(color: color),
        size: Size(size, size),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final Color color;
  MyPainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    canvas.drawArc(
        Rect.fromCenter(
            center: Offset(size.height / 2, size.width / 2),
            width: size.width,
            height: size.height),
        (180 + 45) * math.pi / 180.0,
        90 * math.pi / 180.0,
        true,
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
