import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seven_hunter/fibonacci/fibonacci_screen_provider.dart';

class FibonacciScreen extends StatefulWidget {
  const FibonacciScreen({super.key});

  @override
  State<FibonacciScreen> createState() => _FibonacciScreenState();
}

class _FibonacciScreenState extends State<FibonacciScreen> {
  late FibonacciProvider fibonacciProvider;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fibonacciProvider = context.read<FibonacciProvider>();
      fibonacciProvider.generateFibonacci(40);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    fibonacciProvider = context.watch<FibonacciProvider>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fibonacci List'),
      ),
      body: FibonacciScrollWidget(),
    );
  }
}

class FibonacciScrollWidget extends StatelessWidget {
  const FibonacciScrollWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: context.read<FibonacciProvider>(),
      child: Consumer<FibonacciProvider>(builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Column(
            children: provider.fibonacciItems.entries.map((entry) {
              return GestureDetector(
                onTap: () {
                  provider.addFunction(context, entry.key);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  constraints: const BoxConstraints(
                    minHeight: 50,
                    maxHeight: 100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('index: ${entry.key} number: ${entry.value?.number}'),
                      Icon(entry.value?.icon ?? Icons.help)
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
        ListView.builder(
            itemCount: provider.fibonacciItems.length,
            itemBuilder: (context, index) {
              final item = provider.fibonacciItems[index];

              return GestureDetector(
                onTap: () {
                  provider.addFunction(context, index);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  constraints: const BoxConstraints(
                    minHeight: 50,
                    maxHeight: 100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('index: $index number: ${item?.number}'),
                      Icon(item?.icon ?? Icons.help)
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }
}
