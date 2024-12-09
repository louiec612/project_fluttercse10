import 'package:sqflite/sqflite.dart';
import '../model/cardModel.dart';

class DbHelper {
  late Database database;
  static DbHelper dbHelper = DbHelper();
  final String databaseName = 'deck.db';
  String? tableName = 'no_table';
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
    ''');}
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $tableName 
        ( $idColumn INTEGER PRIMARY KEY AUTOINCREMENT, 
        $questionColumn TEXT, 
        $answerColumn TEXT ); 
        CREATE TABLE usage_times ( 
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        duration INTEGER ); 
        ''');
      },
    );
  }

  Future<void> saveUsageTime(int duration) async {
    await database.insert(
      'usage_times',
      {
        'duration': duration,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> printUsageTimes() async {
    final List<Map<String, dynamic>> usageTimes =
        await database.query('usage_times', orderBy: 'id DESC');
    for (var row in usageTimes) {
      print('ID: ${row['id']}, Duration: ${row['duration']} seconds');
    }
  }

  Future<List<Map<String, dynamic>>> getUsageTimes() async {
    return await database.query('usage_times', orderBy: 'id DESC');
  }

  Future<List<Cards>> getAllCards() async {
    final db = await database;
    List<Map<String, dynamic>> cards =
        await db.query(tableName!, orderBy: 'id DESC');
    return cards.map((e) => Cards.fromMap(e)).toList();
  }

  insertNewCard(Cards card) {
    database.insert(tableName!, card.toMap());
  }

  deleteCard(Cards card) {
    database.delete(tableName!, where: '$idColumn=?', whereArgs: [card.id]);
  }

  Future<void> clearTable() async {
    final db = await database;

    await db.execute('DELETE FROM $tableName'); // Deletes all rows
    await database
        .execute('VACUUM'); // Optimizes the database and resets AUTOINCREMENT
  }

  updateCard(Cards card) async {
    final db = await database;
    await db.update(
        tableName!, {questionColumn: card.question, answerColumn: card.answer},
        where: '$idColumn=?', whereArgs: [card.id]);
  }

  Future<void> insertNewCardsFromMap(
      Map<String, String> questionsAndAnswers) async {
    for (var entry in questionsAndAnswers.entries) {
      await database.insert(
        tableName!,
        {
          questionColumn: entry.key,
          answerColumn: entry.value,
        },
      );
    }
  }

  Future<void> createTable(String table) async {
    final db = await database;
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $table (
      $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
        $questionColumn TEXT,
        $answerColumn TEXT
    )
  ''');
  }

  Future<List<String>> getTableNames() async {
    final db = await database; // Assuming 'database' is already defined
    try {
      final List<Map<String, dynamic>> result = await db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'"
      );
      return result.map((row) => row['name'] as String).toList();
    } catch (e) {
      // Handle error appropriately, maybe log it or return an empty list
      print("Error fetching table names: $e");
      return [];
    }
  }

  Future<void> deleteAllTables() async {
    final db = await database;
    try {
      final tableNames = await getTableNames();
      for (var tableName in tableNames) {
        await db.execute('DROP TABLE IF EXISTS $tableName');
      }
      print("All tables have been deleted.");
    } catch (e) {
      print("Error deleting tables: $e");
    }
  }

  Future<int> countRows(String tableName) async {
    final db = await database;
    var result = await db.rawQuery('SELECT COUNT(*) as count FROM $tableName');
    int count = Sqflite.firstIntValue(result) ?? 0; // Extract the count value
    return count;
  }

}
