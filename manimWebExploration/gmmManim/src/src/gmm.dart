import 'dart:math';

class GMM {
  int numComponents; // Number of clusters
  List<double> weights; // Weights for each cluster
  List<double> means; // Mean values for each cluster
  List<double> variances; // Variances for each cluster

  GMM(this.numComponents, this.weights, this.means, this.variances);

  // Utility Absolute Function
  double abs(double x) {
    if (x > 0) {
      return x;
    }
    return -x;
  }

  // Computes pdf of a 1D (univariate) normal distribution
  double univariateNormal(double x, double mean, double variance) {
    final threshold = 1e-7;
    final diffThreshold = 1e-5;
    if (variance < threshold) {
      if (abs(x - mean) < diffThreshold)
        return 1;
      else
        return 0;
    }

    final diff = x - mean;
    final exponent = -0.5 * (diff * diff) / variance;
    return (1 / (sqrt(2 * pi * variance))) * exp(exponent);
  }

  // Computes pdf of a 2+D (univariate) normal distribution
  // TODO: NOT DONE
  double multivariateNormal(double x, double mean, double covariance) {
    final threshold = 1e-7;
    final diffThreshold = 1e-5;
    if (covariance < threshold) {
      if (abs(x - mean) < diffThreshold)
        return 1;
      else
        return 0;
    }
    final diff = x - mean;
    final exponent = -0.5 * (diff * diff) / covariance;
    return (1 / (sqrt(2 * pi * covariance))) * exp(exponent);
  }

  // Computes E-step of the EM algorithm
  // finds the responsibilities of each point to each cluster
  List<List<double>> eStep(List<double> data) {
    final n = data.length;
    final responsibilities =
        List.generate(n, (_) => List.generate(numComponents, (_) => 0.0));

    for (var i = 0; i < n; i++) {
      for (var j = 0; j < numComponents; j++) {
        responsibilities[i][j] =
            weights[j] * univariateNormal(data[i], means[j], variances[j]);
      }

      final sumResp = responsibilities[i].reduce((a, b) => a + b);
      responsibilities[i] =
          responsibilities[i].map((resp) => resp / sumResp).toList();
    }

    return responsibilities;
  }

  // Computes the M-step of the EM algorithm
  void mStep(List<double> data, List<List<double>> responsibilities) {
    final n = data.length;

    for (var j = 0; j < numComponents; j++) {
      double respSum = 0;
      for (var i = 0; i < n; i++) {
        respSum += responsibilities[i][j];
      }
      weights[j] = respSum / n;

      final respData =
          List.generate(n, (i) => responsibilities[i][j] * data[i]);
      means[j] = respData.reduce((a, b) => a + b) / respSum;

      final varianceData = List.generate(
          n, (i) => responsibilities[i][j] * pow(data[i] - means[j], 2));
      variances[j] = varianceData.reduce((a, b) => a + b) / respSum;
    }
  }
}

void main() {
  List<double> data1 = [1, 1, 1, 1, 4, 4, 4, 4, 5];

  // Manual Initialization
  List<double> means = [1, 3, 7];
  List<double> covs = [1, 2, 3];
  List<double> weights = [1 / 3, 1 / 3, 1 / 3];

  var nComponents = 2;
  GMM gmm = GMM(nComponents, weights, means, covs);

  final numIterations = 20;

  for (var iteration = 0; iteration < numIterations; iteration++) {
    print(iteration);
    print(gmm.means);
    print(gmm.variances);
    print(gmm.weights);
    print("\n");

    List<List<double>> resp = gmm.eStep(data1);
    final hi = gmm.mStep(data1, resp);
  }

  print("Final output");
  print(gmm.means);
  print(gmm.variances);
  print(gmm.weights);
}
