import 'package:flutter/material.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:project_fluttercse10/main.dart';

import 'homeView.dart';

class quizView extends StatefulWidget {
  const quizView({super.key});

  @override
  State<quizView> createState() => _quizViewState();
}

class _quizViewState extends State<quizView> {
  final PageController _controller = PageController();
  int _currentIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onButtonPressed(int index) {
    _controller.animateToPage(index,
        duration: const Duration(milliseconds: 1), curve: Curves.ease);
    setState(() {
      _currentIndex == 2 ? Theme.of(context).primaryColor : Colors.grey;
    });
  }
  String cardName = "Flashcard Name";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Row(children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back_ios)),
              Text(cardName),
            ])
          ],
        )
      ],
    );
  }
}
