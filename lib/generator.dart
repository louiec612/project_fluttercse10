
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'getset.dart';
import 'package:google_generative_ai/google_generative_ai.dart';


const apiKey = 'AIzaSyBiTikvtoGbTnJdthLj_BEcXKdhPAxoKW0';
String topic = "Grade 1 Mathematics";
String numberOfQuestions = "30";

class QuestionAnswerGenerator {
  final String apiKey;

  QuestionAnswerGenerator(this.apiKey);

  /// Asynchronous function to generate the map
  Future<Map<String, String>> generate() async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );

    var prompt = 'I want you to create a dart map like this, "Question": "Answer", Any topic, and exactly $numberOfQuestions question with different question types. Remove ```dart at the beginning and end specifically, make the questions about $topic, shorten the question into 1 sentence and 1-3 words for answers';
    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    if (response.text == null || response.text!.isEmpty) {
      throw Exception("No data returned from the API");
    }

    // Extracting and processing the response text
    String rawData = response.text!;
    String trimmedData = rawData.substring(
        rawData.indexOf('{') + 1,
        rawData.lastIndexOf('}')
    );

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
}

