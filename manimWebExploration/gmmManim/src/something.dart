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

// Function to perform Power Iteration to find the dominant eigenvector
l.Vector powerIteration(l.Matrix matrix, int iterations) {
  int n = matrix.length;

  // Initialize a random vector (initial guess for the eigenvector)
  l.Vector v =
      l.Vector.fromList(List.generate(n, (index) => Random().nextDouble()));

  for (int i = 0; i < iterations; i++) {
    // Multiply the matrix by the vector
    l.Vector Av = l.Vector.fromList(List.generate(n, (index) => matrix[index].dot(v)));

    // Normalize the result
    v = normalize(Av);
  }

  return v;
}

void main() {
  // Example matrix
  l.Matrix matrix = l.Matrix.fromList([
    [1.5, 0.7],
    [0.7, 1.2]
  ]);


  // Perform Power Iteration to find the dominant eigenvector
  l.Vector dominantEigenvector = powerIteration(matrix, 1000);

  // Print the result
  print('Dominant Eigenvector: $dominantEigenvector');
}
