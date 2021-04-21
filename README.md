This package helps to convert geographical point from a Lambert coordinate system 
to the WGS84 coordinate system.

## Usage

```dart
import 'package:lambert/lambert.dart';

main() {
  var point = Point(668832.5384,6950138.7285,0.0);
  var result = point.convert(lambert.Zone.L93).degree();

  print("WGS84 Lat: ${result.y} Lon:${result.x}");
}
```
