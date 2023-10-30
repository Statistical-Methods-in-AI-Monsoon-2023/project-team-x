// import 'dart:math';
// import 'package:ml_linalg/linalg.dart';
// // import 'package:vector_math/vector_math.dart';

// // Part of GMM Package
// // Initialize weights to be 1/numComponents
// List<double> initializeWeights(int length) {
//   return List.generate(length, (index) => 1 / length);
// }

// class GMMND {
//   int numComponents; // Number of clusters
//   int dimensions; // Number of dimensions
//   List<double> weights; // Weights for each cluster
//   List<Matrix> means; // Mean values for each cluster
//   List<Matrix> covariances; // Covariance matrices for each cluster

//   GMMND(this.numComponents, this.dimensions, this.weights, this.means,
//       this.covariances);

//   // Utility Absolute Function
//   double abs(double x) {
//     if (x > 0) {
//       return x;
//     }
//     return -x;
//   }

//   Matrix createSubMatrix(Matrix matrix, int row, int col) {
//     final subList = List.generate(
//         matrix.rowCount - 1,
//         (i) => List.generate(matrix.columnCount - 1, (j) {
//               final rowIndex = i < row ? i : i + 1;
//               final colIndex = j < col ? j : j + 1;
//               return matrix[rowIndex][colIndex];
//             }));

//     return Matrix.fromList(subList);
//   }

//   double calculateDeterminant(Matrix matrix) {
//     if (!matrix.isSquare) {
//       throw ArgumentError('The matrix must be square to calculate determinant');
//     }

//     final size = matrix.columnCount;
//     if (size == 1) {
//       return matrix[0][0];
//     }

//     double determinant = 0;

//     for (int i = 0; i < size; i++) {
//       final subMatrix = createSubMatrix(matrix, 0, i);
//       determinant +=
//           matrix[0][i] * (i.isEven ? 1 : -1) * calculateDeterminant(subMatrix);
//     }

//     return determinant;
//   }

//   double multivariateNormal(Matrix x, Matrix mean, Matrix covariance) {
//     final threshold = 1e-4;
//     double det = calculateDeterminant(covariance);
//     Matrix invCov = covariance.inverse();
//     Matrix diff = x - mean;
//     Matrix diffT = diff.transpose();

//     Matrix exponent = diff * invCov * diffT * -0.5;
//     double exponent2 = exponent[0][0];

//     if (abs(det) < threshold) {
//       det = 1e-4;
//     }
//     if ((exponent2) > 1e1) {
//         print(exponent2);
//         print("dkalfdksldf");
//         exponent2 = 1e1;
//         print(exponent2);
//     }
//     double temps = exp(exponent2);
//     return (1 / (sqrt(pow(2 * pi, numComponents) * det) + threshold)) * temps;
//   }

//   List<List<double>> eStep(List<Matrix> data) {
//     final n = data.length;
//     final responsibilities =
//         List.generate(n, (_) => List.generate(numComponents, (_) => 0.0));

//     for (var i = 0; i < n; i++) {
//       for (var j = 0; j < numComponents; j++) {
//         responsibilities[i][j] =
//             weights[j] * multivariateNormal(data[i], means[j], covariances[j]);
//       }

//       final sumResp = responsibilities[i].reduce((a, b) => a + b);
//       responsibilities[i] =
//           responsibilities[i].map((resp) => resp / sumResp).toList();
//     }

//     return responsibilities;
//   }

//   void mStep(List<Matrix> data, List<List<double>> responsibilities) {
//     final n = data.length;

//     for (var j = 0; j < numComponents; j++) {
//         double threshold = 1e-5;
//       double respSum = threshold;
//       Matrix respData = data[0] + threshold;
//       Matrix covarianceData = Matrix.scalar(0, dimensions);

//       for (var i = 0; i < n; i++) {
//         respSum += responsibilities[i][j];
//         respData += data[i] * responsibilities[i][j];
//         Matrix diff = data[i] - means[j];
//         Matrix diffT = diff.transpose();

//         // print("\n\nDIFF^2");
//         // print(diffT * diff);
//         // print(covarianceData);

//         covarianceData += (diffT * diff * responsibilities[i][j]);
//       }

//     //   print("RESPSUM");
//     //   print(respSum);
//     //   print(respData);

//       respData -= data[0];

//       weights[j] = respSum / n;
//       means[j] = respData / respSum;
//       covariances[j] = covarianceData / respSum;
//     }
//   }
// }

// void main() {
//   List<Matrix> data2D = [
//     Matrix.fromList([
//       [1.0, 1.1],
//     ]),
//     Matrix.fromList([
//       [1.1, 1.2],
//     ]),
//     Matrix.fromList([
//       [5.3, 5.2],
//     ]),
//     Matrix.fromList([
//       [5.2, 5.1],
//     ]),
//     Matrix.fromList([
//       [5.4, 5.7]
//     ]),
//   ];
//   List<Matrix> means = [
//     Matrix.fromList([
//       [Random().nextDouble(), Random().nextDouble()]
//     ]),
//     Matrix.fromList([
//       [Random().nextDouble(), Random().nextDouble()]
//     ])
//   ];

//   int dim = 2;
//   int numComponents = 2;
//   List<double> weights = [];
// //   List<Matrix> means = [];
//   for (var i = 0; i < dim; i++) {
//     double value = 1 / dim;
//     weights.add(value);


//     // List<double> tmp = [];
//     // for (var j = 0; j < dim; j++) {}
//     //   List<double> tmp2 = [];

//   }

//   List<Matrix> covs = [];
//   for (var i = 0; i < numComponents; i++) {
//     List<double> random = List.generate(dim, (index) => Random().nextDouble());
//     double randomSum = random.reduce((value, element) => value + element);
//     Matrix tmp = Matrix.diagonal(random) / randomSum;
//     print(tmp);
//     print("jjjjjjjjji");
//     covs.add(tmp);
//   }

// //   print("covs");
// //   print(covs);
// //   print("means");
// //   print(means);

// //   print("weights");
// //   print(weights);

//   GMMND gmmnd = GMMND(2, dim, weights, means, covs);

//   double exp = gmmnd.multivariateNormal(data2D[0], means[0], covs[0]);
//   // print(exp);

//   final numIterations = 10;

//   for (var iteration = 0; iteration < numIterations; iteration++) {
//     print(iteration);
//     print(gmmnd.means);
//     print(gmmnd.covariances);
//     print(gmmnd.weights);
//     print("\n");

//     List<List<double>> resp = gmmnd.eStep(data2D);
//     final hi = gmmnd.mStep(data2D, resp);
//   }

//   print("Final output");
//   print(gmmnd.means);
//   print(gmmnd.covariances);
//   print(gmmnd.weights);
// }
