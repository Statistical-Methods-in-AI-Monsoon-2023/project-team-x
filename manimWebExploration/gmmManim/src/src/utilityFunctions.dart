import 'package:manim_web/manim.dart';
import "./gmm.dart";

// Initialize weights to be 1/numComponents
List<double> initializeWeights(int length) {
  return List.generate(length, (index) => 1 / length);
}

