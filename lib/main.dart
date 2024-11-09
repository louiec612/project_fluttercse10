import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'view/flashcardsView.dart';
import 'view/profileView.dart';
import 'view/addCardView.dart';
import 'package:google_fonts/google_fonts.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.cyan[400],
      ),
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
  Color _fabColor = Colors.grey;
  PageController _controller = PageController();
  int _currentIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onButtonPressed(int index) {
    _controller.jumpToPage(index);
    setState(() {
      _fabColor = _currentIndex == 2 ? Theme.of(context).primaryColor : Colors.grey;
    });
  }

  void _changeColor() {
    print(_currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      bottomNavigationBar: _bottomAppBar(
        currentIndex: _currentIndex,
        onButtonPressed: _onButtonPressed,
      ),
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: Colors.white,
        foregroundColor: _fabColor,
        onPressed: () {
          _onButtonPressed(3);
          _changeColor;
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageView(
        controller: _controller,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
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
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            spreadRadius: 5.0,
            offset: Offset(0.0, 2.0), // changes position of shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15), topLeft: Radius.circular(15)),
        child: BottomAppBar(
          color: Colors.white,
          elevation: 20,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ZoomTapAnimation(
                child: IconButton(
                  onPressed: () => onButtonPressed(0), // Navigate to page 0
                  icon: const Icon(Icons.home),
                  color: currentIndex == 0 ? Theme.of(context).primaryColor : Colors.grey,
                ),
              ),
              ZoomTapAnimation(
                child: IconButton(
                  onPressed: () => onButtonPressed(1), // Navigate to page 1
                  icon: const Icon(Icons.person_2_outlined),
                  color: currentIndex == 1 ? Theme.of(context).primaryColor : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
