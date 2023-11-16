import 'package:manim_web/manim.dart';

const resolution = 3;

class GaussianScene extends Scene {
  late Axes axes;
  late Axes axes2;
  late Button next;
  List<double> data1 = [3, 6, 8];
  List<double> data2 = [1, 2, 3, 7];
  List<double> means1 = [1, 3, 7];
  List<double> covs1 = [1, 2, 3];
  List<double> means2 = [3, 5, 14];
  List<double> covs2 = [2, 3, 1];
  List<double> xRange = [-5, 20];
  late List<double> gammas;

  @override
  Future construct() async {
    gammas = initializeGammas(means1.length);

    addAxes(xRange);
    // animateAxes2();

    await play(ShowCreation(axes));
    // await play(Transform(axes, target: axes2));
    VGroup gaussians1 = createGaussians(means1, covs1, xRange);

    VGroup dots = createDotsFromData(data1);
    VGroup dots2 = createDotsFromData(data2);
    // animateInitialData(dots);
    await play(ShowCreation(dots));
    await play(ShowCreation(gaussians1));

    VGroup gaussians2 = createGaussians(means2, covs2, xRange);
    await animateData1D(dots, dots2);
    await animateGaussians(gaussians1, gaussians2);
    // await play(Transform(gaussians1, target: gaussians2));
    // await play(Transform(gaussians1, target: gaussians2, runTime: 2));
  }

  VGroup createDotsFromData(List<double> data) {
    List<Dot> dots = [];

    var length = data.length;
    for (var i = 0; i < length; i++) {
      Dot dot = Dot(axes.c2p(Vector3(data[i], 0, 0)), color: BLUE);
      dots.add(dot);
    }
    VGroup dotsVG = VGroup(dots);
    return dotsVG;
  }

  Future animateData1D(VGroup dots, VGroup dots2) async {
    await play(Transform(dots, target: dots2));
  }

  List<double> initializeGammas(int length) {
    List<double> gammas = [];
    double gamma = 1 / length;
    for (var i = 0; i < length; i++) {
      gammas.add(gamma);
    }
    return gammas;
  }

//   void updateGaussians(List<double> data, List<double> means, List<double> covs,
//       List<double> gammas) {
//     // Perform E and M step given data and current mean, covs
//   }

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

  Future animateGaussians(VGroup gaussians1, VGroup gaussians2) async {
    await play(
        Transform(gaussians1, target: gaussians2, lagRatio: 2, runTime: 3));
  }

  VGroup createGaussians(
      List<double> means, List<double> covs, List<double> xRange) {
    List<FunctionGraph> graphs = [];

    var colors = [
      BLUE_E,
      BLUE_D,
      BLUE_C,
      BLUE_B,
      BLUE_A,
      TEAL_E,
      TEAL_D,
      TEAL_C,
      TEAL_B,
      TEAL_A
    ];
    var length = means.length;
    length = min(length, covs.length);
    length = min(length, covs.length);

    for (var i = 0; i < length; i++) {
      FunctionGraph graph = axes.getGraph(
          (x) =>
              (4 / covs[i]) *
              exp(-(((x - means[i]) * (x - means[i])) /
                  (2 * covs[i] * covs[i]))),
          xMin: means[i] - 3 * covs[i],
          xMax: means[i] + 3 * covs[i],
          color: colors[i]);
      graphs.add(graph);
    }
    VGroup graphsVG = VGroup(graphs);
    return graphsVG;
  }

  Axes addAxes(List<double> xRange) {
    axes = Axes(
      xMin: xRange[0],
      xMax: xRange[1],
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
