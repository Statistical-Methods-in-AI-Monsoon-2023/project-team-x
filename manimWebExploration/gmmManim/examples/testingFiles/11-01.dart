import 'package:manim_web/manim.dart';
// import 'dart:io';
import 'dart:html';



class GaussianScene extends Scene {

  @override
  Future construct() async {

    // var file = File('./assets/data.txt');
    // print(file);

    Dot d1 = Dot(Vector3(1.0, 1.0, 1.0), color: GREEN);
    Dot d2 = Dot(Vector3(1.0, 2.0, 1.0), color: GREEN);

    await play(ShowCreation(d1));
    // await play(ShowCreation(d2));
  }


}
