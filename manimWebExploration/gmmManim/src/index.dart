// import 'dart:html' show FileUploadInputElement, FileReader, document, PreElement;
// import 'dart:html';
import 'package:manim_web/manim.dart';
import 'package:http/http.dart' as http;

// import 'dart:io';

class GaussianScene extends Scene {
  @override
  Future construct() async {

  }
}


// void main() {
//   // Create an input element for file selection
//   FileUploadInputElement fileInput = FileUploadInputElement();
//   fileInput.accept = 'text/plain'; // Specify that only text files are allowed
//   fileInput.onChange.listen((e) {
//     final files = fileInput.files;
//     if (files!.length == 1) {
//       final file = files[0];
//       final reader = FileReader();

//       reader.onLoad.listen((e) {
//         final contents = reader.result as String;
//         print(contents);
//       });

//       reader.onError.listen((e) {
//         print('Error reading file');
//       });
 
//       reader.readAsText(file);
//     }
//   });

//   // Add the file input element to the body
//   document.body?.children.add(fileInput);
// }

// void displayContents(String contents) {
//   // Create a pre element to display the file contents
//   PreElement preElement = PreElement();
//   preElement.text = contents;

//   // Add the pre element to the body
//   document.body?.children.add(preElement);
// }