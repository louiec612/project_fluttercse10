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
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3.5,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height:10),
                const dropdownDeck(),
                const SizedBox(height:10),
                createBar(
                  provider: provider,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        generateButton(provider: provider),
                        const SizedBox(width: 5),
                        const importButton(),
                        const SizedBox(width: 5),
                        const changeType(),
                        const SizedBox(width: 5),
                        deleteButton(
                          provider: provider,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
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
        label: const Text('Select Deck'),
        dropdownMenuEntries:
            items.map<DropdownMenuEntry<String>>((String menu) {
          return DropdownMenuEntry<String>(
            value: menu,
            label: menu,
          );
        }).toList(),
        onSelected: (newValue) {
          // Update the selected value in the provider
          if (newValue != null) {
            deck.updateSelectedValue(newValue);
          }
        },
      ),
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
        builder: (BuildContext context, give, Widget? child) => SizedBox(
          height: 50,
          width: 200,
          child: ElevatedButton(
                onPressed: () {
                  give.reverseValue();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isHoveredGenerate ? Colors.grey[700] : Colors.grey[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 5,
                  shadowColor: Colors.black.withOpacity(0.3),
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
              ),
        ));
  }
}

class generateButton extends StatefulWidget {
  final CardClass provider;
  const generateButton({super.key, required this.provider});

  @override
  State<generateButton> createState() => _generateButtonState();
}
bool _isHoveredGenerate = false;
class _generateButtonState extends State<generateButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<animation>(
      builder: (BuildContext context, give, Widget? child) => MouseRegion(
        onEnter: (_) {
          setState(() {
            _isHoveredGenerate = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isHoveredGenerate = false;
          });
        },
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              if (give.value == false) {
                widget.provider.generateAndInsertQuestions();
                print('Prompt ${widget.provider.promptController.text}');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _isHoveredGenerate ? Colors.grey[700] : Colors.grey[600],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 5,
              shadowColor: Colors.black.withOpacity(0.3),
            ),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: Colors.white,
                fontSize: _isHoveredGenerate ? 16 : 14,
              ),
              child: const Text('Generate'),
            ),

          ),
        ),
      ),
    );
  }
}

class deleteButton extends StatelessWidget {
  final CardClass provider;
  const deleteButton({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
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

class importButton extends StatefulWidget {
  const importButton({
    super.key,
  });

  @override
  State<importButton> createState() => _importButtonState();
}
bool isHoveredImport = false;
class _importButtonState extends State<importButton> {
  @override
  Widget build(BuildContext context) {

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHoveredImport = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHoveredImport = false;
        });
      },
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: () async {},
          style: ElevatedButton.styleFrom(
            backgroundColor: isHoveredImport ? Colors.grey[700] : Colors.grey[600],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 5,
            shadowColor: Colors.black.withOpacity(0.3),
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              color: Colors.white,
              fontSize: isHoveredImport ? 16 : 14,
            ),
            child: const Text('Import'),
          ),

        ),
      ),
    );
  }
}

class createBar extends StatelessWidget {
  final CardClass provider;

  const createBar({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    String stateQ = 'A Topic';
    double containerHeight = 50;
    return Consumer<animation>(
      builder: (BuildContext context, give, Widget? child) => AnimatedContainer(
        width:350,
        duration: const Duration(milliseconds: 500), // Animation duration
        curve: Curves.easeInOut,

        height: give.value ? containerHeight + 40 : containerHeight - 4,
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
            AnimatedSize(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn,
              child: Container(
                child: give.value
                    ? const Column(
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
                )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
