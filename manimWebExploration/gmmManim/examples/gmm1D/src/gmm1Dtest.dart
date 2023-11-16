import './gmm1D.dart';

void main() {
  // List<double> data1 = [1, 1, 1, 1, 4, 4, 4, 4, 5];
  List<double> data1 = [1.1, 0.6, 1.3, 1.1, 5.2, 4.7, 5.1, 5.3, 5.2, 12.3, 12.1, 12.9, 12.4, 12];


  // Manual Initialization
  List<double> means = [1, 3, 7];
  List<double> covs = [1, 2, 3];
  List<double> weights = [1 / 3, 1 / 3, 1 / 3];

  var nComponents = 3;
  GMM1D gmm = GMM1D(nComponents, weights, means, covs);

  final numIterations = 5;

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
