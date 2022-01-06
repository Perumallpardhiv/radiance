import 'package:vector_math/vector_math_64.dart';

import '../behaviors/seek.dart';
import '../kinematics.dart';

/// [MaxAccelerationKinematics] describes an agent who can move in any direction
/// with speed up to `maxSpeed`, and change their velocity with acceleration
/// not exceeding `maxAcceleration`. This acceleration can be applied equally
/// in all directions, regardless of the direction where the character is
/// currently moving or facing.
///
/// This kinematics model is described by Craig Reynolds in his 1999 report on
/// steering behaviors, and is considered "standard" for game AI. It produces
/// reasonably looking behaviors and can be used in a variety of situations.
class MaxAccelerationKinematics extends Kinematics {
  MaxAccelerationKinematics({
    required this.maxSpeed,
    required this.maxAcceleration,
  })  : assert(maxSpeed > 0),
        assert(maxAcceleration >= 0),
        _acceleration = Vector2.zero();

  double maxSpeed;
  double maxAcceleration;
  final Vector2 _acceleration;

  void setAcceleration(Vector2 value) {
    assert(
      value.length2 <= maxAcceleration * maxAcceleration * (1 + 1e-8),
      'Trying to set acceleration=$value larger than max=$maxAcceleration',
    );
    _acceleration.setFrom(value);
  }

  @override
  void update(double dt) {
    own.position.addScaled(own.velocity, dt);
    own.velocity.addScaled(_acceleration, dt);
    final v = own.velocity.length;
    if (v > maxSpeed) {
      own.velocity.scale(maxSpeed / v);
    }
  }

  @override
  Seek seek(Vector2 point) => SeekForMaxAcceleration(owner: own, point: point);
}