import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'view/fcView.dart';
import 'view/pfView.dart';
import 'view/afcView.dart';

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

  PageController _controller = PageController();
  int _currentIndex = 0;
  void _onPageChanged(int index){
    setState((){
      _currentIndex = index;
    });
  }

  void _onButtonPressed(int index){
    _controller.jumpToPage(index);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {_onButtonPressed(3);},

        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _bottomAppBar(
        currentIndex: _currentIndex,
        onButtonPressed: _onButtonPressed,
      ),
      body: PageView(
        controller: _controller,
        onPageChanged: _onPageChanged,
        children: const [
          flashcardView(),
          profileView(),
          addFlashcardView(),
        ],

      ),
    );
  }
}


class _bottomAppBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onButtonPressed;

  const _bottomAppBar({
    Key? key,
    required this.currentIndex,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ZoomTapAnimation(
            child: IconButton(
              onPressed: () => onButtonPressed(0), // Navigate to page 0
              icon: const Icon(Icons.home),
              color: currentIndex == 0 ? Colors.cyan : Colors.grey,
            ),
          ),
          ZoomTapAnimation(
            child: IconButton(
              onPressed: () => onButtonPressed(1), // Navigate to page 1
              icon: const Icon(Icons.person_2_outlined),
              color: currentIndex == 1 ? Colors.cyan : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}


