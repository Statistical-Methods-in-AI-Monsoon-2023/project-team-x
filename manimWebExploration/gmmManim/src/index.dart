
import 'package:manim_web/manim.dart';

class GaussianScene extends Scene {
  @override
  FutureOr<void> preload() {
    MathTex.preload(r'Iteration: ');
  }

  @override
  Future construct() async {

  }
}