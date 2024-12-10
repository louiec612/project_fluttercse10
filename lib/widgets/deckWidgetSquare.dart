import 'package:flutter/material.dart';
import 'package:project_fluttercse10/provider/deckProvider.dart';
import 'package:project_fluttercse10/view/Quiz%20View/quizView.dart';
import 'package:provider/provider.dart';
import '../db_service/sqf.dart';
import '../provider/cardProvider.dart'; // Your provider file


class deckWidgetSquare extends StatelessWidget {

  const deckWidgetSquare({super.key});


  @override
  Widget build(BuildContext context) {
    return Consumer<deckProvider>(
      builder: (context, tableNameProvider, child) {
        // Fetch table names if not fetched yet
        if (tableNameProvider.recentTables.isEmpty) {
          tableNameProvider.fetchRecentTables();
        }

        return tableNameProvider.recentTables.isEmpty
            ? const Text('No tables found')
            : Expanded(
            child: Consumer<CardClass>(
              builder: (context, cards, child) => GridView.builder(
                itemCount: tableNameProvider.recentTables.length,
                itemBuilder: (context, index) {
                  final tableName = tableNameProvider.recentTables[index];
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: const Color.fromARGB(228, 227, 233, 255),
                            width: 2),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color:
                            Colors.grey.withOpacity(0.2), // Shadow color
                            spreadRadius: 1, // Spread radius
                            blurRadius: 5, // Blur radius
                            offset: const Offset(0, 1),
                          )
                        ]),
                    margin: const EdgeInsets.symmetric(
                        vertical: 5, horizontal: 5),
                    child: ListTile(
                      title: Text(tableName),
                      onTap: () async{
                        DbHelper.dbHelper.tableName = tableName;
                        await cards.getCards();
                        if (cards.allCards.isNotEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => quizView(name: tableName)));
                        }
                      },
                    ),
                  );
                }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
              ),
              ),
            ));
      },
    );
  }
}
