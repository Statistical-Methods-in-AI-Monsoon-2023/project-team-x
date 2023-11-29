import 'dart:convert';

void main() {
  String input = """[[-7.3, -7.2],
    [-7.1, -7.0],
    [-7.2, -7.2],
    [-3.0, -1.0],
    [2.0, 2.5],
    [3.1, 3.3],
    [7.7, 7.9],
    [7.9, 9.0]]""";

  // Remove unnecessary whitespaces and line breaks
  input = input.replaceAll(RegExp(r'\s+'), '');
  // print(input);
  // Parse the JSON string
  List<List<dynamic>> dynamicMatrix = json.decode(input).cast<List<dynamic>>();

  // Convert the inner lists to List<double>
  List<List<double>> matrix =
      dynamicMatrix.map((list) => List<double>.from(list)).toList();
  print(matrix);

  // // Print the parsed matrix
  // print(matrix);
}
