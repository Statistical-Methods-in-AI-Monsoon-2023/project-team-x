import 'package:manim_web/manim.dart';

const resolution = 3;

class GaussianScene extends Scene {
  late Axes axes;
  late Axes axes2;
  late Button next;
  List<double> data1 = [3, 6, 8];
  List<double> data2 = [1, 2, 3, 7];
  List<double> means = [1, 3, 7];
  List<double> covs = [1, 2, 3];

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

    VGroup dots = addDataPoints(data1);
    VGroup dots2 = addDataPoints(data2);
    createData1D(dots);

    await playMany([ShowCreation(graph), ShowCreation(graph2)]);
    animateData1D(dots, dots2);
  }

  VGroup addDataPoints(List<double> data) {
    List<Dot> dots = [];
    for (var i = 0; i < data.length; i++) {
      Dot dot = Dot(axes.c2p(Vector3(data[i], 0, 0)), color: BLUE);
      dots.add(dot);
      //   await play(ShowCreation(dot));
    }
    VGroup vg = VGroup(dots);
    return vg;
  }

  Future createData1D(VGroup dots) async {
    // await playMany([for (VMobject dot in dots) ShowCreation(dot)]);
    await play(ShowCreation(dots));
  }

  Future animateData1D(VGroup dots, VGroup dots2) async {
    await play(Transform(dots, target: dots2));
  }

//   List<FunctionGraph> makeGraphs() {

//   }

//     FunctionGraph updateGaussians() {

//     }

//   Button makeButton() {
//     Circle circle = Circle(
//         arcCenter: ORIGIN,
//         radius:1,
//         color: WHITE);
//     next = Button(
//         mob: circle,
//         onClick:
//     );

//     return next;
//   }

  Axes addAxes() {
    axes = Axes(
      xMin: -5,
      xMax: 20,
      yMin: -1,
      yMax: 10,
      xAxisConfig: AxisConfig(
        tickFrequency: 1.0,
        unitSize: 0.5,
        includeTip: false,
      ),
      yAxisConfig: AxisConfig(
        unitSize: 0.7,
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
}
