import 'package:flutter/material.dart';
import 'package:project_fluttercse10/provider/deckProvider.dart';
import 'package:project_fluttercse10/view/Quiz%20View/quizView.dart';
import 'package:provider/provider.dart';
import '../db_service/sqf.dart';
import '../provider/cardProvider.dart'; // Your provider file


class TableListWidget extends StatelessWidget {

  const TableListWidget({super.key});


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
                    return Container(
                      height: 100,
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
                          vertical: 10, horizontal: 15),
                      child: ListTile(
                        title: Text(tableName),
                        subtitle: FutureBuilder<int>(
                          future: DbHelper.dbHelper
                              .countRows(tableName), // The future to resolve
                          builder: (context, snapshot) {
                              return Text(
                                  'Cards: ${snapshot.data}'); // Display the resolved data
                          },
                        ),
                        trailing:Padding(
                          padding: const EdgeInsets.all(0),
                          child: PopupMenuButton(
                            itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry>[
                              PopupMenuItem(
                                child: const Text('Delete'),
                                onTap: (){
                                  showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Confirmation'),
                                    content: const Text('Delete Deck?'),
                                    actions: <Widget>[

                                      TextButton(
                                        onPressed: () => Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          tableNameProvider.deleteTable(tableName);
                                          Navigator.pop(context, 'OK');
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ));
                                },
                              ),
                              PopupMenuItem(
                                  child: const Text('Edit'),
                                  onTap: (){
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) => AlertDialog(
                                        title: const Text('Confirmation'),
                                        content: const Text('AlertDialog description'),
                                        actions: <Widget>[
                                          // TextField(
                                          //   controller: provider.questionController,
                                          // ),
                                          // TextField(
                                          //   controller: provider.answerController,
                                          // ),
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, 'Cancel'),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: (){
                                              // provider.updateCard(card);
                                            Navigator.pop(context, 'OK');
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );}
                              ),
                            ],
                          ),
                        ),
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
                  },
                ),
              ));
      },
    );
  }
}
