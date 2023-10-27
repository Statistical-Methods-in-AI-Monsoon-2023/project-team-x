import 'dart:math';
import 'package:vector_math/vector_math.dart';

class GMM {
  int numComponents;
  List<Vector3> means;
  List<Matrix3> covariances;
  List<double> weights;

  GMM(this.numComponents, this.means, this.covariances, this.weights);

  // Function to calculate the probability of a data point belonging to each component
  List<double> calculateComponentProbabilities(Vector3 dataPoint) {
    List<double> probabilities = [];

    for (int i = 0; i < numComponents; i++) {
      double det = covariances[i].determinant();
      Matrix3 invCov = covariances[i].inverse();

      Vector3 diff = dataPoint - means[i];
      double exponent = -(diff.transpose() * invCov * diff).w / 2;

      double componentProbability = (1 / (sqrt(2 * pi * det))) * exp(exponent);
      probabilities.add(componentProbability * weights[i]);
    }

    double totalProbability = probabilities.reduce((a, b) => a + b);

    return probabilities.map((p) => p / totalProbability).toList();
  }

  // Function to predict the component with the highest probability for a given data point
  int predict(Vector dataPoint) {
    List<double> probabilities = calculateComponentProbabilities(dataPoint);
    return probabilities.indexOf(probabilities.reduce(max));
  }
}

