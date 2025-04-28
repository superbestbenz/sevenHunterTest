import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seven_hunter/fibonacci/fibonacci_screen.dart';
import 'package:seven_hunter/fibonacci/fibonacci_screen_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Seven Hunter Fibonacci',
      home: ChangeNotifierProvider<FibonacciProvider>(
        create: (_) => FibonacciProvider(),
        child: const FibonacciScreen(),
      ),
    );
  }
}

class FibonacciScrollWidget extends StatelessWidget {
  const FibonacciScrollWidget({super.key});

  // Function to generate the first 40 Fibonacci numbers
  List<int> generateFibonacci(int count) {
    List<int> fibonacci = [0, 1];
    for (int i = 2; i < count; i++) {
      fibonacci.add(fibonacci[i - 1] + fibonacci[i - 2]);
    }
    return fibonacci;
  }

  // Function to get an icon based on the index
  IconData getIconForIndex(int index) {
    switch (index % 3) {
      case 0:
        return Icons.square; // Square icon
      case 1:
        return Icons.add; // Cross icon
      case 2:
        return Icons.circle; // Circle icon
      default:
        return Icons.help; // Fallback icon
    }
  }

  @override
  Widget build(BuildContext context) {
    final fibonacciNumbers = generateFibonacci(40);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fibonacci Scroll'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                for (int i = 0; i < fibonacciNumbers.length; i += 5)
                  Row(
                    children: [
                      for (int j = i; j < i + 5 && j < fibonacciNumbers.length; j++)
                        Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade100,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                getIconForIndex(j),
                                color: Colors.deepPurple,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                fibonacciNumbers[j].toString(),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}