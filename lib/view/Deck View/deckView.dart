// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';

import 'package:project_fluttercse10/widgets/deckWidget.dart';
import 'package:provider/provider.dart';

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
           Center(
            child: Column(
              children: [
                const SizedBox(height: 350),
                const createTable(),
                const deleteAllButton(),
                TableListWidget(),
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
    return Consumer<deckProvider>(builder: (BuildContext context, provider, Widget? child) =>
        ElevatedButton(onPressed: (){
          provider.deleteAllTables();
      }, child: const Text('Delete all')),
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
        builder: (BuildContext context, provider, Widget? child) => Column(
      children: [
        TextField(
          controller: provider.tableNameController,
        ),
        ElevatedButton(onPressed:(){
          if (provider.tableNameController.text.isNotEmpty) {
            List<String> a = provider.tableNameController.text.split(" ");
            String b = a.join("_");
            provider.createTable(b);
            provider.fetchTableNames();
          }
          // print('Table Created: ${provider.tableNameController.text}');
        }, child: const Text('Create table'))
      ],
    ));
  }
}