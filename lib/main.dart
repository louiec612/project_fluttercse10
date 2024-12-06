import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:project_fluttercse10/view/Deck%20View/deckView.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'generator.dart';
import 'view/Home View/homeView.dart';
import 'view/Profile View/profileView.dart';
import 'view/Create View/createView.dart';
import 'view/Quiz View/quizView.dart';
import 'package:project_fluttercse10/getset.dart';
import 'package:google_fonts/google_fonts.dart';



void main() async{
  runApp(const MyApp());
  final generator = QuestionAnswerGenerator(apiKey);
  try {
    generateCard.data = await generator.generate();
    print(generateCard.data);
  } catch (e) {
    print('Error: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    getWid.wSize = MediaQuery.sizeOf(context).width;
    getHgt.hSize = MediaQuery.sizeOf(context).height;
    color.col = const Color.fromRGBO(26, 117, 159,1);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: color.col,
        textTheme: const TextTheme(
          displayMedium: TextStyle(
            color: Color.fromRGBO(17, 20, 76, 1),
          )
        )
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
final GlobalKey<HomePageState> homePageKey = GlobalKey<HomePageState>();
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: homePageKey);


  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Color _fabColor = Colors.grey;
  final PageController _controller = PageController();
  int _currentIndex = 0;


  void onButtonPressed(int index) {
    _controller.animateToPage(index,duration: const Duration(milliseconds: 1) ,curve:Curves.ease);
    _currentIndex = index;
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
        onButtonPressed: onButtonPressed,
      ),
      floatingActionButton: FloatingActionButton.large(
        backgroundColor: Colors.white,
        foregroundColor: _fabColor,
        onPressed: () {
          onButtonPressed(2);
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            homeView(),
            profileView(),
            AddFlashcardView(),
            deckView(),
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


