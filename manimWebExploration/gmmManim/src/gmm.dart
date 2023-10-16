import 'package:manim_web/manim.dart';

void main() {
  print("Doing GMM with DART");
  List<double> data1 = [
    1,
    1,
    2,
    1,
    2,
    3,
    6,
    6,
    6,
    5,
    8,
    7,
    21,
    20,
    18,
    19,
    24,
    1,
    3
  ];

  List<double> means1 = [1, 3, 7];
  List<double> covs1 = [1, 2, 3];
  List<double> weights = [1 / 3, 1 / 3, 1 / 3];
}

List<double> getPDFofX(data, mean, cov) {
  List<double> l = [];
  var length = data.length;
  for (var i = 0; i < length; i++) {
    double x = data[i];
    double p = (1 / (cov * 2 * pi)) *
        exp(-(((x - mean) * (x - mean)) / (2 * cov * cov)));
    l.add(p);
  }

  return l;
}

double getPDF(x, mean, cov) {
  double p = (1 / (cov * 2 * pi)) *
      exp(-(((x - mean) * (x - mean)) / (2 * cov * cov)));
  return p;
}

List<List<double>> eStep(data, weights, means, covs) {
  List<List<double>> r = []; // i,k
  var iLength = data.length;
  var kLength = weights.length;

  for (var i = 0; i < iLength; i++) {
    List<double> ri = [];
    double sum = 0;
    for (var k = 0; k < kLength; k++) {
      double resp = weights[k] * getPDF(data[i], means[k], covs[k]);
      sum += resp;
      ri.add(resp);
    }

    for (var k = 0; k < kLength; k++) {
      ri[k] /= sum;
    }
    r.add(ri);
  }

  return r;
}
