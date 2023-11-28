import 'package:manim_web/manim.dart';

class TestingEllipse extends Scene {
  late Axes axes;

  @override
  Future construct() async {
    axes = makeAxes();
    FunctionGraph graph = axes.getGraph( (x) => (x));

    this.add([axes, graph]);
  }

  Axes makeAxes() {
    Axes axesTmp = Axes(
      xMin: -10,
      xMax: 10,
      yMin: -5,
      yMax: 5,
      axisConfig: AxisConfig(
        includeNumbers: true,
        includeTip: true,
      ),
      xAxisConfig: AxisConfig(
          tickFrequency: 1.0,
          unitSize: 0.5,
          includeTip: false,
          includeNumbers: true,
          // numbersToShow: range(start: 1, end: (xRange[1] - xRange[0]).toInt()),
          labelDirection: DOWN),
      yAxisConfig: AxisConfig(
        unitSize: 0.7,
      ),
    )
      ..setColor(color: WHITE)
      ..toCorner(corner: DL);

    return axesTmp;
  }
}
