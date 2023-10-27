import 'package:manim_web/manim.dart';
// import "./src/utilityFunctions.dart";

const resolution = 3;

class TestScene extends Scene {
  double time = 0;
  Dot blueDot = Dot(ORIGIN);
  Dot redDot = Dot(Vector3(-1, -1, 0), color: RED);
  late Dot dot2;
  var state = 0;

  @override
  Future construct() async {
    void updateOther() {
      state = 1;
    }

    void changeDot() {
      Dot dot2 = Dot(Vector3(2, 2, 0), radius: 0.2, color: GREEN);
      blueDot.become(dot2);
    }

    Button makeButton() {
      Dot circle = Dot(Vector3(1, 1, 0), radius: 0.1, color: WHITE);
      Button next = Button(mob: circle, onClick: updateOther);
      return next;
    }

    Future continueRendering() async {
      while (true) {
        if (state == 1) {
          await play(ShowCreation(dot2));
          state = 0;
        } else {
          await wait();
        }
      }
    }

    // Arrow arrow = Arrow(start: ORIGIN, end: LEFT);
    Arrow arrow = Arrow(start: ORIGIN, end: RIGHT);
    arrow.nextToMobject(blueDot, direction: LEFT);

    arrow.addUpdater((mob, dt) => mob..nextToMobject(blueDot, direction: LEFT));

    Mobject shifter(Mobject mob, double dt) {
      time += dt;
      return mob..shift(RIGHT * sin(time) / 100);
    }

    blueDot.addUpdater(shifter);
    // blueDot.addUpdater((mob, dt) => mob..shift(Vector3(dt, 0, 0)));

    // await play(ShowCreation(blueDot));
    Button b = makeButton();
    dot2 = Dot(Vector3(2, 2, 0), radius: 0.2, color: GREEN);

    await playMany([
      ShowCreation(b),
      ShowCreation(redDot),
      ShowCreation(blueDot),
      ShowCreation(arrow)
    ]);

    await play(Transform(blueDot, target: blueDot.copy()..shift(DOWN)));
    await continueRendering();
    // await play(Transform(blueDot, target: dot2));
    await play(ShowCreation(dot2));
  }
}
