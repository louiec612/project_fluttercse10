import 'package:sqflite/sqflite.dart';
import '../model/cardModel.dart';

class DbHelper {
  late Database database;

  static DbHelper dbHelper = DbHelper();
  final String databaseName = 'cards.db';
  final String tableName = 'cards';
  final String idColumn = 'id';
  final String questionColumn = 'question';
  final String answerColumn = 'answer';

  initDatabase() async {
    database = await connectToDatabase();
  }

  Future<Database> connectToDatabase() async {
    return openDatabase(
      databaseName,
      version: 2,
      onCreate: (db,version) {
        db.execute('''
      CREATE TABLE $tableName (
        $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
        $questionColumn TEXT,
        $answerColumn TEXT
      )
    ''');
      },
    );
  }

  Future<List<Cards>> getAllCards() async{
    List<Map<String,dynamic>> cards = await database.query(tableName,orderBy: 'id DESC');
    return cards.map((e) => Cards.fromMap(e)).toList();
  }
//INSERT
  insertNewCard(Cards card){
    database.insert(tableName,card.toMap());
  }
//DELETE
  deleteCard(Cards card){
    database.delete(tableName, where:'$idColumn=?',whereArgs: [card.id]);
  }
//DELETE ALL
  Future<void> clearTable() async {
    final db = await database;
    await db.execute('DELETE FROM $tableName'); // Deletes all rows
    await db.execute('VACUUM'); // Optimizes the database and resets AUTOINCREMENT
  }
//UPDATECARD
  updateCard(Cards card) async{
    await database.update(tableName,
    {
      questionColumn: card.question,
      answerColumn: card.answer
    },
    where: '$idColumn=?',whereArgs: [card.id]);

  }

  Future<void> insertNewCardsFromMap(Map<String, String> questionsAndAnswers) async {
    final db = await database;

    for (var entry in questionsAndAnswers.entries) {
      await db.insert(
        tableName,
        {
          questionColumn: entry.key,
          answerColumn: entry.value,
        },
      );
    }
  }


}
