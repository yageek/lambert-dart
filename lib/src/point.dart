library lambert.point;

import 'algo.dart';
import 'constants.dart';
import "dart:math";

/// The Lambert zone identifier
enum Zone {
  I, II, III, IV, IIe, L93
}

/// Point represents point in space
class Point {
  double x;
  double y;
  double z;

  /// Default initializer
  Point(this.x, this.y, this.z);

  /// Returns a new [Point] converted
  /// in the specified [Zone]
  Point convert(Zone zone) {
    if (zone == Zone.L93) {
      return lambertToGeographic(
          this, zone, lonIERSMeridian, eWGS84, defaultEPS);
    } else {
      var point = lambertToGeographic(
          this, zone, lonParisMeridian, eClarkIGN, defaultEPS);
      point = geographicToCartesian(
          point.x, point.y, point.z, aClarkIGN, eClarkIGN);

      point.x -= 168;
      point.y -= 60;
      point.z += 320;

      return cartesianToGeographic(
          point, lonGreenwichMeridian, aWGS84, eWGS84, defaultEPS);
    }
  }

  /// Converts to Degree
  Point degree() {
    double factor = 180.0 / pi;

    return Point(
        this.x * factor, this.y * factor, this.z * factor);
  }
}
