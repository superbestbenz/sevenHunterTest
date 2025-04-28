import 'package:flutter/material.dart';

class FibonacciProvider with ChangeNotifier {
  Map<int, FibonacciItem?> fibonacciItems = {};
  Map<int, FibonacciItem?> fibonacciSquare = {};
  Map<int, FibonacciItem?> fibonacciCross = {};
  Map<int, FibonacciItem?> fibonacciCircle = {};

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
    if (count > 0)
      fibonacciItems.addAll({0: FibonacciItem(0, getIconForIndex(0))});
    if (count > 1)
      fibonacciItems.addAll({1: FibonacciItem(1, getIconForIndex(1))});

    for (int i = 2; i < count; i++) {
      fibonacciItems.addAll({
        i: FibonacciItem(
            (fibonacciItems[i - 1]?.number ?? 0) +
                (fibonacciItems[i - 2]?.number ?? 0),
            getIconForIndex(i))
      });
    }

    notifyListeners();
  }

  IconData getIconForIndex(int index) {
    return basePattern[index % basePattern.length];
  }

  void showFilteredBottomSheet(
    BuildContext context,
    Map<int, FibonacciItem?> item,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows custom height
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.5, // Set the height to 50% of the screen
          child: SingleChildScrollView(
            child: Column(
              children: item.entries.map((entry) {
                return GestureDetector(
                  onTap: () {
                    removeFromListCart(item, entry.key);
                    Navigator.pop(
                        context); // Close the BottomSheet after tapping
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    constraints: const BoxConstraints(
                      minHeight: 50,
                      maxHeight: 100,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            'index: ${entry.key} number: ${entry.value?.number}'),
                        Icon(entry.value?.icon ?? Icons.help),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  addFunction(BuildContext context, int index) async {
    IconData icon = fibonacciItems[index]?.icon ?? fallbackIcon;
    await addToListCart(fibonacciItems, index);
    Map<int, FibonacciItem?> selectedItems = {};
    switch (icon) {
      case squareIcon:
        selectedItems = fibonacciSquare;
        break;
      case crossIcon:
        selectedItems = fibonacciCross;
        break;
      case circleIcon:
        selectedItems = fibonacciCircle;
        break;
      default:
    }
    if (context.mounted) {
      showFilteredBottomSheet(
        context,
        selectedItems,
      );
    }

    notifyListeners();
  }

  addToListCart(Map<int, FibonacciItem?> item, int index) {
    switch (item[index]?.icon) {
      case squareIcon:
        fibonacciSquare.addAll({index: item[index]});
        final sortedEntries = fibonacciSquare.entries.toList()
          ..sort((a, b) => a.key.compareTo(b.key));
        fibonacciSquare = Map<int, FibonacciItem?>.fromEntries(sortedEntries);
        break;
      case crossIcon:
        fibonacciCross.addAll({index: item[index]});
        final sortedEntries = fibonacciCross.entries.toList()
          ..sort((a, b) => a.key.compareTo(b.key));
        fibonacciCross = Map<int, FibonacciItem?>.fromEntries(sortedEntries);
        break;
      case circleIcon:
        fibonacciCircle.addAll({index: item[index]});
        final sortedEntries = fibonacciCircle.entries.toList()
          ..sort((a, b) => a.key.compareTo(b.key));
        fibonacciCircle = Map<int, FibonacciItem?>.fromEntries(sortedEntries);
        break;
      default:
    }
    fibonacciItems.remove(index);
    notifyListeners();
  }

  removeFromListCart(Map<int, FibonacciItem?> item, int index) {
    fibonacciItems.addAll({index: item[index]});
    switch (item[index]?.icon) {
      case squareIcon:
        fibonacciSquare.remove(index);
        final sortedEntries = fibonacciSquare.entries.toList()
          ..sort((a, b) => a.key.compareTo(b.key));
        fibonacciSquare = Map<int, FibonacciItem?>.fromEntries(sortedEntries);

        break;
      case crossIcon:
        fibonacciCross.remove(index);
        final sortedEntries = fibonacciCross.entries.toList()
          ..sort((a, b) => a.key.compareTo(b.key));
        fibonacciCross = Map<int, FibonacciItem?>.fromEntries(sortedEntries);
        break;
      case circleIcon:
        fibonacciCircle.remove(index);
        final sortedEntries = fibonacciCircle.entries.toList()
          ..sort((a, b) => a.key.compareTo(b.key));
        fibonacciCircle = Map<int, FibonacciItem?>.fromEntries(sortedEntries);
        break;
      default:
    }

    final sortedEntries = fibonacciItems.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    fibonacciItems = Map<int, FibonacciItem?>.fromEntries(sortedEntries);

    notifyListeners();
  }
}

class FibonacciItem {
  final int number;
  final IconData icon;

  FibonacciItem(this.number, this.icon);
}
