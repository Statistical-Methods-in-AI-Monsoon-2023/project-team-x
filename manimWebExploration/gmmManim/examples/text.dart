import 'package:manim_web/manim.dart';

class ExampleScene extends Scene {
  @override
  FutureOr<void> preload() {
    Tex.preload('Hello World!');
  }

  @override
  FutureOr<void> construct() async {
    var tex = Tex('Hello World!');

    tex.scaleUniformly(4);

    await play(FadeIn(tex));
  }
}
