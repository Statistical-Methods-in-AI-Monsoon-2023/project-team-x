import 'package:manim_web/manim.dart';

class TestScene extends Scene {

	late Tex te;
	late Tex tn;
	late Tex tp;
	late Tex td;

	late Tex t0;
	late Tex t1;
	late Tex t2;
	late Tex t3;
	late Tex t4;
	late Tex t5;
	late Tex t6;
	late Tex t7;
	late Tex t8;
	late Tex t9;

	late Map m;

	int precisionThreshold = 3;

	@override
	FutureOr<void> preload() {
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
		makeMap();

		await animateNumberChange(0, 1);

	}

	Map makeMap() {
		te = Tex('e');
		tp = Tex('+');
		tn = Tex('-');
		td = Tex('.');
		t0 = Tex('0');
		t1 = Tex('1');
		t2 = Tex('2');
		t3 = Tex('3');
		t4 = Tex('4');
		t5 = Tex('5');
		t6 = Tex('6');
		t7 = Tex('7');
		t8 = Tex('8');
		t9 = Tex('9');

		m = {
		"e": te,
		"+": tp,
		"-": tn,
		".": td,
		"0": t0,
		"1": t1,
		"2": t2,
		"3": t3,
		"4": t4,
		"5": t5,
		"6": t6,
		"7": t7,
		"8": t8,
		"9": t9,
		};
		return m;
	}

	Future animateNumberChange(double a, double b) async {
		int steps = 100;
		double step = (b - a) / steps;
		List<VGroup> numbers = [];
		double currentNumber = a - step;
		String tmp;
		for (var i = 0; i < steps + 1; i++) {
			currentNumber += step;
			tmp = currentNumber.toStringAsPrecision(precisionThreshold);
			List<Tex> t = [];
			for (var j = 0; j < tmp.length; j++) {
				t.add(m[tmp[j]]);
			}
			numbers.add(VGroup(t));
		}

		VGroup initial = numbers[0];
		await play(ShowCreation(initial));
		for (var i = 1; i < steps; i++) {
			initial.become(numbers[i]);
		}

	}
}