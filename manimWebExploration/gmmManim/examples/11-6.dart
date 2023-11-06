// Code for 1D Main Function

// void main() {
//   var display = Canvas2DDisplay(document.getElementById('canvas-container')!);
//   GaussianScene gs = GaussianScene();

//   // Create an input element for file selection
//   // Only Text or csv files are allowed
//   // Comma separated list of double values
//   InputElement fileInput = document.getElementById("fileInput") as InputElement;
//   Element contentUpload = document.getElementById("uploadedContent") as Element;
//   fileInput.accept = 'text/plain';

//   fileInput.onChange.listen((e) {
//     final files = fileInput.files;
//     if (files!.length == 1) {
//       final file = files[0];
//       final reader = FileReader();

//       reader.onLoad.listen((e) {
//         final contents = reader.result as String;
//         print(contents);

//         List<String> contents2 = contents.split(",");
//         List<double> contents3 = [];
//         for (var i = 0; i < contents2.length; i++) {
//           contents3.add(double.parse(contents2[i]));
//         }

//         contentUpload.setInnerHtml(contents3.toString());

//         gs.setData(contents3);
//         var scene = gs..bindDisplay(display);
//         scene.run();
//       });

//       reader.onError.listen((e) {
//         print('Error reading file');
//       });

//       reader.readAsText(file);
//     }
//   });

//   var scene = gs..bindDisplay(display);
//   scene.run();
// }
