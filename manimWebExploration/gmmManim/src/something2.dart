import 'dart:math';
import 'package:ml_linalg/linalg.dart' as l;

// Function to calculate the dot product of two vectors
double dot(List<double> v1, List<double> v2) {
  double result = 0.0;
  for (int i = 0; i < v1.length; i++) {
    result += v1[i] * v2[i];
  }
  return result;
}

// Function to normalize a vector
l.Vector normalize(l.Vector v) {
  double magnitude = sqrt(v.dot(v));
  return v / magnitude;
}

// Function to find eigenvalues and eigenvectors for a 2x2 matrix
Map<String, dynamic> eigenDecomposition(
    l.Matrix matrix, int iterations) {
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
    l.Vector v1 = l.Vector.fromList([1.0, (lambda1 - matrix[0][0]) / matrix[0][1]]);
    l.Vector v2 = l.Vector.fromList([1.0, (lambda2 - matrix[0][0]) / matrix[0][1]]);

    // Normalize eigenvectors
    v1 = normalize(v1);
    v2 = normalize(v2);

    // Iterate to refine eigenvectors
    for (int i = 0; i < iterations; i++) {
      v1 = l.Vector.fromList(List.generate(n, (index) => matrix[index].dot(v1)));
      v1 = normalize(v1);

      v2 = l.Vector.fromList(List.generate(n, (index) => matrix[index].dot(v2)));
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

void main() {
  // Example matrix
  l.Matrix matrix = l.Matrix.fromList([
  [1.5, 0.7],
    [0.7, 1.2]
  ]);
  // Perform eigen decomposition
  // Map<String, dynamic> result = eigenDecomposition(matrix, 1000);

  // Print the results
  // print('Eigenvalues: ${result['eigenvalues']}');
  // print('Eigenvectors: ${result['eigenvectors']}');
  double abs(double x) {
    return (x > 0) ? x : -x;
  }

  print(abs(2));
  print(abs(-2));
}
