// ignore_for_file: camel_case_types, file_names
import 'package:flutter/material.dart';
import 'package:project_fluttercse10/widgets/deckWidget.dart';
import 'package:provider/provider.dart';
import '../../getset.dart';
import '../../provider/deckProvider.dart';

// VIEW FOR ADD/CREATE FLASH CARD
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
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.school, size: 80, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  'Deck Card Creator',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Center(
          child: Column(
            children: [
              const SizedBox(height: 350),
              const createTable(),
              TableListWidget(),
            ],
          ),
        ),
      ],
    );
  }
}

class createTable extends StatefulWidget {
  const createTable({super.key});

  @override
  State<createTable> createState() => _createTableState();
}

class _createTableState extends State<createTable> {
  bool _isHoveringCreate = false;
  bool _isHoveringDelete = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<deckProvider>(
      builder: (BuildContext context, provider, Widget? child) => Column(
        children: [
          Container(
            width: 400, // Adjust the width to make the search bar smaller
            padding: EdgeInsets.symmetric(horizontal: 10), // Add padding for better spacing
            child: TextField(
              controller: provider.tableNameController,
              decoration: const InputDecoration(
                labelText: 'Create Table Name',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MouseRegion(
                onEnter: (_) => setState(() => _isHoveringCreate = true),
                onExit: (_) => setState(() => _isHoveringCreate = false),
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (provider.tableNameController.text.isNotEmpty) {
                      List<String> a = provider.tableNameController.text.split(" ");
                      String b = a.join("_");
                      provider.createTable(b);
                      provider.fetchTableNames();
                    }
                  },
                  icon: Icon(Icons.add),
                  label: Text(
                    'Create table',
                    style: TextStyle(fontSize: _isHoveringCreate ? 16 : 14),
                  ),
                ),
              ),
              SizedBox(width: 16),
              MouseRegion(
                onEnter: (_) => setState(() => _isHoveringDelete = true),
                onExit: (_) => setState(() => _isHoveringDelete = false),
                child: deleteAllButton(isHovering: _isHoveringDelete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class deleteAllButton extends StatelessWidget {
  final bool isHovering;

  const deleteAllButton({required this.isHovering, super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<deckProvider>(
      builder: (BuildContext context, provider, Widget? child) => ElevatedButton.icon(
        onPressed: () {
          provider.deleteAllTables();
        },
        icon: Icon(Icons.delete),
        label: Text(
          'Delete all',
          style: TextStyle(fontSize: isHovering ? 16 : 14),
        ),
      ),
    );
  }
}
