
void main() {
  List<double> data = [1, 2, 3, 4, 5, 6, 7];
  double mean = data.reduce((a, b) => a + b) / data.length;
  double variance = 0;
  for (var i = 0; i < data.length; i++) {
    variance += (data[i] - mean) * (data[i] - mean);
    // print((data[i] - mean) * (data[i] - mean));
  }

  // print(variance);
  variance /= data.length;
  print(mean);
  print(variance);
}