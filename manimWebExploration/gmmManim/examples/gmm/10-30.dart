import 'package:manim_web/manim.dart';
import 'package:gmm/gmm.dart';

// import "./src/utilityFunctions.dart";
// import "src/utilityFunctions.dart";
List<double> initializeWeights(int length) {
  return List.generate(length, (index) => 1 / length);
}

class GaussianScene extends Scene {
  late Axes axes;
  late Axes axes2;
  late Button next;
  late Dot dot;
  late GMM1D gmm;
  late List<double> weights;
  late List<FunctionGraph> gaussians1;
  late List<FunctionGraph> gaussians2;
  late VGroup dots;
  late VGroup dots2;

  int state = 0;
  int initialN = 3;

  List<double> data1 = [3, 6, 8];
  List<double> data2 = [1, 2, 3];
  List<double> means1 = [1, 3, 7];
  List<double> covs1 = [1, 2, 3];

  List<double> xRange = [-5, 20];
  late List<double> gammas;

  @override
  Future construct() async {
    // GMM Initializations
    List<double> weights = initializeWeights(initialN);
    gmm = GMM1D(initialN, weights, means1, covs1);

    // Creating Premade Manim Objects
    addAxes(xRange);
    List<FunctionGraph> gaussians1 = createGaussians(means1, covs1, xRange);
    VGroup dots = createDotsFromData(data1);
    VGroup dots2 = createDotsFromData(data2);
    AnimationGroup ag = createInitialGaussianAnimations(gaussians1);
    Button b = makeUpdateGaussianButton();

    // ANIMATIONS

    // Axes & Data
    await play(ShowCreation(axes));
    await play(ShowCreation(dots));
    await play(ag);

    makeDot();
    await play(ShowCreation(b));

    // HANDLE INTERACTION
    await continueRendering();
  }

  // Handles all subsequent rendering and triggered animations
  Future continueRendering() async {
    while (true) {
      if (state == 1) {
        // updateGaussian here
        // updateGaussian();
        // await transformGaussians(gaussians1, gaussians2);

        // List<Animation> ag1 = [];
        // List<double> means2 = [3, 4, 5];
        // List<double> covs2 = [4, 1, 3];

        // List<FunctionGraph> gaussians3 = createGaussians(means2, covs2, xRange);

        // for (var i = 0; i < means1.length; i++) {
        //   ag1.add(Transform(gaussians1[i],
        //       target: gaussians3[i], lagRatio: 2, runTime: 2));
        // }
        // AnimationGroup ag = AnimationGroup(ag1);
        // await play(ag);
        VGroup dots3 = createDotsFromData(data2);
        await animateData1D(dots, dots3);

        state = 0;
      } else {
        await wait();
      }
    }
  }

  // FUNCTIONS

  // Making Objects
  Dot makeDot() {
    dot = Dot(Vector3(3, 3, 0), radius: 0.1, color: RED);
    return dot;
  }

  void changeDot() {
    Dot dot2 = Dot(Vector3(2, 2, 0), radius: 2, color: GREEN);
    dot.become(dot2);
  }

  void doGaussian() {
    state = 1;
  }

  Future updateGaussian1() async {
    List<List<double>> resp = gmm.eStep(data1);
    final hi = gmm.mStep(data1, resp);

    means1 = gmm.means;
    covs1 = gmm.variances;
    weights = gmm.weights;

    List<FunctionGraph> gaussians2 = createGaussians(means1, covs1, xRange);
    await transformGaussians(gaussians1, gaussians2);
  }

  void updateGaussian() async {
    List<List<double>> resp = gmm.eStep(data1);
    final hi = gmm.mStep(data1, resp);

    means1 = gmm.means;
    covs1 = gmm.variances;
    weights = gmm.weights;

    List<FunctionGraph> gaussians2 = createGaussians(means1, covs1, xRange);
    // await transformGaussians(gaussians1, gaussians2);
    state = 2;
  }

  Button makeUpdateGaussianButton() {
    Dot circle = Dot(Vector3(1, 1, 0), radius: 0.08, color: WHITE);
    Button next = Button(mob: circle, onClick: doGaussian);
    return next;
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

  List<FunctionGraph> createGaussians(
      List<double> means, List<double> covs, List<double> xRange) {
    List<FunctionGraph> graphs = [];

    var colors = [
      BLUE_E,
      YELLOW,
      ORANGE,
      GREEN_A,
      PURPLE,
      PINK,
      GRAY,
      TEAL_C,
      TEAL_B,
      TEAL_A
    ];
    var length = means.length;
    length = min(length, covs.length);
    length = min(length, covs.length);
    var threshold = 0.3;
    var stepSize = 0.1;

    for (var i = 0; i < length; i++) {
      if (covs[i] < 2) {
        stepSize = 0.1;
      } else {
        stepSize = 0.3;
      }

      FunctionGraph graph = axes.getGraph(
          (x) =>
              (4 / covs[i]) *
              exp(-(((x - means[i]) * (x - means[i])) /
                  (2 * covs[i] * covs[i]))),
          xMin: means[i] - 3 * covs[i],
          xMax: means[i] + 3 * covs[i],
          color: colors[i],
          stepSize: stepSize);
      graphs.add(graph);
    }
    return graphs;
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

  // Create Animations
  AnimationGroup createInitialGaussianAnimations(
      List<FunctionGraph> gaussians) {
    List<Animation> ag1 = [];
    for (var i = 0; i < means1.length; i++) {
      ag1.add(ShowCreation(gaussians[i]));
    }
    AnimationGroup ag = AnimationGroup(ag1);
    return ag;
  }

  AnimationGroup transformGaussians(
      List<FunctionGraph> gaussians1, List<FunctionGraph> gaussians2) {
    List<Animation> ag1 = [];
    for (var i = 0; i < means1.length; i++) {
      ag1.add(Transform(gaussians1[i],
          target: gaussians2[i], lagRatio: 2, runTime: 2));
    }
    AnimationGroup ag = AnimationGroup(ag1);
    return ag;
  }

  Future animateData1D(VGroup dots, VGroup dots2) async {
    await play(Transform(dots, target: dots2));
  }

  // Animates the Gaussian Functions given the initial and target gaussians
  Future animateGaussians(VGroup gaussians1, VGroup gaussians2) async {
    await play(
        Transform(gaussians1, target: gaussians2, lagRatio: 1, runTime: 2));
  }
}
