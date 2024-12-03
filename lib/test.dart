import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> with TickerProviderStateMixin {
  final double address1Top = 20;
  final double address2Top = 110;
  bool swapped = false;

  late Animation<double> addressAnimation;
  late AnimationController controller;
  animationListener() => setState(() { });

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    // Initialize animations
    controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);

    addressAnimation = Tween(begin: 0.0, end: address2Top - address1Top).animate(CurvedAnimation(parent: controller, curve: const Interval(0.0, 1.0, curve: Curves.easeInOut)))..addListener(animationListener);
  }

  @override
  dispose() {
    // Dispose of animation controller
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tweenValue = addressAnimation?.value ?? 0.0;

    return Container(
      width: 300,
      height: 150,
      color: Colors.blue,
      child: Stack(
        children: <Widget> [
          // Top address
          Positioned(
            top: address1Top + tweenValue,
            left: 20,
            child: const Text("This is the first address"),
          ),
          // Bottom address
          Positioned(
            top: address2Top - tweenValue,
            left: 20,
            child: const Text("This is another address"),
          ),
          // Swap button
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () => setState(() {
                swapped ? controller.reverse() : controller.forward();
                swapped = !swapped;
              }),
              child: const Text("swap"),
            ),
          ),
        ],
      ),
    );
  }
}