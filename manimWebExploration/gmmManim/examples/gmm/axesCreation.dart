import 'package:manim_web/manim.dart';

const resolution = 3;

class GaussianScene extends Scene {
  late Axes timeAxes;
  late Axes timeAxes2;

  @override
  Future construct() async {
    addTimeAxes();
    animateTimeAxis();

    await play(ShowCreation(timeAxes));
    await play(Transform(timeAxes, target: timeAxes2));
    // await play(timeAxes)
  }

  // FunctionGraph addPoints() {

  // }

  Axes addTimeAxes() {
    timeAxes = Axes(
      xMin: 0,
      xMax: 10,
      yMin: 0,
      yMax: 1,
      xAxisConfig: AxisConfig(
        tickFrequency: 0.5,
        // numbersWithElongatedTicks: [0, 1, 2, 3, 4],
        // numbersWithElongatedTicks: [2, 4, 6, 8],
        includeTip: false,
        // unitSize: 10,
      ),
      yAxisConfig: AxisConfig(
        unitSize: 0.5,
        // numbersWithElongatedTicks: [2, 4, 6, 8],
      ),
      axisConfig: AxisConfig(
        includeTip: false,
      ),
    )
      ..setColor(color: WHITE)
      ..toCorner(corner: UL);

    // TODO Add labels

    return timeAxes;
  }

  Axes animateTimeAxis() {
    timeAxes2 = Axes(
      xMin: 0,
      xMax: 10,
      yMin: 0,
      yMax: 10,
      xAxisConfig: AxisConfig(
        tickFrequency: 0.5,
        // numbersWithElongatedTicks: [0, 1, 2, 3, 4],
        numbersWithElongatedTicks: [2, 4, 6, 8],
        includeTip: false,
        // unitSize: 10,
      ),
      yAxisConfig: AxisConfig(
        unitSize: 0.5,
        includeTip: false,
        // numbersWithElongatedTicks: [2, 4, 6, 8],
      ),
      axisConfig: AxisConfig(
        includeTip: false,
      ),
    )
      ..setColor(color: WHITE)
      ..toCorner(corner: UL);

    // TODO Add labels

    return timeAxes2;
  }
}
