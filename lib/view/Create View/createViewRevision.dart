import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:archive/archive.dart';
import 'package:project_fluttercse10/generator.dart';
import 'package:project_fluttercse10/provider/deckProvider.dart';
import 'package:project_fluttercse10/test.dart';
import 'package:project_fluttercse10/widgets/cardsWidget.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:xml/xml.dart';
import 'dart:io';
import 'package:project_fluttercse10/main.dart';

import '../../getset.dart';
import '../../provider/animationProvider.dart';
import '../../provider/cardProvider.dart';

class addFlashCardView extends StatefulWidget {
  const addFlashCardView({super.key});

  @override
  State<addFlashCardView> createState() => _addFlashCardViewState();
}

class _addFlashCardViewState extends State<addFlashCardView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CardClass>(
      builder: (BuildContext context, provider, Widget? child) => Column(
        children: [
          Container(
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(25))),
              child: Column(
                children: [
                  dropdownDeck(),
                  createBar(
                    provider: provider,
                  ),
                  Row(
                    children: [
                      importButton(),
                      deleteButton(provider: provider,),

                    ],
                  ),
                  Row(
                    children: [
                      generateButton(provider: provider),
                      changeType(),
                    ],
                  )

                ],
              )),
          Expanded(
            child: ListView.builder(
              itemCount: provider.allCards.length,
              itemBuilder: (context, index) {
                return CardWidget(provider.allCards[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class dropdownDeck extends StatelessWidget {
  const dropdownDeck({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> items = [
      'Deck1',
    ];
    return Consumer<deckProvider>(
        builder: (BuildContext context, deck, Widget? child) => DropdownMenu(
          initialSelection: items[0],

          label: const Text('Select Deck'),dropdownMenuEntries:
    items.map<DropdownMenuEntry<String>>((String menu) {
      return DropdownMenuEntry<String>(
          value: menu,
        label: menu,
          );
    }).toList(),
        onSelected:  (newValue) {
      // Update the selected value in the provider
      if (newValue != null) {
        deck.updateSelectedValue(newValue);
      }
    },),
    );

  }
}




class changeType extends StatelessWidget {
  const changeType({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<animation>(
        builder: (BuildContext context,give,Widget? child)=>ElevatedButton(
      onPressed: () {
        // Add functionality for Front & Back button here
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[600],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Front & Back',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(width: 5),
          Switch(
            value: give.value,
            onChanged: (bool value) {
              give.setValue(value);
            },
            activeColor: Colors.white,
            activeTrackColor: Colors.teal,
            inactiveTrackColor: Colors.grey[400],
          ),
        ],
      ),
    ));
  }
}

class generateButton extends StatelessWidget {
  final CardClass provider;
  const generateButton({
    super.key, required this.provider
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<animation>(
      builder: (BuildContext context,give,Widget? child)=>ElevatedButton(
          onPressed: () {
            if(give.value == false){
              provider.generateAndInsertQuestions();
              print('Prompt ${provider.promptController.text}');
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[600],
          ),
          child: const Text(
            'Generate',
            style: TextStyle(color: Colors.white),
          ),
        ),);
  }
}

class deleteButton extends StatelessWidget {
  final CardClass provider;
  const deleteButton({
    super.key, required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async{
        provider.deleteAllCards();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[600],
      ),
      child: const Text(
        'Delete',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class importButton extends StatelessWidget {
  const importButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async{
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[600],
      ),
      child: const Text(
        'Import',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class createBar extends StatelessWidget {
  final CardClass provider;

  const createBar({super.key, required this.provider,});

  @override
  Widget build(BuildContext context) {
    String stateQ = 'A Topic';
    double containerHeight = 50;
    return Consumer<animation>(
      builder: (BuildContext context,give,Widget? child)=>AnimatedContainer(
        duration: const Duration(milliseconds: 500), // Animation duration
        curve: Curves.easeInOut,

        height: give.value ? containerHeight+40 : containerHeight - 4,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10, 0, 0),
              child: TextField(
                controller: provider.promptController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Enter $stateQ',
                ),
              ),
            ),
            Visibility(
              visible: give.value,
              child: const Column(
                children: [
                  Divider(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                    child: TextField(
                      decoration: InputDecoration.collapsed(
                        hintText: 'Enter Answer',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
