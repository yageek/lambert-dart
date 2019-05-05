[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

# lambert-dart
lambert-dart is a crate helping to convert Lambert coordinates to WGS84.

## Usage

```dart
import 'package:lambert/lambert.dart' as lambert;

main() {
  lambert.Point point = new lambert.Point(668832.5384,6950138.7285,0.0);
  lambert.Point expected = new lambert.Point(2.56865, 49.64961, 0.0);

  lambert.Point result = point.convert(lambert.Zone.L93).degree();

  print("WGS84 Lat: ${result.y} Lon:${result.x}");
}
```
