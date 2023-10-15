import 'package:manim_web/manim.dart';
import 'dart:developer';

const resolution = 3;

class TestScene extends Scene {
  @override
  Future construct() async {
    Dot blueDot = Dot(ORIGIN);

    // Arrow arrow = Arrow(start: ORIGIN, end: LEFT)
    //   ..nextToMobject(blueDot, direction: RIGHT);

    // arrow.nextToMobject(blueDot, direction: RIGHT);

    // arrow
    //     .addUpdater((mob, dt) => mob..nextToMobject(blueDot, direction: RIGHT));

    Mobject shifter(Mobject mob, double dt) {
      mob..shift(RIGHT * dt);
      // inspect(dt);
      return mob;
    }

    blueDot.addUpdater(shifter);

    await play(ShowCreation(blueDot));
    // await playMany([ShowCreation(blueDot), ShowCreation(arrow)]);
    await play(Transform(blueDot, target: blueDot.copy()..shift(DOWN)));
  }
}
