import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

const apiKey = 'AIzaSyBiTikvtoGbTnJdthLj_BEcXKdhPAxoKW0';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(title: const Text('Generative AI Example')),
        body: Center(
          child: FutureBuilder<String?>(
            future: generate(), // The asynchronous function
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Show a loading indicator while waiting for the result
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}'); // Handle error if any
              } else if (snapshot.hasData) {
                String a = snapshot.data.toString().substring(
                    snapshot.data.toString().indexOf('{') + 1,
                    snapshot.data.toString().lastIndexOf('}')
                );
                List<String> pairs = a.split(',\n');
                // Create a Map<String, String> from the key-value pairs
                Map<String, String> questionAnswerMap = {};
                for (var pair in pairs) {
                  // Split each pair into a key and value by the colon ":"
                  List<String> keyValue = pair.split('": "');
                  // Clean up the key and value by removing quotes
                  if (keyValue.length == 2) {
                    String key = keyValue[0].replaceAll('"', '').trim();
                    String value = keyValue[1].replaceAll('"', '').trim();
                    questionAnswerMap[key] = value;
                  }
                }
                // Now `questionAnswerMap` is a proper Map<String, String>
                print(questionAnswerMap.runtimeType);
                return Text('${questionAnswerMap}'); // Display the result
              } else {
                return const Text('No data available');
              }
            },
          ),
        ),
      ),
    );
  }
}

Future<String?> generate() async {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: apiKey,
  );

  const prompt = 'I want you to create a dart map like this, "Question": "Answer", Any topic, and 20 questions. Remove ```dart at the beginning and end specifically, ';
  final content = [Content.text(prompt)];
  final response = await model.generateContent(content);
  return response.text;
}
