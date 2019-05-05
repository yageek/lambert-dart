library lambert.test;

import 'package:lambert/lambert.dart' as lambert;
import 'package:test/test.dart';

void main() {
  group('Valid elements', () {
    test('Lambert93', () {
      lambert.Point point = new lambert.Point(668832.5384, 6950138.7285, 0.0);
      lambert.Point expected = new lambert.Point(2.56865, 49.64961, 0.0);

      lambert.Point result = point.convert(lambert.Zone.L93).degree();

      expect((result.x - expected.x), lessThanOrEqualTo(1e-5));
      expect((result.y - expected.y), lessThanOrEqualTo(1e-5));
    });

    test('ZenithStrasbourg', () {
      lambert.Point point = new lambert.Point(994300.623, 113409.981, 0.0);
      lambert.Point expected =
          new lambert.Point(7.68639475277068, 48.5953456709144, 0.0);

      lambert.Point result = point.convert(lambert.Zone.I).degree();

      expect((result.x - expected.x), lessThanOrEqualTo(1e-5));
      expect((result.y - expected.y), lessThanOrEqualTo(1e-5));
    });
  });
}
