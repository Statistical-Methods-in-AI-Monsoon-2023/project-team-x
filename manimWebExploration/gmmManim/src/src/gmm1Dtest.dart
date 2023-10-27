import './gmm1D.dart';

void main() {
  List<double> data1 = [1, 1, 1, 1, 4, 4, 4, 4, 5];

  // Manual Initialization
  List<double> means = [1, 3, 7];
  List<double> covs = [1, 2, 3];
  List<double> weights = [1 / 3, 1 / 3, 1 / 3];

  var nComponents = 2;
  GMM1D gmm = GMM1D(nComponents, weights, means, covs);

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
