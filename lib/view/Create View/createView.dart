import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:project_fluttercse10/config.dart';

String numberOfQuestions = "30";

class addFlashcardView extends StatefulWidget {
  const addFlashcardView({super.key});

  @override
  State<addFlashcardView> createState() => _addFlashcardViewState();
}

class _addFlashcardViewState extends State<addFlashcardView> {
  bool _isChecked = false;
  final TextEditingController _topicController = TextEditingController();
  List<MapEntry<String, String>> questionAnswerPairs = [];
  bool _isLoading = false;

  Future<Map<String, String>> generateQuestions(String topic) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );

    var prompt =
        'I want you to create a dart map like this, "Question": "Answer", Any topic, and exactly $numberOfQuestions question with different question types. Remove ```dart at the beginning and end specifically, make the questions about $topic, shorten the question into 1 sentence and 1-3 words for answers';
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    if (response.text == null || response.text!.isEmpty) {
      throw Exception("No data returned from the API");
    }

    String rawData = response.text!;
    String trimmedData = rawData.substring(
        rawData.indexOf('{') + 1, rawData.lastIndexOf('}'));

    List<String> pairs = trimmedData.split(',\n');
    Map<String, String> questionAnswerMap = {};

    for (var pair in pairs) {
      List<String> keyValue = pair.split('": "');
      if (keyValue.length == 2) {
        String key = keyValue[0].replaceAll('"', '').trim();
        String value = keyValue[1].replaceAll('"', '').trim();
        questionAnswerMap[key] = value;
      }
    }

    return questionAnswerMap;
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
                        onPressed: () {
                          // Add functionality for Import button here
                        },
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
                      Map<String, String> generatedData =
                      await generateQuestions(topic);
                      setState(() {
                        questionAnswerPairs = generatedData.entries.toList();
                      });
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
                    minimumSize: Size(150, 50), // Adjust width and height as needed
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    textStyle: const TextStyle(
                      fontSize: 14, // Increase the font size to make the button look bigger
                    ),
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

          // Divider
          const Divider(thickness: 1),

          // Added Cards title
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

          // Added Cards list
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
      width: double.infinity, // Makes it stretch to the parent's width
      height: 120, // Fixed height for uniformity
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
          const SizedBox(width: 15), // Space between question and answer
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

