library lambert.algo;

import 'dart:math';
import 'dart:core';
import 'lambert_point.dart' as pt;
import 'lambert_zone.dart' as lambertZone;

double latitudeISOFromLatitude(double lat, double e) {
  return log(tan(pi / 4 + lat / 2) *
      pow((1 - e * sin(lat)) / (1 + e * sin(lat)), e / 2));
}

double latitudeFromLatitudeISO(double lat_iso, double e, double eps) {
  double phi_0 = 2 * atan(exp(lat_iso)) - pi / 2;
  double phi_i = 2 *
          atan(pow((1 + e * sin(phi_0)) / (1 - e * sin(phi_0)), e / 2.0) *
              exp(lat_iso)) -
      pi / 2;
  double delta = phi_i - phi_0;

  while (delta.abs() > eps) {
    phi_0 = phi_i;
    phi_i = 2 *
            atan(pow((1 + e * sin(phi_0)) / (1 - e * sin(phi_0)), e / 2.0) *
                exp(lat_iso)) -
        pi / 2;

    delta = phi_i - phi_0;
  }

  return phi_i;
}

pt.Point lambertToGeographic(pt.Point org, lambertZone.Zone zone,
    double lon_merid, double e, double eps) {
  double n = lambertZone.N(zone);
  double C = lambertZone.C(zone);
  double x_s = lambertZone.Xs(zone);
  double y_s = lambertZone.Ys(zone);

  double x = org.x;
  double y = org.y;

  double lon, gamma, R, lat_iso;

  R = sqrt((x - x_s) * (x - x_s) + (y - y_s) * (y - y_s));

  gamma = atan((x - x_s) / (y_s - y));

  lon = lon_merid + gamma / n;

  lat_iso = -1 / n * log((R / C).abs());

  double lat = latitudeFromLatitudeISO(lat_iso, e, eps);

  return new pt.Point(lon, lat, org.z);
}

double lambertNormal(double lat, double a, double e) {
  return a / sqrt(1 - e * e * sin(lat) * sin(lat));
}

pt.Point geographicToCartesian(
    double lon, double lat, double he, double a, double e) {
  double N = lambertNormal(lat, a, e);

  pt.Point point = new pt.Point(0.0, 0.0, 0.0);
  point.x = (N + he) * cos(lat) * cos(lon);

  point.y = (N + he) * cos(lat) * sin(lon);

  point.z = (N * (1 - e * e) + he) * sin(lat);

  return point;
}

pt.Point cartesianToGeographic(
    pt.Point org, double meridien, double a, double e, double eps) {
  double x = org.x, y = org.y, z = org.z;

  double lon = meridien + atan(y / x);

  double module = sqrt(x * x + y * y);

  double phi_0 =
      atan(z / (module * (1 - (a * e * e) / sqrt(x * x + y * y + z * z))));
  double phi_i = atan(z /
      module /
      (1 -
          a *
              e *
              e *
              cos(phi_0) /
              (module * sqrt(1 - e * e * sin(phi_0) * sin(phi_0)))));
  double delta = phi_i - phi_0;
  while (delta.abs() > eps) {
    phi_0 = phi_i;
    phi_i = atan(z /
        module /
        (1 -
            a *
                e *
                e *
                cos(phi_0) /
                (module * sqrt(1 - e * e * sin(phi_0) * sin(phi_0)))));

    delta = phi_i - phi_0;
  }

  double he =
      module / cos(phi_i) - a / sqrt(1 - e * e * sin(phi_i) * sin(phi_i));

  return new pt.Point(lon, phi_i, he);
}
