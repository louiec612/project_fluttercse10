import 'package:flutter/material.dart';
import 'package:project_fluttercse10/db_service/sqf.dart';
import 'package:project_fluttercse10/model/cardModel.dart';
import '../generator.dart';

class CardClass extends ChangeNotifier{
  CardClass(){
    getCards();
  }

  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  TextEditingController promptController = TextEditingController();


  List<Cards> allCards =[];

  getCards() async{
    allCards = await DbHelper.dbHelper.getAllCards();
    notifyListeners();
  }

  insertNewCard(){
    Cards cards = Cards(
      question: questionController.text,
      answer: answerController.text,
    );
    DbHelper.dbHelper.insertNewCard(cards);
    getCards();
  }

  updateCard(Cards card) async{
    await DbHelper.dbHelper.updateCard(card);
    getCards();
  }

  deleteCard(Cards card){
    DbHelper.dbHelper.deleteCard(card);
    getCards();
  }

  Future<void> deleteAllCards() async {
    await DbHelper.dbHelper.clearTable();
    getCards();
  }
  bool isLoading = false;
  Future<void> generateAndInsertQuestions() async {
    isLoading = true;
    notifyListeners();

    try {
      String prompt = promptController.text;
      if (prompt.isEmpty) {
        throw Exception("Prompt cannot be empty");
      }

      final generator = QuestionAnswerGenerator(apiKey);
      final questionAnswerMap = await generator.generate(prompt);

      await insertCardsFromMap(questionAnswerMap);
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> insertCardsFromMap(Map<String, String> questionsAndAnswers) async {
    await DbHelper.dbHelper.insertNewCardsFromMap(questionsAndAnswers);
    await getCards();
  }

}