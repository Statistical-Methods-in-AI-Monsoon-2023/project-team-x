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
  late VGroup gaussians1;
  late VGroup gaussians2;
  late VGroup gaussians3;

  int state = 0;
  int initialN = 3;

  // List<double> data1 = [1.1, 0.6, 1.3, 1.1, 5.2, 4.7, 5.1, 5.3, 5.2, 12.3, 12.1, 12.9, 12.4, 12];
  List<double> data1 = [1.1, 0.6, 1.3, 1.1, 5.2, 4.7, 5.1, 5.3, 5.2, 12.3, 12.1, 12.9, 12.4, 12];
  List<double> data2 = [1, 2, 3];
  List<double> means1 = [1, 3, 7];
  List<double> covs1 = [1, 2, 3];
  List<double> means2 = [3, 2, 4];
  List<double> covs2 = [3, 2, 1];

  List<double> xRange = [-5, 20];
  late List<double> gammas;

  @override
  Future construct() async {
    // GMM Initializations
    List<double> weights = initializeWeights(initialN);
    gmm = GMM1D(initialN, weights, means1, covs1);

    // Creating Premade Manim Objects
    addAxes(xRange);
    gaussians1 = createGaussians(means1, covs1, xRange);
    gaussians3 = createGaussians(means2, covs2, xRange);
    VGroup dots = createDotsFromData(data1);
    VGroup dots2 = createDotsFromData(data2);
    Animation ag = createInitialGaussianAnimations(gaussians1);
    Button b = makeUpdateGaussianButton();

    // ANIMATIONS

    // Axes & Data
    await play(ShowCreation(axes));
    await play(ShowCreation(dots));
    await play(ag);

    makeDot();
    // await play(ShowCreation(dot));
    await play(ShowCreation(b));

    // await play(Transform(gaussians1, target:gaussians3));
    // gaussians1.become(gaussians3);

    // HANDLE INTERACTION
    await continueRendering();
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

  Future updateGaussian() async {
    List<List<double>> resp = gmm.eStep(data1);
    final temp = gmm.mStep(data1, resp);

    List<double> means2 = gmm.means;
    List<double> covs2 = gmm.variances;

    print("means & covs");
    print(means2);
    print(covs2);
    // print(weights);
    // List<double> means3 = [2, 3, 1];
    // List<double> covs3 = [4, 3, 2];
    // weights = gmm.weights;

    gaussians3 = createGaussians(means2, covs2, xRange);
    await play(Transform(gaussians1, target:gaussians3));
    // gaussians1.become(gaussians2);
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

  VGroup createGaussians(List<double> means, List<double> covs, List<double> xRange) {
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
      if (covs[i] < 0.8) {
        covs[i] = 0.8;
      }

      if (covs[i] > 3) {
        covs[i] = 3;
      }

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
    return VGroup(graphs);
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
  Animation createInitialGaussianAnimations(VGroup gaussians) {
    return ShowCreation(gaussians);
  }

  // AnimationGroup transformGaussians(
  //     List<FunctionGraph> gaussians1, List<FunctionGraph> gaussians2) {
  //   return
  // }

  Future animateData1D(VGroup dots, VGroup dots2) async {
    await play(Transform(dots, target: dots2));
  }

  // Animates the Gaussian Functions given the initial and target gaussians
  Future animateGaussians(VGroup gaussians1, VGroup gaussians2) async {
    await play(
        Transform(gaussians1, target: gaussians2, lagRatio: 1, runTime: 2));
  }

  void transformGaussians() async {
    // await play(Transform(gaussians1, target: gaussians3)); // YIPEEEE
    gaussians1.become(gaussians3);
  }

  // Handles all subsequent rendering and triggered animations
  Future continueRendering() async {
    while (true) {
      if (state == 1) {
        // updateGaussian here
        // updateGaussian();
        // changeDot();
        // await play(ShowCreation(dot)); // WORKS FINALLY
        // await play(Transform(gaussians1, target: gaussians3)); // YIPEEEE
        await updateGaussian();
        state = 0;
      } else {
        await wait();
      }
    }
  }
}
