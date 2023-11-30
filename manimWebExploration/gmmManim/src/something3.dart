import 'dart:convert';

void main() {
  String input = """[[-7.3, -7.2, 6.5],
    [-7.1, -7.0, 6.2],
    [-7.2, -7.2, 6.5]]""";

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
