                import 'dart:html';
          import 'package:manim_web/display/abstract_html_display.dart';
        
      import 'package:manim_web/manim.dart';
import 'package:ml_linalg/linalg.dart' as l;
import "dart:math";


class TestingEllipse extends Scene {
  late Axes axes;

  var colors = [
    BLUE_E,
    YELLOW,
    ORANGE,
    GREEN_A,
    PURPLE,
    PINK,
    GRAY,
    TEAL_C,
    GREEN_B,
    BLUE_C,
    TEAL_B,
    DARK_GRAY,
    PURPLE_C,
    YELLOW_B,
    BLUE_A,
  ];

  @override
  Future construct() async {
    axes = makeAxes();

    List<l.Matrix> means = [l.Matrix.fromList([[0.0, 1.0]]), l.Matrix.fromList([[-2, -4]])];
    List<l.Matrix> covariances = [l.Matrix.fromList([[1.5, 0.7], [0.7, 1.2]]), l.Matrix.fromList([[4.0, -2.0], [1.0, 1.0]])];

    VGroup ellipses = makeEllipses(covariances, means);

    this.add([axes, ellipses]);
  }

  VGroup makeEllipses(List<l.Matrix> covs, List<l.Matrix> means) {
    List<Ellipse> ellipses = [];
    for (var covIndex = 0; covIndex < covs.length; covIndex++) {
      l.Matrix meanMatrix = means[covIndex];
      l.Matrix covarianceMatrix = covs[covIndex];
      l.Vector dominantEigenvector = powerIteration(covarianceMatrix, 1000);
      double angle = atan2(dominantEigenvector[1], dominantEigenvector[0]);
      Map<String, dynamic> result = eigenDecomposition(covarianceMatrix, 1000);
      List<double> eigenvalues = result["eigenvalues"];

      if (eigenvalues.length < 2) {
        print("Eigenvalue list Failure");
        return VGroup(ellipses);
      }

      double semimajorLength = sqrt(max(eigenvalues[0], eigenvalues[1]));
      double semiminorLength = sqrt(min(eigenvalues[0], eigenvalues[1]));

      print(covIndex);
      print(semiminorLength);
      print(semimajorLength);

      Ellipse e1 = Ellipse(height: semiminorLength, width: semimajorLength, color: colors[covIndex])
        // ..center()..shift(Vector3(-1.63, 0.0, 0.0));
        ..rotate(-angle)
        ..moveToPoint(axes.getCenter() - Vector3(0.0, 0.05, 0.0) + Vector3(0.5 * meanMatrix[0][0], 0.70 * meanMatrix[0][1], 0.0));
      // ..center(mask: Vector3(0.1, 0.1, 0.1));
      e1.fillColors = [TRANSPARENT];

      ellipses.add(e1);
    }

    return VGroup(ellipses);
  }

  double abs(double x) {
    return (x > 0) ? x : -x;
  }
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
        v1 = l.Vector.fromList(
            List.generate(n, (index) => matrix[index].dot(v1)));
        v1 = normalize(v1);

        v2 = l.Vector.fromList(
            List.generate(n, (index) => matrix[index].dot(v2)));
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

  Axes makeAxes() {
    Axes axesTmp = Axes(
      xMin: -10,
      xMax: 10,
      yMin: -5,
      yMax: 5,
      axisConfig: AxisConfig(
        includeNumbers: true,
        includeTip: true,
      ),
      xAxisConfig: AxisConfig(
          tickFrequency: 1.0,
          unitSize: 0.5,
          includeTip: false,
          includeNumbers: true,
          labelDirection: DOWN),
      yAxisConfig: AxisConfig(
        unitSize: 0.7,
      ),
    )
      ..setColor(color: WHITE)
      ..toCorner(corner: DL);

    return axesTmp;
  }
}


      void main(){
        



        var display = Canvas2DDisplay(document.getElementById('canvas-container')!);
        var scene = TestingEllipse()..bindDisplay(display);

        scene.run();
      }
    