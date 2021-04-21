
// Copyright (c) 2016, Yannick Heinrich. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

///  lambert helps to convert geographical point from a Lambert coordinate system 
///  to the WGS84 coordinate system.
///
/// The API is centered on `Point` and `Zone` to process every conversion.
library lambert;

import 'src/algo.dart';
import 'src/constants.dart';
import "dart:math";

/// The Lambert zone identifier
enum Zone { I, II, III, IV, IIe, L93 }

/// Point represents point in space
class Point {
  /// The X position of the point
  double x;

  /// The Y position of the point
  double y;

  /// The Z position of the point
  double z;

  /// Initialize a new point (coordinates assumed to be provide as radians)
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

  /// Get a new points whose coordinates are expressed in degrees.
  Point degree() {
    double factor = 180.0 / pi;

    return Point(this.x * factor, this.y * factor, this.z * factor);
  }
}
