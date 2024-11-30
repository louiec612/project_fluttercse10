// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';

import '../getset.dart';
//VIEW FOR ADD/CREATE FLASH CARD
class addFlashcardView extends StatelessWidget {
  const addFlashcardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Makes the content scrollable
      child: Stack(
        children: [
          Container(
            width: getWid.wSize,
            height: getHgt.hSize / 2.8,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(15))),
          ),
          const Column(
            children: [
              Text("Add Card View"),
            ],
          ),
        ],
      ),
    );
  }
}
