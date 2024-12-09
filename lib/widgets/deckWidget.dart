import 'package:flutter/material.dart';
import 'package:project_fluttercse10/provider/deckProvider.dart';
import 'package:project_fluttercse10/view/Quiz%20View/quizView.dart';
import 'package:provider/provider.dart';
import '../db_service/sqf.dart';
import '../provider/cardProvider.dart';// Your provider file

class TableListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<deckProvider>(
      builder: (context, tableNameProvider, child) {
        // Fetch table names if not fetched yet
        if (tableNameProvider.tableNames.isEmpty) {
          tableNameProvider.fetchTableNames();
        }
        return tableNameProvider.tableNames.isEmpty
            ? const Text('No tables found')
            : Expanded(
          child: Consumer<CardClass>(
            builder: (context, cards, child) => ListView.builder(
            itemCount: tableNameProvider.tableNames.length,
            itemBuilder: (context, index) {
              final tableName = tableNameProvider.tableNames[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: ListTile(
                  title: Text(tableName),
                  trailing: const Icon(Icons.table_chart),
                  onTap: (){
                    DbHelper.dbHelper.tableName = tableName;
                    cards.getCards();
                    if(cards.allCards.isNotEmpty){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const quizView()));
                    }

                  },
                ),
              );
            },
          ),
        ));
      },
    );
  }
}
