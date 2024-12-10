import 'package:flutter/material.dart';
import 'package:project_fluttercse10/provider/deckProvider.dart';
import 'package:project_fluttercse10/view/Quiz%20View/quizView.dart';
import 'package:provider/provider.dart';
import '../db_service/sqf.dart';
import '../provider/cardProvider.dart'; // Your provider file

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
            ? Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'No tables found',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 15,
              endIndent: 15,
            ),
          ],
        )
            : Expanded(
          child: Consumer<CardClass>(
            builder: (context, cards, child) => ListView.builder(
              itemCount: tableNameProvider.tableNames.length,
              itemBuilder: (context, index) {
                final tableName = tableNameProvider.tableNames[index];

                return Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(228, 227, 233, 255),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2), // Shadow color
                        spreadRadius: 1, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    title: Text(tableName),
                    subtitle: FutureBuilder<int>(
                      future: DbHelper.dbHelper.countRows(tableName), // The future to resolve
                      builder: (context, snapshot) {
                        return Text(
                          'Cards: ${snapshot.data}',
                          style: TextStyle(color: Colors.grey[600]),
                        ); // Display the resolved data
                      },
                    ),
                    trailing: const Icon(Icons.table_chart),
                    onTap: () async {
                      DbHelper.dbHelper.tableName = tableName;
                      await cards.getCards();
                      if (cards.allCards.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const quizView(),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
