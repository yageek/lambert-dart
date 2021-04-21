library lambert.point;

import "lambert_zone.dart" as lambertZone;
import "lambert_point.dart" as lambertPoint;
import "lambert_algo.dart";
import "lambert_constants.dart";
import "dart:math";

/// Point represents point in space
class Point {
  double x;
  double y;
  double z;

  /// Default initializer
  Point(this.x, this.y, this.z);

  /// Returns a new [Point] converted
  /// in the specified [Zone]
  Point convert(lambertZone.Zone zone) {
    if (zone == lambertZone.Zone.L93) {
      return lambertToGeographic(
          this, zone, lonIERSMeridian, eWGS84, defaultEPS);
    } else {
      lambertPoint.Point point = lambertToGeographic(
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

    return new lambertPoint.Point(
        this.x * factor, this.y * factor, this.z * factor);
  }
}
