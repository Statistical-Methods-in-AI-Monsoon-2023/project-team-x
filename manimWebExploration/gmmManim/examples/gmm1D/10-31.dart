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
  late VGroup currentGMM;
  late VGroup gaussians2;
  late VGroup nextGMM;
  late List<double> means1;
  late List<double> covs1;

  int state = 0;
  int iteration = 0;
  int initialN = 3;
  double lowerCovsThreshold = 0.8;
  double upperCovsThreshold = 3;

  // List<double> data1 = [1.1, 0.6, 1.3, 1.1, 5.2, 4.7, 5.1, 5.3, 5.2, 12.3, 12.1, 12.9, 12.4, 12];
  List<double> data1 = [
    1.1,
    0.6,
    1.3,
    1.1,
    5.2,
    4.7,
    5.1,
    5.3,
    5.2,
    12.3,
    12.1,
    12.9,
    12.4,
    12
  ];
  List<double> data2 = [1, 2, 3];
  List<double> initialMeans = [1, 3, 7];
  List<double> initialCovs = [1, 2, 3];

  List<double> xRange = [-5, 20];
  late List<double> gammas;

  @override
  FutureOr<void> preload() {
    Tex.preload(r'\gets');
    Tex.preload(r'\to');
    Tex.preload(r'Reset');
    // Tex.preload(r' blacktriangleright ');
  }

  @override
  Future construct() async {
    List<double> means1 = new List<double>.from(initialMeans);
    List<double> covs1 = new List<double>.from(initialCovs);
    // GMM Initializations
    List<double> weights = initializeWeights(initialN);
    gmm = GMM1D(initialN, weights, means1, covs1);

    // Creating Premade Manim Objects
    addAxes(xRange);
    currentGMM = createGMM(means1, covs1, xRange);
    VGroup dots = createDotsFromData(data1);
    VGroup dots2 = createDotsFromData(data2);
    Animation ag = createInitialGMMAnimations(currentGMM);
    Button b1 = makeUpdateGMMButton();
    Button b2 = makeResetGMMButton();
    Button b3 = playGMMButton();
    Button b4 = makePrevGMMButton();

    // ANIMATIONS

    // Axes & Data
    await play(ShowCreation(axes));
    await play(ShowCreation(dots));
    await play(ag);

    makeDot();
    await playMany([
      ShowCreation(b1),
      ShowCreation(b2),
      ShowCreation(b3),
      ShowCreation(b4)
    ]);

    // HANDLE INTERACTION
    await continueRendering();
  }

  // FUNCTIONS
  // MAKING OBJECTS

  // DEBUGGING OBJECTS
  Dot makeDot() {
    dot = Dot(Vector3(3, 3, 0), radius: 0.1, color: RED);
    return dot;
  }

  void changeDot() {
    Dot dot2 = Dot(Vector3(2, 2, 0), radius: 2, color: GREEN);
    dot.become(dot2);
  }

  Future prevGMMIteration() async {
    iteration--;
    List<double> weights = initializeWeights(initialN);
    List<double> means1 = new List<double>.from(initialMeans);
    List<double> covs1 = new List<double>.from(initialCovs);

    gmm = GMM1D(initialN, weights, means1, covs1);

    for (var i = 0; i < iteration; i++) {
      List<List<double>> resp = gmm.eStep(data1);
      final temp = gmm.mStep(data1, resp);
    }

    List<double> means2 = gmm.means;
    List<double> covs2 = gmm.variances;

    // gmm = gmm2;

    print("means & covs");
    print(iteration);
    print(means2);
    print(covs2);
    // print(weights);
    // List<double> means3 = [2, 3, 1];
    // List<double> covs3 = [4, 3, 2];
    // weights = gmm.weights;

    nextGMM = createGMM(means2, covs2, xRange);
    await play(Transform(currentGMM, target: nextGMM));
    // currentGMM.become(gaussians2);
  }

  Future nextGMMIteration() async {
    List<List<double>> resp = gmm.eStep(data1);
    final temp = gmm.mStep(data1, resp);
    iteration++;

    List<double> means2 = gmm.means;
    List<double> covs2 = gmm.variances;

    print("means & covs");
    print(iteration);

    print(means2);
    print(covs2);
    // print(weights);
    // List<double> means3 = [2, 3, 1];
    // List<double> covs3 = [4, 3, 2];
    // weights = gmm.weights;

    nextGMM = createGMM(means2, covs2, xRange);
    await play(Transform(currentGMM, target: nextGMM));
    // currentGMM.become(gaussians2);
  }

  Future resetGMM() async {
    List<double> weights = initializeWeights(initialN);
    List<double> means1 = new List<double>.from(initialMeans);
    List<double> covs1 = new List<double>.from(initialCovs);

    print(means1);
    print(covs1);
    gmm = GMM1D(initialN, weights, means1, covs1);
    iteration = 0;
    nextGMM = createGMM(means1, covs1, xRange);

    await play(Transform(currentGMM, target: nextGMM));
  }

  Future playGMM() async {
    List<List<double>> resp = gmm.eStep(data1);
    final temp = gmm.mStep(data1, resp);
    iteration++;
    print(iteration);

    List<double> means2 = gmm.means;
    List<double> covs2 = gmm.variances;

    bool hasConverged = isConverged(covs2);
    print("convergence");
    print(hasConverged);
    if (hasConverged) state = 0;

    nextGMM = createGMM(means2, covs2, xRange);
    await play(Transform(currentGMM, target: nextGMM));
  }

  void nextGMMUpdater() {
    state = 1;
  }

  void resetGMMUpdater() {
    print("state");
    print(state);
    state = 2;
  }

  void playGMMUpdater() {
    state = 3;
  }

  void prevGMMUpdater() {
    state = 4;
  }

  Button playGMMButton() {
    // Mobject obj = RoundedRectangle(cornerRadius: 0.5, height: 2.0, width: 4.0);
    // Mobject obj = RoundedRectangle(cornerRadius: 0.5);
    // RoundedRectangle r = RoundedRectangle(cornerRadius: 0.3, height: 1.0, width: 2.0);
    Rectangle r2 = Rectangle(height: 0.5, width: 0.8);
    // Tex tex = Tex(r' blacktriangleright ', color: BLACK);
    // tex.scaleUniformly(0.5);
    Triangle tri = Triangle(color: GREEN);
    tri
      ..scale(Vector3(0.18, 0.18, 1))
      ..rotate(PI / 2);
    tri..shift(DOWN / 4);
    VGroup playGMMButtonGroup = VGroup([tri, r2]);
    playGMMButtonGroup..moveToPoint(Vector3(5.5, 1.0, 0.0));
    playGMMButtonGroup..scale(Vector3(0.5, 0.5, 1));

    Button playButton =
        Button(mob: playGMMButtonGroup, onClick: playGMMUpdater);
    return playButton;
  }

  Button makePrevGMMButton() {
    // Mobject obj = RoundedRectangle(cornerRadius: 0.5, height: 2.0, width: 4.0);
    // Mobject obj = RoundedRectangle(cornerRadius: 0.5);
    // RoundedRectangle r = RoundedRectangle(cornerRadius: 0.3, height: 1.0, width: 2.0);
    Rectangle r2 = Rectangle(height: 0.5, width: 1.0);
    MathTex tex = MathTex(r'\gets');
    tex.scaleUniformly(0.5);
    VGroup prevIterationButton = VGroup([tex, r2]);
    prevIterationButton..moveToPoint(Vector3(5.5, 0.0, 0.0));

    Button prev = Button(mob: prevIterationButton, onClick: prevGMMUpdater);
    return prev;
  }

  Button makeUpdateGMMButton() {
    // Mobject obj = RoundedRectangle(cornerRadius: 0.5, height: 2.0, width: 4.0);
    // Mobject obj = RoundedRectangle(cornerRadius: 0.5);
    // RoundedRectangle r = RoundedRectangle(cornerRadius: 0.3, height: 1.0, width: 2.0);
    Rectangle r2 = Rectangle(height: 0.5, width: 1.0);
    MathTex tex = MathTex(r'\to');
    tex.scaleUniformly(0.5);
    VGroup nextIterationButton = VGroup([tex, r2]);
    nextIterationButton..moveToPoint(Vector3(5.5, 2.0, 0.0));

    Button next = Button(mob: nextIterationButton, onClick: nextGMMUpdater);
    return next;
  }

  Button makeResetGMMButton() {
    Rectangle r2 = Rectangle(height: 0.5, width: 1.0);
    Tex tex = Tex(r'Reset', color: BLACK);
    tex.scaleUniformly(0.5);
    VGroup resetIterationButton = VGroup([tex, r2]);
    resetIterationButton..moveToPoint(Vector3(5.5, 3.0, 0.0));

    Button reset = Button(mob: resetIterationButton, onClick: resetGMMUpdater);
    return reset;
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

  VGroup createGMM(List<double> means, List<double> covs, List<double> xRange) {
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
      if (covs[i] < lowerCovsThreshold) {
        covs[i] = lowerCovsThreshold;
      }

      if (covs[i] > upperCovsThreshold) {
        covs[i] = upperCovsThreshold;
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

  bool isConverged(List<double> covs) {
    print(covs);
    for (var i = 0; i < covs.length; i++) {
      if (covs[i] > lowerCovsThreshold && covs[i] < upperCovsThreshold) {
        return false;
      }
    }
    return true;
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
  Animation createInitialGMMAnimations(VGroup gaussians) {
    return ShowCreation(gaussians);
  }

  // AnimationGroup transformGaussians(
  //     List<FunctionGraph> currentGMM, List<FunctionGraph> gaussians2) {
  //   return
  // }

  Future animateData1D(VGroup dots, VGroup dots2) async {
    await play(Transform(dots, target: dots2));
  }

  // Animates the Gaussian Functions given the initial and target gaussians
  Future animateGaussians(VGroup currentGMM, VGroup gaussians2) async {
    await play(
        Transform(currentGMM, target: gaussians2, lagRatio: 1, runTime: 2));
  }

  void transformGaussians() async {
    // await play(Transform(currentGMM, target: nextGMM)); // YIPEEEE
    currentGMM.become(nextGMM);
  }

  // Handles all subsequent rendering and triggered animations
  Future continueRendering() async {
    while (true) {
      if (state == 1) {
        // Updates the GMM by 1 EM step
        await nextGMMIteration();
        state = 0;
      } else if (state == 2) {
        print("HIHIHI");
        await resetGMM();

        state = 0;
      } else if (state == 3) {
        await playGMM();
      } else if (state == 4) {
        await prevGMMIteration();
        state = 0;
      } else {
        await wait();
      }

      // if (state != 0) state = 0;
    }
  }
}
