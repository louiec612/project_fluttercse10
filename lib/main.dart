import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'view/homeView.dart';
import 'view/profileView.dart';
import 'view/createView.dart';
import 'view/quizView.dart';
import 'package:project_fluttercse10/getset.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    getWid.wSize = MediaQuery.sizeOf(context).width;
    getHgt.hSize = MediaQuery.sizeOf(context).height;
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(26, 117, 159,1),
        textTheme: TextTheme(
          displayMedium: TextStyle(
            color: Color.fromRGBO(17, 20, 76, 1),
          )
        )
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
  final PageController _controller = PageController();
  int _currentIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onButtonPressed(int index) {
    _controller.animateToPage(index,duration: Duration(milliseconds: 1) ,curve:Curves.ease);
    setState(() {
      _fabColor =
          _currentIndex == 2 ? Theme.of(context).primaryColor : Colors.grey;
    });
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
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageView(
          controller: _controller,
          onPageChanged: _onPageChanged,
          physics: NeverScrollableScrollPhysics(),
          children: const [
            homeView(),
            profileView(),
            quizView(),
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
  });

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
                  icon: const Icon(BootstrapIcons.house_door, size: 25),
                  color: currentIndex == 0
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
              ),
              ZoomTapAnimation(
                child: IconButton(
                  onPressed: () => onButtonPressed(1), // Navigate to page 1
                  icon: const Icon(BootstrapIcons.person, size: 25),
                  color: currentIndex == 1
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class getWidthSize {
  late double _size;
  set wSize(double value) {
    if (value > 0) {
      _size = value;
    }
  }

  double get wSize => _size;
}

class getHeightSize {
  late double _size;
  set hSize(double value) {
    if (value > 0) {
      _size = value;
    }
  }

  double get hSize => _size;
}

