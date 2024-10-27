import 'package:flutter/material.dart';
//VIEW FOR FLASHCARD LISTS
class flashcardView extends StatefulWidget {
  const flashcardView({super.key});

  @override
  State<flashcardView> createState() => _flashcardViewState();
}

class _flashcardViewState extends State<flashcardView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Column(
        children: [
          Center(child: Text('fcView'),),
        ],
      ),
    );
  }
}
