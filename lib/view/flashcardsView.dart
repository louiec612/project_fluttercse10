// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:project_fluttercse10/main.dart';
//VIEW FOR FLASHCARD LISTS
class flashcardView extends StatefulWidget {
  const flashcardView({super.key});

  @override
  State<flashcardView> createState() => _flashcardViewState();
}

class _flashcardViewState extends State<flashcardView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: getWid.wSize,
          height: getHgt.hSize/2.8,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(15))),
        ),
      ],
    );
  }
}
