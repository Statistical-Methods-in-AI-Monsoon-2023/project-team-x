import 'dart:html';
import 'package:manim_web/display/abstract_html_display.dart';
import 'package:gmm/gmm.dart';
import 'package:manim_web/manim.dart';


void main() {
  var display = Canvas2DDisplay(document.getElementById('canvas-container')!);
  GaussianScene gs = GaussianScene();

  // Create an input element for file selection
  // Only Text or csv files are allowed
  // Comma separated list of double values
  InputElement fileInput = document.getElementById("fileInput") as InputElement;
  Element contentUpload = document.getElementById("uploadedContent") as Element;
  fileInput.accept = 'text/plain';

  fileInput.onChange.listen((e) {
    final files = fileInput.files;
    if (files!.length == 1) {
      final file = files[0];
      final reader = FileReader();

      reader.onLoad.listen((e) {
        final contents = reader.result as String;
        print(contents);

        List<String> contents2 = contents.split(",");
        List<double> contents3 = [];
        for (var i = 0; i < contents2.length; i++) {
          contents3.add(double.parse(contents2[i]));
        }

        contentUpload.setInnerHtml(contents3.toString());

        gs.setData(contents3);
        var scene = gs..bindDisplay(display);
        scene.run();
      });

      reader.onError.listen((e) {
        print('Error reading file');
      });

      reader.readAsText(file);
    }
  });

  var scene = gs..bindDisplay(display);
  scene.run();
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

  late Button b1;
  late Button b2;
  late Button b3;
  late Button b4;
  late Button b5;

  late VMobject playShape;
  late Triangle tri;
  late Square sqr;

  int state = 0;
  int iteration = 0;
  late int initialN;
  bool isPlay = false;
  bool isUploaded = false;
  double lowerCovsThreshold = 0.8;
  double upperCovsThreshold = 3;
  double mainButtonsHeight = 2.5;

  // List<double> data1 = [1.1, 0.6, 1.3, 1.1, 5.2, 4.7, 5.1, 5.3, 5.2, 12.3, 12.1, 12.9, 12.4, 12];
  late List<double> data1;
  late List<double> initialMeans;
  late List<double> initialCovs;

  List<double> xRange = [-5, 20];
  late List<double> gammas;

  void setData(uploadedData) {
    data1 = uploadedData;
  }

  @override
  FutureOr<void> preload() {
    MathTex.preload(r'\gets');
    MathTex.preload(r'\to');
    Tex.preload(r'Reset');
    // Tex.preload(r' blacktriangleright ');
  }

  @override
  Future construct() async {

    if (!isUploaded) {
      data1 = [
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
    }
    initialN = 3;
    initialMeans = [1, 3, 7];
    initialCovs = [1, 2, 3];
    List<double> means1 = new List<double>.from(initialMeans);
    List<double> covs1 = new List<double>.from(initialCovs);
    // GMM Initializations
    List<double> weights = initializeWeights(initialN);
    gmm = GMM1D(initialN, weights, means1, covs1);

    // Creating Premade Manim Objects
    addAxes(xRange);
    currentGMM = createGMM(means1, covs1, xRange);
    VGroup dots = createDotsFromData(data1);
    Animation ag = createInitialGMMAnimations(currentGMM);

    makeButtonObjects();
    b1 = makeUpdateGMMButton();
    b2 = makeResetGMMButton();
    b3 = playGMMButton();
    b4 = makePrevGMMButton();
    // b5 = pauseGMMButton();

    // ANIMATIONS

    // Axes & Data
    await play(ShowCreation(axes));
    await play(ShowCreation(dots));
    await play(ag);

    await playMany([
      ShowCreation(b1),
      ShowCreation(b2),
      ShowCreation(b3),
      ShowCreation(b4),
      // ShowCreation(b5)
    ]);

    // HANDLE INTERACTION
    await continueRendering();
  }

  // FUNCTIONS
  // MAKING OBJECTS

  void makeButtonObjects() {
    tri = Triangle(color: GREEN);
    tri
      ..rotate(PI / 2)
      ..moveToPoint(Vector3(5.5, mainButtonsHeight, 0.0))
      ..scale(Vector3(0.1, 0.1, 1));
    sqr = Square(color: RED);
    sqr
      ..rotate(PI / 2)
      ..moveToPoint(Vector3(5.5, mainButtonsHeight, 0.0))
      ..scale(Vector3(0.08, 0.08, 1));
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

    nextGMM = createGMM(means2, covs2, xRange);
    await play(Transform(currentGMM, target: nextGMM));
  }

  Future nextGMMIteration() async {
    List<List<double>> resp = gmm.eStep(data1);
    final temp = gmm.mStep(data1, resp);
    iteration++;

    List<double> means2 = gmm.means;
    List<double> covs2 = gmm.variances;

    nextGMM = createGMM(means2, covs2, xRange);
    await play(Transform(currentGMM, target: nextGMM));
  }

  Future resetGMM() async {
    List<double> weights = initializeWeights(initialN);
    List<double> means1 = new List<double>.from(initialMeans);
    List<double> covs1 = new List<double>.from(initialCovs);

    gmm = GMM1D(initialN, weights, means1, covs1);
    iteration = 0;
    nextGMM = createGMM(means1, covs1, xRange);

    await play(Transform(currentGMM, target: nextGMM));
  }

  Future playGMM() async {
    List<List<double>> resp = gmm.eStep(data1);
    final temp = gmm.mStep(data1, resp);
    iteration++;
    print("iteration");
    print(iteration);

    List<double> means2 = gmm.means;
    List<double> covs2 = gmm.variances;

    bool hasConverged = isConverged(covs2);
    print("hasConverged");
    print(hasConverged);
    if (hasConverged && iteration > 3) {
      state = 0;
      playShape.become(tri);
    }

    nextGMM = createGMM(means2, covs2, xRange);
    await play(Transform(currentGMM, target: nextGMM));
  }

  void stopUpdater() {
    print("Paused");

    state = 5;

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
    if (isPlay) {
      playShape.become(tri);
      state = 0;
    } else {        
      playShape.become(sqr);
      state = 3;
    }
    isPlay = !isPlay;
    print("Play");
    
  }

  void prevGMMUpdater() {
    state = 4;
  }

  Button playGMMButton() {
    Rectangle r2 = Rectangle(height: 0.5, width: 0.8);
    // Tex tex = Tex(r' blacktriangleright ', color: BLACK);
    // tex.scaleUniformly(0.5);
    playShape = Triangle(color: GREEN);
    playShape
      ..scale(Vector3(0.18, 0.18, 1))
      ..rotate(PI / 2);
    playShape..shift(DOWN / 4);
    VGroup playGMMButtonGroup = VGroup([playShape, r2]);
    playGMMButtonGroup..moveToPoint(Vector3(5.5, mainButtonsHeight, 0.0));
    playGMMButtonGroup..scale(Vector3(0.5, 0.5, 1));

    Button playButton =
        Button(mob: playGMMButtonGroup, onClick: playGMMUpdater);
    return playButton;
  }

  Button pauseGMMButton() {
    // Mobject obj = RoundedRectangle(cornerRadius: 0.5, height: 2.0, width: 4.0);
    // Mobject obj = RoundedRectangle(cornerRadius: 0.5);
    // RoundedRectangle r = RoundedRectangle(cornerRadius: 0.3, height: 1.0, width: 2.0);
    Rectangle r2 = Rectangle(height: 0.5, width: 0.8);
    // Tex tex = Tex(r' blacktriangleright ', color: BLACK);
    // tex.scaleUniformly(0.5);
    Square sqr = Square(color: RED);
    sqr
      ..scale(Vector3(0.18, 0.18, 1))
      ..rotate(PI / 2);
    // sqr..shift(DOWN / 4);
    VGroup pauseGMMButtonGroup = VGroup([sqr, r2]);
    pauseGMMButtonGroup..moveToPoint(Vector3(5.5, mainButtonsHeight, 0.0));
    pauseGMMButtonGroup..scale(Vector3(0.5, 0.5, 1));

    Button pauseButton =
        Button(mob: pauseGMMButtonGroup, onClick: stopUpdater);
    return pauseButton;
  }

  Button makePrevGMMButton() {
    // Mobject obj = RoundedRectangle(cornerRadius: 0.5, height: 2.0, width: 4.0);
    // Mobject obj = RoundedRectangle(cornerRadius: 0.5);
    // RoundedRectangle r = RoundedRectangle(cornerRadius: 0.3, height: 1.0, width: 2.0);
    Rectangle r2 = Rectangle(height: 0.25, width: 0.4);
    MathTex tex = MathTex(r'\gets', color: BLACK);
    tex.scaleUniformly(0.5);
    VGroup prevIterationButton = VGroup([tex, r2]);
    prevIterationButton..moveToPoint(Vector3(5.0, mainButtonsHeight, 0.0));

    Button prev = Button(mob: prevIterationButton, onClick: prevGMMUpdater);
    return prev;
  }

  Button makeUpdateGMMButton() {
    // Mobject obj = RoundedRectangle(cornerRadius: 0.5, height: 2.0, width: 4.0);
    // Mobject obj = RoundedRectangle(cornerRadius: 0.5);
    // RoundedRectangle r = RoundedRectangle(cornerRadius: 0.3, height: 1.0, width: 2.0);
    Rectangle r2 = Rectangle(height: 0.25, width: 0.4);
    MathTex tex = MathTex(r'\to', color: BLACK);
    tex.scaleUniformly(0.5);
    VGroup nextIterationButton = VGroup([tex, r2]);
    nextIterationButton..moveToPoint(Vector3(6.0, mainButtonsHeight, 0.0));

    Button next = Button(mob: nextIterationButton, onClick: nextGMMUpdater);
    return next;
  }

  Button makeResetGMMButton() {
    Rectangle r2 = Rectangle(height: 0.3, width: 1.4);
    Tex tex = Tex(r'Reset', color: RED);
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
      print(state);
      if (state == 1) { // Next
        // Updates the GMM by 1 EM step
        await nextGMMIteration();
        state = 0;
      } else if (state == 2) { // Reset
        print("HIHIHI");
        await resetGMM();

        state = 0;
      } else if (state == 3) { // Play
        await playGMM();
      } else if (state == 4) { // Prev
        await prevGMMIteration();
        state = 0;
      } else {
        await wait();
      }

      // if (state != 0) state = 0;
    }
  }

  // UTILITY
  List<double> initializeWeights(int length) {
    return List.generate(length, (index) => 1 / length);
  }
}
