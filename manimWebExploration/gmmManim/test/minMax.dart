double min1(double a, double b) {
  return a < b ? a : b;
}

double max1(double a, double b) {
  return a < b ? b : a;
}

void main() {
  print(min1(2, 3));
  print(max1(2, 3));
}