import 'dart:html';
import 'package:manim_web/display/abstract_html_display.dart';
import 'package:gmm/gmm.dart';
import 'package:manim_web/manim.dart';

void main() {
  SingleStringMathTex.texToSVGMap[r'''align*'''] = {};
  SingleStringMathTex.texToSVGMap[r'''center'''] = {};

  SingleStringMathTex.texToSVGMap[r'''align*''']![r'''\gets'''] =
      r'''<?xml version='1.0' encoding='UTF-8'?>
  <!-- This file was generated by dvisvgm 2.13.3 -->
  <svg version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='9.962669pt' height='2.328761pt' viewBox='166.874206 -3.655041 9.962669 2.328761'>
  <defs>
  <path id='g0-32' d='M9.39477-2.49066C9.39477-2.590286 9.325031-2.689913 9.185554-2.689913H1.643836C2.391034-3.227895 2.909091-4.044832 3.068493-4.961395C3.068493-5.041096 3.01868-5.090909 2.958904-5.090909H2.779577C2.729763-5.090909 2.67995-5.051059 2.669988-5.001245C2.480697-3.88543 1.693649-2.968867 .627646-2.590286C.587796-2.580324 .547945-2.540473 .547945-2.49066S.587796-2.400996 .627646-2.391034C1.693649-2.012453 2.480697-1.09589 2.669988 .019925C2.67995 .069738 2.729763 .109589 2.779577 .109589H2.958904C3.01868 .109589 3.068493 .059776 3.068493-.019925C2.909091-.936488 2.391034-1.753425 1.643836-2.291407H9.185554C9.325031-2.291407 9.39477-2.391034 9.39477-2.49066Z'/>
  </defs>
  <g id='page1'>
  <use x='166.874206' y='0' xlink:href='#g0-32'/>
  </g>
  </svg>''';
  SingleStringMathTex.texToSVGMap[r'''align*''']![r'''\to'''] =
      r'''<?xml version='1.0' encoding='UTF-8'?>
  <!-- This file was generated by dvisvgm 2.13.3 -->
  <svg version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='9.962669pt' height='2.328761pt' viewBox='166.874206 -3.655041 9.962669 2.328761'>
  <defs>
  <path id='g0-33' d='M9.39477-2.49066C9.39477-2.540473 9.354919-2.580324 9.315068-2.590286C8.249066-2.968867 7.462017-3.88543 7.272727-5.001245C7.262765-5.051059 7.212951-5.090909 7.163138-5.090909H6.983811C6.924035-5.090909 6.874222-5.041096 6.874222-4.961395C7.033624-4.044832 7.551681-3.227895 8.298879-2.689913H.757161C.617684-2.689913 .547945-2.590286 .547945-2.49066S.617684-2.291407 .757161-2.291407H8.298879C7.551681-1.753425 7.033624-.936488 6.874222-.019925C6.874222 .059776 6.924035 .109589 6.983811 .109589H7.163138C7.212951 .109589 7.262765 .069738 7.272727 .019925C7.462017-1.09589 8.249066-2.012453 9.315068-2.391034C9.354919-2.400996 9.39477-2.440847 9.39477-2.49066Z'/>
  </defs>
  <g id='page1'>
  <use x='166.874206' y='0' xlink:href='#g0-33'/>
  </g>
  </svg>''';
  SingleStringMathTex.texToSVGMap[r'''center''']![r'''Reset'''] =
      r'''<?xml version='1.0' encoding='UTF-8'?>
  <!-- This file was generated by dvisvgm 2.13.3 -->
  <svg version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='23.993534pt' height='6.863016pt' viewBox='159.993287 -6.863016 23.993534 6.863016'>
  <defs>
  <path id='g0-82' d='M7.292653-.876712C7.292653-.936488 7.292653-1.046077 7.163138-1.046077C7.053549-1.046077 7.053549-.956413 7.043587-.886675C6.983811-.179328 6.635118 0 6.386052 0C5.897883 0 5.818182-.508095 5.678705-1.43462L5.549191-2.231631C5.369863-2.86924 4.881694-3.198007 4.333748-3.387298C5.300125-3.626401 6.07721-4.234122 6.07721-5.011208C6.07721-5.967621 4.941469-6.804483 3.476961-6.804483H.348692V-6.495641H.587796C1.354919-6.495641 1.374844-6.386052 1.374844-6.027397V-.777086C1.374844-.418431 1.354919-.308842 .587796-.308842H.348692V0C.707347-.029888 1.414695-.029888 1.803238-.029888S2.899128-.029888 3.257783 0V-.308842H3.01868C2.251557-.308842 2.231631-.418431 2.231631-.777086V-3.297634H3.377335C3.536737-3.297634 3.955168-3.297634 4.303861-2.958904C4.682441-2.600249 4.682441-2.291407 4.682441-1.62391C4.682441-.976339 4.682441-.577833 5.090909-.199253C5.499377 .159402 6.047323 .219178 6.346202 .219178C7.123288 .219178 7.292653-.597758 7.292653-.876712ZM5.051059-5.011208C5.051059-4.323786 4.811955-3.516812 3.337484-3.516812H2.231631V-6.097136C2.231631-6.326276 2.231631-6.445828 2.450809-6.475716C2.550436-6.495641 2.839352-6.495641 3.038605-6.495641C3.935243-6.495641 5.051059-6.455791 5.051059-5.011208Z'/>
  <path id='g0-101' d='M4.134496-1.185554C4.134496-1.285181 4.054795-1.305106 4.004981-1.305106C3.915318-1.305106 3.895392-1.24533 3.875467-1.165629C3.526775-.139477 2.630137-.139477 2.530511-.139477C2.032379-.139477 1.633873-.438356 1.404732-.806974C1.105853-1.285181 1.105853-1.942715 1.105853-2.30137H3.88543C4.104608-2.30137 4.134496-2.30137 4.134496-2.510585C4.134496-3.496887 3.596513-4.463263 2.351183-4.463263C1.195517-4.463263 .278954-3.437111 .278954-2.191781C.278954-.856787 1.325031 .109589 2.470735 .109589C3.686177 .109589 4.134496-.996264 4.134496-1.185554ZM3.476961-2.510585H1.115816C1.175592-3.995019 2.012453-4.244085 2.351183-4.244085C3.377335-4.244085 3.476961-2.899128 3.476961-2.510585Z'/>
  <path id='g0-115' d='M3.58655-1.275218C3.58655-1.803238 3.287671-2.102117 3.16812-2.221669C2.839352-2.540473 2.450809-2.620174 2.032379-2.699875C1.474471-2.809465 .806974-2.938979 .806974-3.516812C.806974-3.865504 1.066002-4.273973 1.92279-4.273973C3.01868-4.273973 3.068493-3.377335 3.088418-3.068493C3.098381-2.978829 3.20797-2.978829 3.20797-2.978829C3.337484-2.978829 3.337484-3.028643 3.337484-3.217933V-4.224159C3.337484-4.393524 3.337484-4.463263 3.227895-4.463263C3.178082-4.463263 3.158157-4.463263 3.028643-4.343711C2.998755-4.303861 2.899128-4.214197 2.859278-4.184309C2.480697-4.463263 2.072229-4.463263 1.92279-4.463263C.707347-4.463263 .328767-3.795766 .328767-3.237858C.328767-2.889166 .488169-2.610212 .757161-2.391034C1.075965-2.132005 1.354919-2.072229 2.072229-1.932752C2.291407-1.892902 3.108344-1.733499 3.108344-1.016189C3.108344-.508095 2.759651-.109589 1.982565-.109589C1.145704-.109589 .787049-.67746 .597758-1.524284C.56787-1.653798 .557908-1.693649 .458281-1.693649C.328767-1.693649 .328767-1.62391 .328767-1.444583V-.129514C.328767 .039851 .328767 .109589 .438356 .109589C.488169 .109589 .498132 .099626 .687422-.089664C.707347-.109589 .707347-.129514 .886675-.318804C1.325031 .099626 1.77335 .109589 1.982565 .109589C3.128269 .109589 3.58655-.557908 3.58655-1.275218Z'/>
  <path id='g0-116' d='M3.307597-1.235367V-1.803238H3.058531V-1.255293C3.058531-.518057 2.759651-.139477 2.391034-.139477C1.723537-.139477 1.723537-1.046077 1.723537-1.215442V-3.985056H3.148194V-4.293898H1.723537V-6.127024H1.474471C1.464508-5.310087 1.165629-4.244085 .18929-4.204234V-3.985056H1.036115V-1.235367C1.036115-.009963 1.96264 .109589 2.321295 .109589C3.028643 .109589 3.307597-.597758 3.307597-1.235367Z'/>
  </defs>
  <g id='page1'>
  <use x='159.993287' y='0' xlink:href='#g0-82'/>
  <use x='167.326779' y='0' xlink:href='#g0-101'/>
  <use x='171.754678' y='0' xlink:href='#g0-115'/>
  <use x='175.684443' y='0' xlink:href='#g0-101'/>
  <use x='180.112342' y='0' xlink:href='#g0-116'/>
  </g>
  </svg>''';
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
        // var scene = gs..bindDisplay(display);
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

  late VGroup dots;

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
  double mainButtonsHeight = -0.5;
  double mainButtonsWidthOffset = 0.0;

  // List<double> data1 = [1.1, 0.6, 1.3, 1.1, 5.2, 4.7, 5.1, 5.3, 5.2, 12.3, 12.1, 12.9, 12.4, 12];
  late List<double> data1;
  late List<double> initialMeans;
  late List<double> initialCovs;

  late List<double> xRange;
  late List<double> gammas;

  @override
  FutureOr<void> preload() {
    MathTex.preload(r'\gets');
    MathTex.preload(r'\to');
    Tex.preload(r'Reset');
  }

  @override
  Future construct() async {
    if (!isUploaded) {
      data1 = [
        -4.0,
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
      xRange = setXRange(data1);
      print(xRange);
      // xRange = [-5, 20];
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
    axes = addAxes(xRange);
    currentGMM = createGMM(means1, covs1, xRange, axes);
    dots = createDotsFromData(axes, data1);
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

  // CONSTRUCTION FUNCTION ENDS HERE
  // CONSTRUCTION FUNCTION ENDS HERE
  // CONSTRUCTION FUNCTION ENDS HERE
  // CONSTRUCTION FUNCTION ENDS HERE
  // CONSTRUCTION FUNCTION ENDS HERE

  void setData(uploadedData) {
    data1 = uploadedData;
    state = 5;
    //Animation
    // 1. Remove current data
    // 2. Update Axes
    // 3. Add New Data
  }

  Future restartWithUploadedData() async {
    print("Uploaded Data");
    
    xRange = setXRange(data1);
    initialN = 3;
    initialMeans = [1, 3, 7];
    initialCovs = [1, 2, 3];
    iteration = 0;

    List<double> means1 = new List<double>.from(initialMeans);
    List<double> covs1 = new List<double>.from(initialCovs);
    // GMM Initializations
    List<double> weights = initializeWeights(initialN);
    gmm = GMM1D(initialN, weights, means1, covs1);
    Axes newAxes = addAxes(xRange);
    VGroup dots2 = createDotsFromData(newAxes, data1);
    VGroup newGMM = createGMM(means1, covs1, xRange, newAxes);

    await playMany([Transform(axes, target: newAxes), 
                    Transform(dots, target: dots2), 
                    Transform(currentGMM, target: newGMM)]);
  }

  // Handles all subsequent rendering and triggered animations
  Future continueRendering() async {
    while (true) {
      // print(state);
      if (state == 1) {
        // Next
        // Updates the GMM by 1 EM step
        await nextGMMIteration();
        state = 0;
      } else if (state == 2) {
        // Reset
        print("HIHIHI");
        await resetGMM();

        state = 0;
      } else if (state == 3) {
        // Play
        await playGMM();
      } else if (state == 4) {
        // Prev
        await play(FadeOut(dots));

        await prevGMMIteration();
        state = 0;
      } else if (state == 5) {
        // Restart with Uploaded Data
        await restartWithUploadedData();
      
        state = 0;
      } else {
        await wait();
      }

      // if (state != 0) state = 0;
    }
  }

  double min1(double a, double b) {
    return a < b ? a : b;
  }

  double max1(double a, double b) {
    return a < b ? b : a;
  }

  List<double> setXRange(data1) {
    double dataMin = data1.reduce(min1);
    double dataMax = data1.reduce(max1);
    double dataPadding = (dataMax - dataMin) / 4;
    List<double> xRange1 = [dataMin - dataPadding, dataMax + dataPadding];
    return xRange1;
  }


  // FUNCTIONS
  // MAKING OBJECTS



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

    nextGMM = createGMM(means2, covs2, xRange, axes);
    await play(Transform(currentGMM, target: nextGMM));
  }

  Future nextGMMIteration() async {
    List<List<double>> resp = gmm.eStep(data1);
    final temp = gmm.mStep(data1, resp);
    iteration++;

    List<double> means2 = gmm.means;
    List<double> covs2 = gmm.variances;

    nextGMM = createGMM(means2, covs2, xRange, axes);
    await play(Transform(currentGMM, target: nextGMM));
  }

  Future resetGMM() async {
    List<double> weights = initializeWeights(initialN);
    List<double> means1 = new List<double>.from(initialMeans);
    List<double> covs1 = new List<double>.from(initialCovs);

    gmm = GMM1D(initialN, weights, means1, covs1);
    iteration = 0;
    nextGMM = createGMM(means1, covs1, xRange, axes);

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

    nextGMM = createGMM(means2, covs2, xRange, axes);
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

  void makeButtonObjects() {
    tri = Triangle(color: GREEN);
    tri
      ..rotate(PI / 2)
      ..scale(Vector3(0.1, 0.1, 1))
      ..toCorner(corner: UL)
      ..shift(Vector3(0.62 + mainButtonsWidthOffset, -0.04 + mainButtonsHeight, 0.0));
    sqr = Square(color: RED);
    sqr
      ..rotate(PI / 2)
      ..scale(Vector3(0.08, 0.08, 1))
      ..toCorner(corner: UL)
      ..shift(Vector3(0.62 + mainButtonsWidthOffset, -0.04 + mainButtonsHeight, 0.0));
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
    playGMMButtonGroup
      ..scale(Vector3(0.5, 0.5, 1))
      ..toCorner(corner: UL)
      ..shift(Vector3(0.5 + mainButtonsWidthOffset, mainButtonsHeight, 0.0));

    Button playButton =
        Button(mob: playGMMButtonGroup, onClick: playGMMUpdater);
    return playButton;
  }

  Button pauseGMMButton() {
    // Mobject obj = RoundedRectangle(cornerRadius: 0.5, height: 2.0, width: 4.0);
    // Mobject obj = RoundedRectangle(cornerRadius: 0.5);
    // RoundedRectangle r = RoundedRectangle(cornerRadius: 0.3, height: 1.0, width: 2.0);
    Rectangle r2 = Rectangle(height: 0.5, width: 0.8);
    Square sqr = Square(color: RED);
    sqr
      ..scale(Vector3(0.18, 0.18, 1))
      ..rotate(PI / 2);
    // sqr..shift(DOWN / 4);
    VGroup pauseGMMButtonGroup = VGroup([sqr, r2]);
    pauseGMMButtonGroup
      ..scale(Vector3(0.5, 0.5, 1))
      ..toCorner(corner: UL)
      ..shift(Vector3(0.5 + mainButtonsWidthOffset, mainButtonsHeight, 0.0));

    Button pauseButton = Button(mob: pauseGMMButtonGroup, onClick: stopUpdater);
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
    prevIterationButton
      ..toCorner(corner: UL)
      ..shift(Vector3(0.0 + mainButtonsWidthOffset, mainButtonsHeight, 0.0));

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
    nextIterationButton
      ..toCorner(corner: UL)
      ..shift(Vector3(1.0 + mainButtonsWidthOffset, mainButtonsHeight, 0.0));

    Button next = Button(mob: nextIterationButton, onClick: nextGMMUpdater);
    return next;
  }

  Button makeResetGMMButton() {
    Rectangle r2 = Rectangle(height: 0.3, width: 1.4);
    Tex tex = Tex(r'Reset', color: RED);
    tex.scaleUniformly(0.5);
    VGroup resetIterationButton = VGroup([tex, r2]);
    resetIterationButton
      ..toCorner(corner: UL)
      ..shift(Vector3(0.0 + mainButtonsWidthOffset, 0.5 + mainButtonsHeight, 0.0));

    Button reset = Button(mob: resetIterationButton, onClick: resetGMMUpdater);
    return reset;
  }

  VGroup createDotsFromData(Axes axesTmp, List<double> data) {
    List<Dot> dots = [];

    var length = data.length;
    for (var i = 0; i < length; i++) {
      Dot dot = Dot(axesTmp.c2p(Vector3(data[i], 0, 0)), color: BLUE);
      dots.add(dot);
    }
    VGroup dotsVG = VGroup(dots);
    return dotsVG;
  }

  VGroup createGMM(List<double> means, List<double> covs, List<double> xRange, Axes axesTmp) {
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

      if (covs[i] > upperCovsThreshold + 2) {
        covs[i] = upperCovsThreshold;
      }

      if (covs[i] < 2) {
        stepSize = 0.1;
      } else {
        stepSize = 0.3;
      }

      FunctionGraph graph = axesTmp.getGraph(
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
    Axes axesTmp = Axes(
      xMin: xRange[0],
      xMax: xRange[1],
      yMin: -1,
      yMax: 7,
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
      ..toCorner(corner: DL);

    // TODO Add labels

    return axesTmp;
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


  // UTILITY
  List<double> initializeWeights(int length) {
    return List.generate(length, (index) => 1 / length);
  }
}
