// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:project_fluttercse10/view/quizView.dart';

import '../getset.dart';

//VIEW FOR ADD/CREATE FLASH CARD
class deckView extends StatelessWidget {
  const deckView({super.key});

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

          Center(
            child: Column(
              children: [
                const SizedBox(height:350),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                        BoxShadow(
                        color: Colors.grey.withOpacity(0.8),
                        blurRadius: 25, // Spread of the blur
                        spreadRadius: 1, // Spread radius of shadow
                        offset: const Offset(0, 0), // Center shadow
                      ),
                    ],
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.white70,
                        width: 1.0,
                      ),
                       borderRadius: BorderRadius.circular(20),
                    ),                    elevation: 0,
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const quizView())
                        );
                      },
                      child: const SizedBox(
                        width: 350,
                        height: 80,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text('Deck 1'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
