import 'package:google_generative_ai/google_generative_ai.dart';

const apiKey = 'AIzaSyBiTikvtoGbTnJdthLj_BEcXKdhPAxoKW0';
String numberOfQuestions = "5";

class QuestionAnswerGenerator {
  final String apiKey;

  QuestionAnswerGenerator(this.apiKey);

  /// Asynchronous function to generate the map
  Future<Map<String, String>> generate(String prompt,int num) async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: apiKey,
    );

    var fullPrompt =
        'I want you to create a dart map like this, "Question": "Answer", Any topic, and exactly $num questions with different question types. Remove ```dart at the beginning and end specifically, make the questions about $prompt, shorten the question into 1 sentence and you decide if the answer should be 1-3 words or the answer should be long, but short answer as much as possible';

    final content = [Content.text(fullPrompt)];
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