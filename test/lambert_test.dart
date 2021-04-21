library test;


import 'package:test/test.dart';

import 'package:lambert/lambert.dart';

void main() {
  group('Valid elements', () {
    test('Lambert93', () {
      var point = Point(668832.5384, 6950138.7285, 0.0);
      var expected = Point(2.56865, 49.64961, 0.0);

      var result = point.convert(Zone.L93).degree();

      expect((result.x - expected.x), lessThanOrEqualTo(1e-5));
      expect((result.y - expected.y), lessThanOrEqualTo(1e-5));
    });

    test('ZenithStrasbourg', () {
      var point = Point(994300.623, 113409.981, 0.0);
      var expected =
          Point(7.68639475277068, 48.5953456709144, 0.0);

      var result = point.convert(Zone.I).degree();

      expect((result.x - expected.x), lessThanOrEqualTo(1e-5));
      expect((result.y - expected.y), lessThanOrEqualTo(1e-5));
    });
  });
}
