import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {},
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ZoomTapAnimation(
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    icon: const Icon(Icons.home),
                    color: selectedIndex == 1 ? Colors.cyan : Colors.grey,
                  ),
                ),
                ZoomTapAnimation(
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          selectedIndex = 2;
                        });
                      },
                      icon: const Icon(Icons.person_2_outlined),
                      color: selectedIndex == 2 ? Colors.cyan : Colors.grey),
                )
              ]),
        ),
      ),
    );
  }
}
