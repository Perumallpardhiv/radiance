import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:radiance/steering.dart';
import 'package:vector_math/vector_math_64.dart';

import 'entity.dart';

class MaxAccelerationEntity extends Entity {
  MaxAccelerationEntity({
    Vector2? position,
    Vector2? velocity,
    required double maxSpeed,
    required double maxAcceleration,
    double size = 8,
  }) : super(
          position: position,
          size: size,
          velocity: velocity,
          kinematics: MaxAccelerationKinematics(
            maxSpeed: maxSpeed,
            maxAcceleration: maxAcceleration,
          ),
        ) {
    path = Path()
      ..moveTo(size * 0.6, 0)
      ..lineTo(-0.3 * size, -0.3 * size)
      ..quadraticBezierTo(-0.2 * size, 0, -0.3 * size, 0.3 * size)
      ..close();
    paint = Paint()..color = const Color(0xff3f7ddb);
    outlinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = .5
      ..color = const Color(0xff74a6cd);
  }

  late final Path path;
  late final Paint paint;
  late final Paint outlinePaint;

  @override
  void render(Canvas canvas) {
    canvas.save();
    canvas.translate(position.x, position.y);
    canvas.rotate(angle);
    canvas.drawPath(path, outlinePaint);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  void renderVectors(Canvas canvas) {}
}