// Polygon getArea(Axes axes, FunctionGraph graph, xRange, color) {
//   double a, b;
//   if (!xRange) {
//     a = graph.tMin;
//     a = graph.tMax;
//   } else {
//     a = xRange[0];
//     b = xRange[1];
//   }

//   List<Vector3> points = [
//     axes.coordsToPoint(a),
//     graph.function(a), // getValueFromFunction
//     ...graph.points.where((p) {
//       var x = axes.p2c(p)[0];
//       return a <= x && x <= b;
//     }),
//     graph.function(b),
//     axes.coordsToPoint(b),
//   ];

//   return Polygon(points, color: YELLOW_A);
// }

// TODO