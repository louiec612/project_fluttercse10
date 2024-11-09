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
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 350,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(15))),
          ),
        ],
      ),
    );
  }
}
