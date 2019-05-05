// Copyright (c) 2016, <your name>. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library lambert.example;

import 'package:lambert/lambert.dart' as lambert;

main() {
  lambert.Point point = new lambert.Point(668832.5384, 6950138.7285, 0.0);
  lambert.Point expected = new lambert.Point(2.56865, 49.64961, 0.0);

  lambert.Point result = point.convert(lambert.Zone.L93).degree();

  print("Result: ${result.y} ${result.x}");
}
