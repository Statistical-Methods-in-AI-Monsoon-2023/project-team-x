import 'package:manim_web/manim.dart';

class RoundedRectangleScene extends Scene {
  @override
  Future construct() async {
    RoundedRectangle r1 = RoundedRectangle(cornerRadius: 2.0);
    RoundedRectangle r3 = RoundedRectangle(cornerRadius: 4.0)
      ..moveToPoint(Vector3(0.0, 5.0, 0.0));
    RoundedRectangle r2 = RoundedRectangle(width: 2, height: 2)
      ..moveToPoint(Vector3(5.0, 0.0, 0.0));

    Rectangle r4 = Rectangle(height: 3.0, width: 3.0)
      ..moveToPoint(Vector3(0.0, -5.0, 0.0));
    Rectangle r5 = Rectangle(height: 3.0, width: 3.0)
      ..moveToPoint(Vector3(5.0, -5.0, 0.0))
      ..roundCorners(radius: 0.2);

    Polygon p1 = Polygon(
        [Vector3(-5, 1.5, 0), Vector3(-2, 1.5, 0), Vector3(-3.5, -2, 0)]);
    Polygon p2 = Polygon(
        [Vector3(-5, 1.5, 0), Vector3(-2, 1.5, 0), Vector3(-3.5, -2, 0)])
      ..roundCorners(radius: 0.5)
      ..moveToPoint(Vector3(5.0, 0.0, 0.0));

    await play(ShowCreation(p1));
    await play(ShowCreation(p2));
  }
}
