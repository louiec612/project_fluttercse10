import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:archive/archive.dart';
import 'package:project_fluttercse10/generator.dart';
import 'package:project_fluttercse10/test.dart';
import 'package:project_fluttercse10/widgets/cardsWidget.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xml/xml.dart';
import 'dart:io';
import 'package:project_fluttercse10/main.dart';

import '../../getset.dart';
import '../../provider/cardProvider.dart';

// final Map<String, String> questionsAndAnswers = generateCard.data;

class AddFlashcardView extends StatefulWidget {
  const AddFlashcardView({super.key});
  @override
  State<AddFlashcardView> createState() => _AddFlashcardViewState();
}

class _AddFlashcardViewState extends State<AddFlashcardView> {
  String? _text = null;

  bool _isChecked = false;
  bool _isVisible = false;
  // List<MapEntry<String, String>> questionAnswerPairs = [];
  String stateQ = 'A Topic';
  String stateA = 'Answer';

  double containerHeight = 50;

  void _delayedVisibility() {
    if (_isVisible == false) {
      stateQ = 'Question';
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _isVisible = true; // Make the widget visible after 2 seconds
        });
      });
    } else {
      stateQ = 'A Topic';
      _isVisible = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CardClass>(builder: (BuildContext context,provider,Widget? child)=>Column(
        children: [
          // Header with profile section
          Container(
            decoration: const BoxDecoration(
                color: Colors.blue,
      borderRadius:
      BorderRadius.vertical(bottom: Radius.circular(25))
            ),

              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                  // DropdownMenu(dropdownMenuEntries: dropdownMenuEntries)
                    const SizedBox(height:20),
                    ////TEXT
                    AnimatedContainer(
                      duration:
                      const Duration(milliseconds: 500), // Animation duration
                      curve: Curves.easeInOut,

                      height: _isChecked ? containerHeight + 40 : containerHeight-4,
                      decoration: BoxDecoration(
                        color:Colors.white,
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0,10,0,0),
                            child: TextField(
                              controller: provider.promptController,
                              decoration: InputDecoration.collapsed(
                                hintText: 'Enter $stateQ',
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _isVisible,
                            child: const Column(
                              children: [
                                Divider(

                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10.0,0,0,0),
                                  child: TextField(
                                    decoration: InputDecoration.collapsed(
                                      hintText: 'Enter Answer',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async{
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[600],
                      ),
                      child: const Text(
                        'Import',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async{
                        provider.deleteAllCards();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[600],
                      ),
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if(_isVisible == false){
                                provider.generateAndInsertQuestions();
                                print('Prompt ${provider.promptController.text}');
                              }

                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[600],
                            ),
                            child: const Text(
                              'Generate',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Add functionality for Front & Back button here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[600],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Front & Back',
                                  style: TextStyle(color: Colors.white),
                                ),
                                const SizedBox(width: 5),
                                Switch(
                                  value: _isChecked,
                                  onChanged: (bool value) {
                                    _delayedVisibility();
                                    setState(() {
                                      _isChecked = value;
                                    });
                                  },
                                  activeColor: Colors.white,
                                  activeTrackColor: Colors.teal,
                                  inactiveTrackColor: Colors.grey[400],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     String topic = _topicController.text.trim();
                    //     if (topic.isEmpty) {
                    //       ScaffoldMessenger.of(context).showSnackBar(
                    //         const SnackBar(
                    //           content: Text('Please enter a topic!'),
                    //         ),
                    //       );
                    //       return;
                    //     }
                    //     setState(() => _isLoading = true);
                    //
                    //   },
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Colors.grey[600],
                    //     minimumSize: Size(150, 50),
                    //     padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    //     textStyle: const TextStyle(fontSize: 14),
                    //   ),
                    //   child: _isLoading
                    //       ? const CircularProgressIndicator(
                    //     color: Colors.white,
                    //   )
                    //       : const Text(
                    //     'Generate',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Added Cards',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(itemCount
                : provider.allCards.length,
              itemBuilder: (context,index){
                return CardWidget(provider.allCards[index]);
              },),
          ),
          const SizedBox(height: 10),
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 20),
          //     child: ListView.builder(
          //       itemCount: questionAnswerPairs.length,
          //       itemBuilder: (context, index) {
          //         final pair = questionAnswerPairs[index];
          //         return Column(
          //           children: [
          //             CardWidget(question: pair.key, answer: pair.value),
          //             const SizedBox(height: 10),
          //           ],
          //         );
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

