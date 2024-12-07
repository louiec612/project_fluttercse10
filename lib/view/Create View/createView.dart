import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:archive/archive.dart';
import 'package:project_fluttercse10/generator.dart';
import 'package:project_fluttercse10/test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xml/xml.dart';
import 'dart:io';
import 'package:project_fluttercse10/main.dart';

import '../../getset.dart';

final Map<String, String> questionsAndAnswers = generateCard.data;

class AddFlashcardView extends StatefulWidget {
  const AddFlashcardView({super.key});
  @override
  State<AddFlashcardView> createState() => _AddFlashcardViewState();
}

class _AddFlashcardViewState extends State<AddFlashcardView> {
  String? _text = null;

  bool _isChecked = false;
  bool _isVisible = false;
  TextEditingController _topicController = TextEditingController();
  List<MapEntry<String, String>> questionAnswerPairs = [];
  bool _isLoading = false;

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Header with profile section
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.8,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[400],
                ),
                const SizedBox(width: 10),
                const Text(
                  'Andrei Castro',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [

                ////
                ////TEXT

                AnimatedContainer(
                  duration:
                  const Duration(milliseconds: 500), // Animation duration
                  curve: Curves.easeInOut,
                  height: _isChecked ? containerHeight + 40 : containerHeight-4,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0,10,0,0),
                        child: TextField(
                          onChanged: (value) {
                            _text = value;
                          },
                          controller: _topicController,
                          decoration: InputDecoration.collapsed(
                            hintText: 'Enter $stateQ',
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _isVisible,
                        child: Column(
                          children: [
                            Divider(

                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10.0,0,0,0),
                              child: const TextField(
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

                const SizedBox(height: 10),
                Row(
                  children: [
                    ///
                    ///
                    /// BUTTONS
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {

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
          const SizedBox(height: 20),
          const Divider(thickness: 1),
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

class CardWidget extends StatelessWidget {
  final String question;
  final String answer;

  const CardWidget({required this.question, required this.answer, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
          ),
        ],
      ),
      width: double.infinity,
      height: 120,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              question,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            flex: 2,
            child: Text(
              answer,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

