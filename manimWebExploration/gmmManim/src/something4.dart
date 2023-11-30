import 'dart:math';
import 'dart:convert';
import "package:ml_linalg/linalg.dart" as l;

import 'dart:math';

// Hypothetical function to compute eigenvalues and eigenvectors
// This function should return a Map<String, List<dynamic>> with 'values' and 'vectors' keys
Map<String, List<dynamic>> computeEigen(l.Matrix matrix) {
  // ... Your eigenvalue and eigenvector computation logic ...

  // For the purpose of this example, let's assume eigenvalues and eigenvectors are calculated
  List<double> eigenvalues = [1.0, 2.0];
  List<List<double>> eigenvectors = [
    [0.5, 0.5],
    [0.7, 0.3],
  ];

  return {
    'values': eigenvalues,
    'vectors': eigenvectors,
  };
}

// Function to calculate the covariance matrix
l.Matrix covariance(l.Matrix data) {
  final numRows = data.length;
  final numCols = data[0].length;

  // Calculate the mean of each column
  final mean = List<double>.generate(numCols, (j) => 0.0);
  for (int j = 0; j < numCols; j++) {
    for (int i = 0; i < numRows; i++) {
      mean[j] += data[i][j];
    }
    mean[j] /= numRows;
  }

  // Initialize the covariance matrix
  final covarianceMatrix = List.generate(numCols, (i) => List.filled(numCols, 0.0));

  // Calculate the covariance matrix
  for (int i = 0; i < numCols; i++) {
    for (int j = 0; j < numCols; j++) {
      var sum = 0.0;
      for (int k = 0; k < numRows; k++) {
        sum +=
            (data[k][i] - mean[i]) * (data[k][j] - mean[j]);
      }
      covarianceMatrix[i][j] = sum / (numRows - 1);
    }
  }

  final covarianceMatrix2 = l.Matrix.fromList(covarianceMatrix);

  return covarianceMatrix2;
}

// Function to perform PCA
l.Matrix pca(l.Matrix data, int numComponents) {
  // Calculate the covariance matrix
  final covarianceMatrix = covariance(data);

  // Use the provided computeEigen function to get eigenvalues and eigenvectors
  final eigenResults = computeEigen(covarianceMatrix);
  final eigenvalues = eigenResults['values'] as List<double>;
  print("eigenvalues");
  print(eigenvalues);
  final eigenvectors = eigenResults['vectors'] as List<List<double>>;

  // Sort eigenvalues and eigenvectors in descending order
  final sortedIndices = List.generate(eigenvalues.length, (i) => i);
  sortedIndices
      .sort((a, b) => eigenvalues[b].abs().compareTo(eigenvalues[a].abs()));

  // Select the top numComponents eigenvectors
  final selectedEigenvectors = List<l.Vector>.generate(
    numComponents,
    (i) => l.Vector.fromList(eigenvectors[sortedIndices[i]]),
  );

  // Transform the data using selected eigenvectors
  final transformedData = data * l.Matrix.fromColumns(selectedEigenvectors);

  return transformedData;
}

void main() {
  final data = l.Matrix.fromList([
    [-7.3, -7.2],
    [-7.1, -7.0],
    [-7.2, -7.2],
    [-3.0, -1.0],
    [2.0, 2.5],
    [3.1, 3.3],
    [7.7, 7.9],
    [7.9, 9.0],
  ]);

  // Perform PCA with 1 principal component
  final principalComponents = pca(data, 2);

  // Print the result
  print('Principal Components:');
  print(principalComponents);
}


// void main() {
//   String input = """[[-7.3, -7.2],
//     [-7.1, -7.0],
//     [-7.2, -7.2],
//     [-3.0, -1.0],
//     [2.0, 2.5],
//     [3.1, 3.3],
//     [7.7, 7.9],
//     [7.9, 9.0]]""";

//   input = input.replaceAll(RegExp(r'\s+'), '');
//   List<List<dynamic>> dynamicl.Matrix =
//       json.decode(input).cast<List<dynamic>>();

//   List<List<double>> matrix =
//       dynamicl.Matrix.map((list) => List<double>.from(list)).toList();

//   // Perform PCA with 1 principal component
//   List<l.Vector> principalComponents = pca(matrix, 1);

//   // Print the result
//   print('Principal Components:');
//   principalComponents.forEach((component) => print(component));
// }


// Function to normalize a vector
l.Vector normalize(l.Vector v) {
  double magnitude = sqrt(v.dot(v));
  return v / magnitude;
}

// Function to perform Power Iteration to find the dominant eigenvector
l.Vector powerIteration(l.Matrix matrix, int iterations) {
  int n = matrix.length;
  l.Vector v =
      l.Vector.fromList(List.generate(n, (index) => Random().nextDouble()));

  for (int i = 0; i < iterations; i++) {
    l.Vector Av =
        l.Vector.fromList(List.generate(n, (index) => matrix[index].dot(v)));

    // Normalize the result
    v = normalize(Av);
  }

  return v;
}

// Function to find eigenvalues and eigenvectors for a 2x2 matrix
Map<String, dynamic> eigenDecomposition(l.Matrix matrix, int iterations) {
  int n = matrix.length;

  // Compute eigenvalues
  double trace = matrix[0][0] + matrix[1][1];
  double det = matrix[0][0] * matrix[1][1] - matrix[0][1] * matrix[1][0];

  double discriminant = trace * trace - 4 * det;

  // Check if eigenvalues are real
  if (discriminant >= 0) {
    double lambda1 = (trace + sqrt(discriminant)) / 2;
    double lambda2 = (trace - sqrt(discriminant)) / 2;

    // Compute eigenvectors
    l.Vector v1 =
        l.Vector.fromList([1.0, (lambda1 - matrix[0][0]) / matrix[0][1]]);
    l.Vector v2 =
        l.Vector.fromList([1.0, (lambda2 - matrix[0][0]) / matrix[0][1]]);

    // Normalize eigenvectors
    v1 = normalize(v1);
    v2 = normalize(v2);

    // Iterate to refine eigenvectors
    for (int i = 0; i < iterations; i++) {
      v1 =
          l.Vector.fromList(List.generate(n, (index) => matrix[index].dot(v1)));
      v1 = normalize(v1);

      v2 =
          l.Vector.fromList(List.generate(n, (index) => matrix[index].dot(v2)));
      v2 = normalize(v2);
    }

    return {
      'eigenvalues': [lambda1, lambda2],
      'eigenvectors': [v1, v2],
    };
  } else {
    // Complex eigenvalues are not handled in this basic example
    return {};
  }
}
