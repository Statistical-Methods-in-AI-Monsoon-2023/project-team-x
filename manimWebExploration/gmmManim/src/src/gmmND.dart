// import 'package:manim_web/manim.dart';
import 'dart:math';
// import 'package:ml_linalg/linalg.dart';
import 'package:vector_math/vector_math.dart';



// Part of GMM Package
// Initialize weights to be 1/numComponents
List<double> initializeWeights(int length) {
  return List.generate(length, (index) => 1 / length);
}

class GMM {
  int numComponents; // Number of clusters
  List<double> weights; // Weights for each cluster
  List<Vector3> means; // Mean values for each cluster
  List<Matrix3> covariances; // Covariance matrices for each cluster

  GMM(this.numComponents, this.weights, this.means, this.covariances);

  double multivariateNormal(Matrix x, Matrix mean, Matrix covariance) {
    final threshold = 1e-7;
    final det = covariance.determinant();
    final invCov = covariance.inverse();
    final diff = x - mean;
    final exponent = -0.5 * diff.transpose() * invCov * diff;

    if (det < threshold) {
      return 0;
    }

    return (1 / (sqrt(pow(2 * pi, 2) * det))) * exp(exponent);
  }

  List<List<double>> eStep(List<Vector> data) {
    final n = data.length;
    final responsibilities =
        List.generate(n, (_) => List.generate(numComponents, (_) => 0.0));

    for (var i = 0; i < n; i++) {
      for (var j = 0; j < numComponents; j++) {
        responsibilities[i][j] =
            weights[j] * multivariateNormal(data[i], means[j], covariances[j]);
      }

      final sumResp = responsibilities[i].reduce((a, b) => a + b);
      responsibilities[i] =
          responsibilities[i].map((resp) => resp / sumResp).toList();
    }

    return responsibilities;
  }

  void mStep(List<Vector2> data, List<List<double>> responsibilities) {
    final n = data.length;

    for (var j = 0; j < numComponents; j++) {
      double respSum = 0;
      Vector2 respData = Vector2.zero();
      Matrix2 covarianceData = Matrix2.zero();

      for (var i = 0; i < n; i++) {
        respSum += responsibilities[i][j];
        respData += data[i] * responsibilities[i][j];
        final diff = data[i] - means[j];
        covarianceData += (diff.outer(diff) * responsibilities[i][j]);
      }

      weights[j] = respSum / n;
      means[j] = respData / respSum;
      covariances[j] = covarianceData / respSum;
    }
  }
}

void main() {
  List<Vector3> data2D = [
    Vector3(1.0, 1.0, 0.0),
    Vector3(1.5, 1.5, 0.0),
    Vector3(3.0, 2.9, 0.0),
    Vector3(3.5, 3.0, 0.0),
    Vector3(7.0, 5.5, 0.0),
    Vector3(7.5, 5.7, 0.0),
    Vector3(8.0, 6.0, 0.0),
    Vector3(8.5, 6.2, 0.0),
    Vector3(9.0, 6.5, 0.0),
  ];

  // Manual Initialization
  List<Vector2> means = [
    Vector2(1, 1),
    Vector2(7, 6),
  ];
  List<Matrix2> covariances = [
    Matrix2(1, 0.5, 0.5, 1),
    Matrix2(1, -0.5, -0.5, 1),
  ];
  List<double> weights = [0.5, 0.5];

  var nComponents = 2;
  GMM gmm = GMM(nComponents, weights, means, covariances);

  final numIterations = 20;

  for (var iteration = 0; iteration < numIterations; iteration++) {
    print(iteration);
    print(gmm.means);
    print(gmm.covariances);
    print(gmm.weights);
    print("\n");

    List<List<double>> resp = gmm.eStep(data2D);
    final hi = gmm.mStep(data2D, resp);
  }

  print("Final output");
  print(gmm.means);
  print(gmm.covariances);
  print(gmm.weights);
}
