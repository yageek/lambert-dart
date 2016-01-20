
library lambert.zone;

enum Zone {
  I, II, III, IV, IIe, L93
}

final lambertN = [0.7604059656, 0.7289686274, 0.6959127966, 0.6712679322, 0.7289686274, 0.7256077650];
final lambertC = [11603796.98, 11745793.39, 11947992.52, 12136281.99, 11745793.39, 11754255.426];
final lambertXs = [600000.0, 600000.0, 600000.0, 234.358, 600000.0, 700000.0];
final lambertYs = [5657616.674, 6199695.768, 6791905.085, 7239161.542, 8199695.768, 12655612.050];

double N(Zone zone){
  return lambertN[zone.index];
}

double C(Zone zone){
  return lambertC[zone.index];
}

double Xs(Zone zone){
  return lambertXs[zone.index];
}

double Ys(Zone zone){
  return lambertYs[zone.index];
}