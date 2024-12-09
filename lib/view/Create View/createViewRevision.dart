import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:project_fluttercse10/provider/deckProvider.dart';
import 'package:project_fluttercse10/widgets/cardsWidget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import '../../db_service/sqf.dart';
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
    final animate1 = Provider.of<animation>(context);
    return Consumer<CardClass>(
      builder: (BuildContext context, provider, Widget? child) => Column(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 10),
                const dropdownDeck(),
                const SizedBox(height: 10),
                createBar(
                  provider: provider,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        importButton(provider: provider),
                        const SizedBox(width: 5),
                        if (animate1.value)
                          addButton(
                            provider: provider,
                          ),
                        if (!animate1.value) generateButton(provider: provider),
                        const SizedBox(width: 5),
                        const changeType(),
                      ],
                    ),
                    SizedBox(height: 10),
                  ]),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: provider.allCards.length,
              itemBuilder: (context, index) {
                return CardWidget(provider.allCards[index], provider);
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
    // List<String> items will be populated with table names from the provider
    return Consumer<deckProvider>(
      builder: (BuildContext context, deck, Widget? child) {
        // Fetch the table names if not already fetched
        if (deck.tableNames.isEmpty) {
          deck.fetchTableNames();
        }
        // Use the table names from the provider
        List<String> items = deck.tableNames.isNotEmpty
            ? deck.tableNames
            : [
                'Loading...'
              ]; // Show a loading state if no table names are available

        return Consumer<CardClass>(
          builder: (BuildContext context, card, Widget? child) {
            return Container(
                decoration: BoxDecoration(
                  //color: Colors.blue.shade50, // Background color
                  border: Border.all(color: Colors.transparent), // Border
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                child: DropdownButton(
                  value : items.contains(deck.selectedValue) ? deck.selectedValue : null,
                  items: items.map<DropdownMenuItem<String>>((String menu) {
                    return DropdownMenuItem<String>(
                      value: menu,
                      child: Text(menu), // Display text for the item
                    );
                  }).toList(),
                  hint: const Text('Select Deck'),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      DbHelper.dbHelper.tableName = newValue;
                      card.getCards();
                      deck.updateSelectedValue(newValue);
                    }
                  }
                  ,
                )
                // DropdownMenu(
                //   menuStyle: MenuStyle(
                //     side:  WidgetStateProperty.all(BorderSide(color: Colors.blue, width: 2)),
                //   ),
                //   initialSelection: deck.selectedValue,
                //   label: const Text('Select Deck'),
                //   dropdownMenuEntries: items.map<DropdownMenuEntry<String>>(
                //     (String menu) {
                //       return DropdownMenuEntry<String>(
                //         value: menu,
                //         label: menu,
                //       );
                //     },
                //   ).toList(),
                //   onSelected: (newValue) {
                //     if (newValue != null) {
                //       DbHelper.dbHelper.tableName = newValue;
                //       card.getCards();
                //       deck.updateSelectedValue(newValue);
                //     }
                //   },
                // ),
                );
          },
        );
      },
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
              child: ElevatedButton(
                onPressed: () {
                  give.reverseValue();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _isHoveredGenerate ? Colors.grey[700] : Colors.grey[600],
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
                        if (value)
                          give.setType('Question');
                        else
                          give.setType('A Topic');
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
              backgroundColor:
                  _isHoveredGenerate ? Colors.grey[700] : Colors.grey[600],
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

class addButton extends StatelessWidget {
  final CardClass provider;
  const addButton({
    super.key,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          provider.insertNewCard();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              _isHoveredGenerate ? Colors.grey[700] : Colors.grey[600],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 5,
          shadowColor: Colors.black.withOpacity(0.3),
        ),
        child: const Text(
          'Add Card',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class importButton extends StatefulWidget {
  final CardClass provider;
  const importButton({super.key, required this.provider});

  @override
  State<importButton> createState() => _importButtonState();
}

bool isHoveredImport = false;

class _importButtonState extends State<importButton> {
  String? text;
  pickAndExtractText(BuildContext context) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null && result.files.isNotEmpty) {
        final fileBytes = result.files.first.bytes;
        if (fileBytes != null) {
          PdfDocument document = PdfDocument(inputBytes: fileBytes);
          String text = PdfTextExtractor(document).extractText();
          widget.provider.importAndInsertQuestions(text);
          document.dispose();
        } else {
          print("No file content loaded.");
        }
      } else {
        print("File picking canceled.");
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

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
          onPressed: () {
            pickAndExtractText(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                isHoveredImport ? Colors.grey[700] : Colors.grey[600],
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
    double containerHeight = 50;
    return Consumer<animation>(
      builder: (BuildContext context, give, Widget? child) => AnimatedContainer(
        width: 350,
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
                controller: give.value
                    ? provider.questionController
                    : provider.promptController,
                decoration: InputDecoration.collapsed(
                  hintText: give.value ? 'Enter Question' : 'Enter A Topic',
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn,
              child: Container(
                child: give.value
                    ? Column(
                        children: [
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                            child: TextField(
                              controller: provider.answerController,
                              decoration: const InputDecoration.collapsed(
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
