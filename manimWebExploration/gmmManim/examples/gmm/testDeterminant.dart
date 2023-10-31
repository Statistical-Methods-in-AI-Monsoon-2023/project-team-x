import 'package:ml_linalg/linalg.dart';

Matrix createSubMatrix(Matrix matrix, int row, int col) {
  final subList = List.generate(
      matrix.rowCount - 1,
      (i) => List.generate(matrix.columnCount - 1, (j) {
            final rowIndex = i < row ? i : i + 1;
            final colIndex = j < col ? j : j + 1;
            return matrix[rowIndex][colIndex];
          }));

  return Matrix.fromList(subList);
}

double calculateDeterminant(Matrix matrix) {
  if (!matrix.isSquare) {
    throw ArgumentError('The matrix must be square to calculate determinant');
  }

  final size = matrix.columnCount;
  if (size == 1) {
    return matrix[0][0];
  }

  double determinant = 0;

  for (int i = 0; i < size; i++) {
    final subMatrix = createSubMatrix(matrix, 0, i);
    determinant +=
        matrix[0][i] * (i.isEven ? 1 : -1) * calculateDeterminant(subMatrix);
  }

  return determinant;
}

void main() {
  final matrix = Matrix.fromList([
    [1, 2.5, 3],
    [4, 5.5, 6],
    [7, 8, 9]
  ]);

  final determinant = calculateDeterminant(matrix);

  print('Determinant: $determinant');
}
