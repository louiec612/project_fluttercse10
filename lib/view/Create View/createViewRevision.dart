import 'package:dropdown_button2/dropdown_button2.dart';
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
            width: double.infinity, // Full width
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.create, size: 80, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'Create Your Flash Cards',
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

          Column(
            children: [
              const SizedBox(height: 10),
              const dropdownDeck(),
              const SizedBox(height: 10),
              createBar(
                provider: provider,
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
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
                    const SizedBox(height: 10),
                  ]),
                ),
              )
            ],
          ),
          const Divider(indent: 50, endIndent: 50,),
          Text('Recently Added ${provider.allCards.length}',style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),),
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
                  border: Border.all(color: Colors.transparent), // Border
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
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
                  ),
                )
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
        builder: (BuildContext context, give, Widget? child) =>
            SizedBox(
              height:30,
              child: ElevatedButton(
                onPressed: () {
                  give.reverseValue();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Front & Back',
                    ),
                    Transform.scale(
                      scale: 0.7,
                      child: Switch(
                        value: give.value,
                        onChanged: (bool value) {
                          give.setSwitchValue(value);
                          if (value)
                            give.setType('Question');
                          else
                            give.setType('A Topic');
                        },

                      ),
                    ),
                  ],
                ),
              ),
            )
    );
  }
}

class generateButton extends StatefulWidget {
  final CardClass provider;
  const generateButton({super.key, required this.provider});

  @override
  State<generateButton> createState() => _generateButtonState();
}

class _generateButtonState extends State<generateButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<animation>(
      builder: (BuildContext context, give, Widget? child) => SizedBox(
          height: 30,
          child: ElevatedButton(
            onPressed: () {
              if (give.value == false) {
                widget.provider.generateAndInsertQuestions();
                print('Prompt ${widget.provider.promptController.text}');
              }
            },
            child: const Text('Generate'),
            ),
          )
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
      height: 30,
      child: ElevatedButton(
        onPressed: () async {
          provider.insertNewCard();
        },

        child: const Text(
          'Add Card',

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
        height: 30,
        child: ElevatedButton(
          onPressed: () {
            pickAndExtractText(context);
          },
          child: const Text('Import'),
          ),
        ),
      );
  }
}

class createBar extends StatefulWidget {
  final CardClass provider;

  const createBar({
    super.key,
    required this.provider,
  });

  @override
  State<createBar> createState() => _createBarState();
}

class _createBarState extends State<createBar> {
  @override
  Widget build(BuildContext context) {

    double containerHeight = 50;


    return Consumer<animation>(
      builder: (BuildContext context, give, Widget? child) => AnimatedContainer(
        width: 350,
        duration: const Duration(milliseconds: 500), // Animation duration
        curve: Curves.easeInOut,
        height: give.value ? containerHeight + 40 : containerHeight,
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(228,227,233,255),width: 3),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10, 0, 0),
              child: TextField(
                  controller: give.value
                      ? widget.provider.questionController
                      : widget.provider.promptController,
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
                          const Divider(endIndent: 5, indent: 5),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                            child: TextField(
                              controller: widget.provider.answerController,
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
