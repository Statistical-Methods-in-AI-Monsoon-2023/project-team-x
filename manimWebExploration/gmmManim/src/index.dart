import 'package:manim_web/manim.dart';

class TestScene extends Scene {
  late Map m;

  int precisionThreshold = 3;

  @override
  FutureOr<void> preload() {
    MathTex.preload(r'\gets');
    MathTex.preload(r'\to');
    MathTex.preload(r'\textnormal{Means} \hspace{0.1cm} \mu:');
    MathTex.preload(r'\textnormal{Variances} \hspace{0.1cm} \sigma^2:');
    Tex.preload(r'Reset');

    Tex.preload('e');
    Tex.preload('+');
    Tex.preload('-');
    Tex.preload('.');
    Tex.preload('0');
    Tex.preload('1');
    Tex.preload('2');
    Tex.preload('3');
    Tex.preload('4');
    Tex.preload('5');
    Tex.preload('6');
    Tex.preload('7');
    Tex.preload('8');
    Tex.preload('9');
  }

  @override
  Future construct() async {
    // m = makeMap();

    // await animateNumberChange(0, 2739187219738092, Vector3(-2.0, 2.0, 0), m,
    //     digits: 4);

    await play(ShowCreation(MathTex(r'\textnormal{Means} \hspace{0.1cm} \mu:')));
    await play(ShowCreation(MathTex(r'\textnormal{Variances} \hspace{0.1cm} \sigma^2:')..shift(Vector3(0.0, -2.0, 0.0))));
  }

  Map makeMap() {
    m = {
      "e": Tex('e'),
      "+": Tex('+'),
      "-": Tex('-'),
      ".": Tex('.'),
      "0": Tex('0'),
      "1": Tex('1'),
      "2": Tex('2'),
      "3": Tex('3'),
      "4": Tex('4'),
      "5": Tex('5'),
      "6": Tex('6'),
      "7": Tex('7'),
      "8": Tex('8'),
      "9": Tex('9'),
    };
    return m;
  }

  Future animateNumberChange(double a, double b, Vector3 pos, Map map,
      {int steps: 17,
      double runTime: 0.03,
      int digits: 3,
      double scale: 0.5,
      double eFlagNumberShift: 0.07,
      double exponentOffset: 0.07,
      double letterSpacing: 0.17}) async {
    double step = (b - a) / steps;
    List<VGroup> numbers = [];
    double currentNumber = a - step;
    String tmp;

    for (var i = 0; i < steps + 1; i++) {
      currentNumber += step;
      tmp = currentNumber.toStringAsPrecision(digits);
      List<Tex> t = [];
      bool eFlag = false;
      int sinceE = 0;

      for (var j = 0; j < tmp.length; j++) {
        bool isNumber = false;
        Tex letter = map[tmp[j]].copy();
        double shift = 0;
        if (tmp[j] == '.') {
          shift = 0.1;
        } else if (tmp[j] == 'e') {
          shift = 0.05;
          eFlag = true;
        } else {
          isNumber = true;
        }
        if (eFlag && isNumber) {
          sinceE++;
          letter
            ..scale(Vector3(0.5, 0.5, 1))
            ..moveToPoint(Vector3(
                pos[0] + letterSpacing * j - exponentOffset * sinceE,
                pos[1] + eFlagNumberShift,
                pos[2]));
        } else {
          letter
            ..moveToPoint(
                Vector3(pos[0] + letterSpacing * j, pos[1] - shift, pos[2]));
        }

        t.add(letter);
      }
      numbers.add(VGroup(t));
    }

    VGroup initial = numbers[0];
    await play(ShowCreation(initial));

    for (var i = 1; i < steps + 1; i++) {
      initial.become(numbers[i]);
      await wait(runTime);
    }
  }
}
