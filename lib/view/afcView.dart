import 'package:flutter/material.dart';
//VIEW FOR ADD/CREATE FLASH CARD
class addFlashcardView extends StatefulWidget {
  const addFlashcardView({super.key});

  @override
  State<addFlashcardView> createState() => _addFlashcardViewState();
}

class _addFlashcardViewState extends State<addFlashcardView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Column(
        children: [
          Center(child: Text('afcView'),),
        ],
      ),
    );
  }
}
