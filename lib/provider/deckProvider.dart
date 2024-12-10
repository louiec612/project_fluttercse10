import 'package:flutter/material.dart';
import '../db_service/sqf.dart';
import '../model/cardModel.dart';

class deckProvider with ChangeNotifier {
  String _selectedValue = 'no_table'; // Default selected value
  String get selectedValue => _selectedValue;
  List<String> _tableNames = [];
  List<String> get tableNames => _tableNames;

  List<String> _recentTables = [];
  List<String> get recentTables => _recentTables;

  TextEditingController tableNameController = TextEditingController();

  // Method to update the selected value and notify listeners
  void updateSelectedValue(String newValue) {
    _selectedValue = newValue;
    print(newValue);
    notifyListeners();
  }

  Future<void> createTable(String table) async {
    await DbHelper.dbHelper.createTable(table);
    fetchTableNames();
    notifyListeners();
  }

  Future<bool> tableExist(String table) async {
    bool a = await DbHelper.dbHelper.tableExist(table);
    return a;
  }

  Future<void> fetchTableNames() async {
    _tableNames = await (DbHelper.dbHelper.getTableNamesSortedByCreation());
    notifyListeners();
  }

   Future<void> fetchRecentTables() async {
    _recentTables = await (DbHelper.dbHelper.getTableNamesSortedByCreationLimited());
    notifyListeners();
  }

  Future<void> deleteAllTables() async {
    await (DbHelper.dbHelper.deleteAllTables());
    await fetchTableNames();
    notifyListeners();
  }

  Future<void> deleteTable(String table) async{
    await DbHelper.dbHelper.deleteTable(table);
    await fetchTableNames();
    notifyListeners();
  }

  // Future<int> getCount(String table) async {
  //   var a = await DbHelper.dbHelper.countRows(table);
  //   notifyListeners();
  //   return a;
  // }



}