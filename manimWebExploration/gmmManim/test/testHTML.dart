
import 'dart:html';

void main() {
  // Get a reference to the file input element
  FileUploadInputElement uploadInput = FileUploadInputElement();

  // Listen for changes on the file input element
  uploadInput.onChange.listen((e) {
    final files = uploadInput.files;

    if (files == null) {
      print("sad bhai");
    }

    else if (files.length == 1) {
      final file = files[0];
      final reader = FileReader();

      // Define the callback for when the file is loaded
      reader.onLoad.listen((e) {
        final content = reader.result as String;
        print(content); // Do something with the content here
      });

      // Read the file as text
      reader.readAsText(file);
    }
  });

  // Trigger a click on the input element to open the file picker
  uploadInput.click();
}