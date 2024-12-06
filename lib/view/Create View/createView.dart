import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:archive/archive.dart';
import 'package:xml/xml.dart';
import 'dart:io';

class AddFlashcardView extends StatefulWidget {
  const AddFlashcardView({super.key});

  @override
  State<AddFlashcardView> createState() => _AddFlashcardViewState();
}

class _AddFlashcardViewState extends State<AddFlashcardView> {
  bool _isChecked = false;
  final TextEditingController _topicController = TextEditingController();
  List<MapEntry<String, String>> questionAnswerPairs = [];
  bool _isLoading = false;

  Future<void> importDocxFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['docx'],
    );

    if (result != null && result.files.single.bytes != null) {
      try {
        List<int> bytes = result.files.single.bytes!;
        Archive archive = ZipDecoder().decodeBytes(bytes);

        String? documentXml;
        for (var file in archive) {
          if (file.name == 'word/document.xml') {
            documentXml = String.fromCharCodes(file.content);
            break;
          }
        }

        if (documentXml == null) {
          throw Exception('Could not find document.xml in the .docx file');
        }

        XmlDocument xmlDocument = XmlDocument.parse(documentXml);
        List<String> textList = [];
        for (var element in xmlDocument.findAllElements('w:t')) {
          String text = element.text.trim();
          if (text.isNotEmpty) {
            textList.add(text);
          }
        }

        List<MapEntry<String, String>> flashcards = [];
        String? currentQuestion;
        String? currentAnswer;

        for (var line in textList) {
          if (line.isEmpty) {
            continue;
          }

          if (currentQuestion == null) {
            // This line is a question
            currentQuestion = line;
          } else if (currentAnswer == null) {
            // This line is an answer
            currentAnswer = line;
            flashcards.add(MapEntry(currentQuestion, currentAnswer));
            currentQuestion = null;
            currentAnswer = null;
          }
        }

        if (currentQuestion != null) {
          print('Warning: There is a question without an answer: "$currentQuestion"');
        }

        // Update the state with parsed question-answer pairs
        setState(() {
          questionAnswerPairs = flashcards;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error reading file: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No file selected or invalid file')),
      );
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

          // Topic input and buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                TextField(
                  controller: _topicController,
                  decoration: InputDecoration(
                    hintText: 'Enter A Topic',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: importDocxFile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[600],
                        ),
                        child: const Text(
                          'Import',
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
                ElevatedButton(
                  onPressed: () async {
                    String topic = _topicController.text.trim();
                    if (topic.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a topic!'),
                        ),
                      );
                      return;
                    }
                    setState(() => _isLoading = true);

                    try {
                      // Call importDocxFile instead of generateQuestions
                      await importDocxFile();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    } finally {
                      setState(() => _isLoading = false);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[600],
                    minimumSize: Size(150, 50),
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    textStyle: const TextStyle(fontSize: 14),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : const Text(
                    'Generate',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: questionAnswerPairs.length,
                itemBuilder: (context, index) {
                  final pair = questionAnswerPairs[index];
                  return Column(
                    children: [
                      CardWidget(question: pair.key, answer: pair.value),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
          ),
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
