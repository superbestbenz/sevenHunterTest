import 'package:flutter/material.dart';

class FibonacciProvider with ChangeNotifier {
  List<int> fibonacciNumbers = List.empty(growable: true);
  static const IconData squareIcon = Icons.square;
  static const IconData crossIcon = Icons.close;
  static const IconData circleIcon = Icons.circle;
  static const IconData fallbackIcon = Icons.help;
  static const List<IconData> basePattern = [
    circleIcon,
    squareIcon,
    squareIcon,
    crossIcon,
    circleIcon,
    crossIcon,
    crossIcon,
    squareIcon,
  ];

  void generateFibonacci(int count) {
    if (count > 0) fibonacciNumbers.add(0);
    if (count > 1) fibonacciNumbers.add(1);
    for (int i = 2; i < count; i++) {
      fibonacciNumbers.add(fibonacciNumbers[i - 1] + fibonacciNumbers[i - 2]);
    }

    notifyListeners();
  }

  IconData getIconForIndex(int index) {
    return basePattern[index % basePattern.length];
  }
}
