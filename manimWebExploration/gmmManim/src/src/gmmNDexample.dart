import 'dart:math';
import 'package:ml_linalg/linalg.dart';

class GaussianMixtureModel {
  int k; // Number of clusters
  int n; // Number of data points
  Matrix data; // Data matrix
  Matrix means; // Matrix of means
  List<Matrix> covariances; // List of covariance matrices
  List<double> weights; // List of weights for each cluster

  GaussianMixtureModel(this.k, this.data) {
    n = data.rowsNum;
    initializeParameters();
  }

  void initializeParameters() {
    Random random = Random();
    means = Matrix.fromList(List.generate(
        k, (_) => List.generate(data.columnCount, (_) => random.nextDouble())));
    covariances = List.generate(
        k,
        (_) => Matrix.fromList(List.generate(data.columnCount,
            (i) => List.generate(data.columnCount, (_) => 0.0))));
    weights = List.generate(k, (_) => 1.0 / k);
  }

  double gaussianProbability(Vector x, Matrix mean, Matrix covariance) {
    final d = x - mean.getRow(0);
    final exponent =
        -0.5 * ((d.transpose() * covariance.inverse() * d).toList()[0]);
    final denominator = sqrt(pow(2 * pi, d.length) * covariance.determinant());
    return (1 / denominator) * exp(exponent);
  }

  void expectationStep(List<List<double>> responsibilities) {
    for (int i = 0; i < n; i++) {
      double sumProbabilities = 0.0;
      for (int j = 0; j < k; j++) {
        final probability = weights[j] *
            gaussianProbability(
                data.getRow(i), means.getRow(j), covariances[j]);
        responsibilities[i][j] = probability;
        sumProbabilities += probability;
      }
      responsibilities[i] =
          responsibilities[i].map((prob) => prob / sumProbabilities).toList();
    }
  }

  void maximizationStep(List<List<double>> responsibilities) {
    for (int j = 0; j < k; j++) {
      final sumResponsibilities =
          responsibilities.fold(0.0, (acc, r) => acc + r[j]);
      weights[j] = sumResponsibilities / n;

      final sumWeights = sumResponsibilities;

      final meanSum = Vector.zero(data.columnCount);
      final covarianceSum = Matrix.fromList(List.generate(data.columnCount,
          (i) => List.generate(data.columnCount, (_) => 0.0)));

      for (int i = 0; i < n; i++) {
        final Vector x = data.getRow(i);
        final Vector mean = means.getRow(j);

        meanSum.add(x * responsibilities[i][j]);
        final d = x - mean;
        covarianceSum.add(d.outer(d) * responsibilities[i][j]);
      }

      means.setRow(j, meanSum / sumWeights);
      covariances[j] = covarianceSum / sumWeights;
    }
  }

  double logLikelihood(List<List<double>> responsibilities) {
    double logLikelihood = 0.0;
    for (int i = 0; i < n; i++) {
      double pointLikelihood = 0.0;
      for (int j = 0; j < k; j++) {
        pointLikelihood += weights[j] *
            gaussianProbability(
                data.getRow(i), means.getRow(j), covariances[j]);
      }
      logLikelihood += log(pointLikelihood);
    }
    return logLikelihood;
  }

  void fit(int maxIterations, double tolerance) {
    List<List<double>> responsibilities =
        List.generate(n, (_) => List.filled(k, 0.0));

    double prevLogLikelihood = double.negativeInfinity;
    for (int iteration = 0; iteration < maxIterations; iteration++) {
      expectationStep(responsibilities);
      maximizationStep(responsibilities);

      final currentLogLikelihood = logLikelihood(responsibilities);

      if ((currentLogLikelihood - prevLogLikelihood).abs() < tolerance) {
        break;
      }

      prevLogLikelihood = currentLogLikelihood;
    }
  }
}
