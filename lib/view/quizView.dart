import 'package:flutter/material.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:project_fluttercse10/main.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../getset.dart';
import 'homeView.dart';

class quizView extends StatefulWidget {
  const quizView({super.key});

  @override
  State<quizView> createState() => _quizViewState();
}

class _quizViewState extends State<quizView> {
  int _current = 0;
  CarouselSliderController buttonCarouselController =
      CarouselSliderController();
  String cardName = "Flashcard Name";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Row(children: [
              const SizedBox(width: 80),
              IconButton(
                iconSize: 30,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              const SizedBox(width: 10),
              Text(
                cardName,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ]),
            const SizedBox(height: 90),
            CarouselSlider(
                carouselController: buttonCarouselController,
                options: CarouselOptions(
                  height: getHgt.hSize / 1.54,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index; // Update the current index
                    });
                  },
                ),
                items: myWidgets),
            Column(
              children: [
                Text('${_current + 1}/${myWidgets.length}'),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: LinearProgressIndicator(
                    value: (_current + 1) / myWidgets.length,
                    minHeight: 10,
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final Map<String, String> questionsAndAnswers = {
  'What is your name?': 'John Doe',
  'How old are you?': '25',
  'Where do you live?': 'New York',
  'What is your favorite color?': 'Blue',
  'What is your hobby?': 'Reading books',
  'What is your favorite food?': 'Pizza',
  'What is your dream job?': 'Software Engineer',
  'What is the capital of France?': 'Paris',
  'What is 5 + 7?': '12',
  'Who is the president of the USA?': 'Joe Biden',
  'What is the square root of 64?': '8',
  'What is the tallest mountain?': 'Mount Everest',
  'What is the largest ocean?': 'Pacific Ocean',
  'What is 10 * 5?': '50',
  'What year did the Titanic sink?': '1912',
  'Who wrote "Romeo and Juliet"?': 'William Shakespeare',
  'What is the currency of Japan?': 'Yen',
  'What is the speed of light?': '299,792,458 m/s',
  'What is the boiling point of water?': '100°C',
  'How many continents are there?': '7',
};
final List<Widget> myWidgets = questionsAndAnswers.entries.map((entry) {
  return VisibilityCard(
    question: entry.key,
    answer: entry.value,
  );
}).toList();

class VisibilityCard extends StatefulWidget {
  final String question;
  final String answer;

  const VisibilityCard({Key? key, required this.question, required this.answer})
      : super(key: key);

  @override
  State<VisibilityCard> createState() => _VisibilityCardState();
}

class _VisibilityCardState extends State<VisibilityCard> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                height: getHgt.hSize / 3,
                decoration: BoxDecoration(
                  color: color.col,
                ),
                child: Center(
                    child: Text(
                  widget.question,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                )),
              ),
            ),
            const SizedBox(height: 30),
            if(visible)
              _answerContainer(widget: widget).animate().fadeIn(duration: 200.ms).slideY(duration: 800.ms,curve: Curves.bounceOut),
          ],
        ),
        Positioned.fill(
          bottom: getHgt.hSize / 3.4,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    visible = !visible; // Toggle visibility
                  });
                },
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 35,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _answerContainer extends StatelessWidget {
  const _answerContainer({
    super.key,
    required this.widget,
  });

  final VisibilityCard widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 200,
      decoration: BoxDecoration(
          color: color.col, borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Text(widget.answer,
            style: const TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }
}
