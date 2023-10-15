import 'package:manim_web/manim.dart';

const resolution = 3;

class GaussianScene extends Scene {
  late Axes axes;
  late Axes axes2;
  var data = [3, 6, 8];

  @override
  Future construct() async {
    addAxes();
    // animateAxes2();

    await play(ShowCreation(axes));
    // await play(Transform(axes, target: axes2));
    FunctionGraph graph = axes.getGraph((x) => 5 * exp(-(x * x)),
        xMin: -5, xMax: 5, color: YELLOW);
    FunctionGraph graph2 = axes.getGraph((x) => 2 * exp(-((x - 3) * (x - 3))),
        xMin: -5, xMax: 5, color: ORANGE);

    await playMany([ShowCreation(graph), ShowCreation(graph2)]);
    // await play(ShowCreation(graph2));
    // await play(Transform(graph, target: graph2));
  }

  // FunctionGraph addPoints() {

  // }

  Axes addAxes() {
    axes = Axes(
      xMin: -5,
      xMax: 5,
      yMin: 0,
      yMax: 10,
      xAxisConfig: AxisConfig(
        tickFrequency: 0.5,
        includeTip: false,
      ),
      yAxisConfig: AxisConfig(
        unitSize: 0.5,
      ),
      axisConfig: AxisConfig(
        includeTip: false,
      ),
    )
      ..setColor(color: WHITE)
      ..toCorner(corner: UL);

    // TODO Add labels

    return axes;
  }

  Axes animateAxes2() {
    axes2 = Axes(
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

    return axes2;
  }
}
