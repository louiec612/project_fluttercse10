// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';

import 'package:project_fluttercse10/widgets/deckWidget.dart';
import 'package:provider/provider.dart';

import '../../db_service/sqf.dart';
import '../../getset.dart';

import '../../provider/deckProvider.dart';

//VIEW FOR ADD/CREATE FLASH CARD
class deckView extends StatelessWidget {
  const deckView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: getWid.wSize,
          height: getHgt.hSize / 2.8,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(15))),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 100),
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Image.network(
                      'https://pop.inquirer.net/files/2021/05/gigachad.jpg',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Andrei Castro',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        Center(
          child: Column(
            children: [
              SizedBox(height: getWid.wSize / 1.65),
              Center(
                child: Container(
                  width: getWid.wSize * 0.93,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(27)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 15,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Text(
                          "Search Flashcards",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Search Here',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const createTable(),
              // deleteAllButton(),
              const TableListWidget(),
            ],
          ),
        ),
      ],
    );
  }
}

class deleteAllButton extends StatelessWidget {
  const deleteAllButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<deckProvider>(
      builder: (BuildContext context, provider, Widget? child) =>
          ElevatedButton(
              onPressed: () {
                provider.deleteAllTables();
              },
              child: const Text('Delete all')),
    );
  }
}

class createTable extends StatefulWidget {
  const createTable({super.key});

  @override
  State<createTable> createState() => _createTableState();
}

class _createTableState extends State<createTable> {
  @override
  Widget build(BuildContext context) {
    return Consumer<deckProvider>(
        builder: (BuildContext context, provider, Widget? child) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Enter Table Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.blue, // Border color
                          width: 2, // Border width
                        ),
                      ),
                    ),
                    controller: provider.tableNameController,
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 50), // Adjust the button size here
                    //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust the padding
                  ),
                  onPressed: () async {
                    if (provider.tableNameController.text.isNotEmpty) {
                      if (await provider
                          .tableExist(provider.tableNameController.text)) {
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                    title: const Text('Error'),
                                    content: const Text('Table Exist!'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                    ]));
                      }
                      List<String> a =
                          provider.tableNameController.text.split(" ");
                      String b = a.join("_");
                      provider.createTable(b);
                      provider.fetchTableNames();
                    }
                  },
                  label: const Text(
                    'Create',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ));
  }
}
