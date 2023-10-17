import 'package:manim_web/manim.dart';
import 'package:calc/calc.dart';

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

  List<double> means = [1, 3, 7];
  List<double> covs = [1, 2, 3];
  List<double> weights = [1 / 3, 1 / 3, 1 / 3];

  var iterations = 3;
  for (var iteration = 0; iteration < iterations; iteration++) {
    print(iteration);
    List<List<double>> r = eStep(data1, means, covs, weights);
    // print(r);
    print(means);
    print(covs);
    print(weights);

    means = mStepMeans(data1, r, means, covs, weights);
    covs = mStepCovs(data1, r, means, covs, weights);
    weights = mStepWeights(data1, r, means, covs, weights);
  }
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

double getPDF2(double x, double mean, double cov, {double epsilon = 1e-6}) {
  double p = (1 / (sqrt(2 * pi * cov) + epsilon)) *
      exp(-(((x - mean) * (x - mean)) / (2 * cov * cov + epsilon)));
  // print("\nnormalization");
  // print(mean);
  // print(cov);
  print(1 / (cov * sqrt(2 * pi) + epsilon));
  print(exp(-(((x - mean) * (x - mean)) / (2 * cov * cov + epsilon))));
  return p;
}

double getPDF(double x, double mean, double cov, {double epsilon = 1e-6}) {
  final distribution = NormalDistribution(mean: mean, variance: cov);
  double p = distribution.pdf(x);
  print(p);
  return p;
}

// Get responsibilities for each i, k
// Returns responsibilities of each data point being
// part of kth GMM
List<List<double>> eStep(List<double> data, List<double> means,
    List<double> covs, List<double> weights) {
  List<List<double>> r = []; // i,k
  var iLength = data.length;
  var kLength = weights.length;

  // print("lenghts");
  // print(iLength);
  // print(kLength);

  for (var i = 0; i < iLength; i++) {
    List<double> ri = [];
    double sum = 0;
    for (var k = 0; k < kLength; k++) {
      double resp = weights[k] * getPDF(data[i], means[k], covs[k]);
      // print(weights[k]);
      // print(getPDF(data[i], means[k], covs[k]));
      sum = sum + resp;
      ri.add(resp);
    }

    for (var k = 0; k < kLength; k++) {
      ri[k] = ri[k] / sum;
    }
    r.add(ri);
  }

  return r;
}

// Returns weights
List<double> mStepWeights(List<double> data, List<List<double>> resps,
    List<double> means, List<double> covs, List<double> weights) {
  List<double> newWeights = [];

  var iLength = data.length;
  var kLength = weights.length;

  for (var k = 0; k < kLength; k++) {
    double sum = 0;
    for (var i = 0; i < iLength; i++) {
      sum += resps[i][k] / iLength;
    }
    newWeights.add(sum);
  }

  return newWeights;
}

// Returns means, covs
List<double> mStepMeans(List<double> data, List<List<double>> resps,
    List<double> means, List<double> covs, List<double> weights) {
  List<double> newMeans = [];

  var iLength = data.length;
  var kLength = weights.length;

  for (var k = 0; k < kLength; k++) {
    double sum = 0;
    double sum2 = 0;
    for (var i = 0; i < iLength; i++) {
      sum += resps[i][k] * data[i];
      sum2 += resps[i][k];
    }
    newMeans.add(sum / sum2);
  }

  return newMeans;
}

// Returns covs
List<double> mStepCovs(List<double> data, List<List<double>> resps,
    List<double> means, List<double> covs, List<double> weights) {
  List<double> newCovs = [];

  var iLength = data.length;
  var kLength = weights.length;

  for (var k = 0; k < kLength; k++) {
    double sum = 0;
    double sum2 = 0;
    for (var i = 0; i < iLength; i++) {
      sum += resps[i][k] * (data[i] - means[k]);
      sum2 += resps[i][k];
    }
    newCovs.add(sum / sum2);
  }

  return newCovs;
}
