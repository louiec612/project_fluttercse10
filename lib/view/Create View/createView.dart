import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddFlashcardView extends StatefulWidget {
  const AddFlashcardView({super.key});

  @override
  State<AddFlashcardView> createState() => _AddFlashcardViewState();
}

List<Map<String, String>> globalDecks = [];

class _AddFlashcardViewState extends State<AddFlashcardView> {
  TextEditingController _topicController = TextEditingController();
  TextEditingController _answerController = TextEditingController();
  bool _isChecked = false;
  bool _isVisible = false;
  List<Map<String, String>> questionAnswerPairs = []; // Changed to a simple list of maps
  late Box<Map<String, String>> _flashcardBox;
  late Box<Map<String, List<Map<String, String>>>> _deckBox; // Updated for decks
  String? _selectedCardKey;

  double containerHeight = 50;

  @override
  void initState() {
    super.initState();
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    await Hive.initFlutter();
    _flashcardBox = await Hive.openBox<Map<String, String>>('flashcards');
    _deckBox = await Hive.openBox<Map<String, List<Map<String, String>>>>('decks');
    _loadData();
  }

  void _loadData() {
    setState(() {
      questionAnswerPairs = _flashcardBox.keys.map((key) {
        return _flashcardBox.get(key) as Map<String, String>;
      }).toList();
    });
  }

  void _saveAllCards() {
    for (var pair in questionAnswerPairs) {
      _flashcardBox.put(pair['question'] ?? '', pair); // Save using the question as the key
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cards saved successfully!')),
    );
  }

  void _saveDeck() {
    _showSaveDeckDialog();
  }

  void _showSaveDeckDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        TextEditingController nameController = TextEditingController();
        return AlertDialog(
          title: const Text('Save Deck'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Enter deck name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String deckName = nameController.text.trim();
                if (deckName.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a name for the deck!')),
                  );
                  return;
                }

                if (_deckBox.containsKey(deckName)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Deck "$deckName" already exists!')),
                  );
                  return;
                }

                // Save the deck as a Map with the deck name as the key and questionAnswerPairs as the value
                Map<String, List<Map<String, String>>> deck = {
                  deckName: List.from(questionAnswerPairs),
                };

                _deckBox.put(deckName, deck);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Deck "$deckName" saved successfully!')),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _delayedVisibility() {
    if (!_isVisible) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _isVisible = true;
        });
      });
    } else {
      setState(() {
        _isVisible = false;
      });
    }
  }

  void _deleteSelectedCard() {
    if (_selectedCardKey != null) {
      setState(() {
        questionAnswerPairs.removeWhere((pair) => pair['question'] == _selectedCardKey);
        _flashcardBox.delete(_selectedCardKey);
        _selectedCardKey = null; // Reset selection
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Card deleted!')),
      );
    }
  }

  void _deleteAllCards() {
    setState(() {
      questionAnswerPairs.clear();
      _flashcardBox.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All cards deleted!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  height: _isChecked ? containerHeight + 40 : containerHeight - 4,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 10, 0, 0),
                        child: TextField(
                          controller: _topicController,
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Enter Question',
                          ),
                        ),
                      ),
                      Visibility(
                        visible: _isVisible,
                        child: Column(
                          children: [
                            Divider(),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                              child: TextField(
                                controller: _answerController,
                                decoration: const InputDecoration.collapsed(
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
                const SizedBox(height: 10),
                if (_isChecked) ...[
                  ElevatedButton(
                    onPressed: () {
                      if (_topicController.text.isEmpty || _answerController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please enter both Question and Answer!')),
                        );
                        return;
                      }
                      setState(() {
                        questionAnswerPairs.add({
                          'question': _topicController.text,
                          'answer': _answerController.text,
                        });
                        _topicController.clear();
                        _answerController.clear();
                        _isVisible = false;
                        _isChecked = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveAllCards,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _deleteAllCards,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text(
                          'Delete All',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveDeck,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple, // New color for the deck save button
                        ),
                        child: const Text(
                          'Save Deck',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {} // Placeholder for additional actions
                        ,
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
                              value: _isChecked,
                              onChanged: (bool value) {
                                _delayedVisibility();
                                setState(() {
                                  _isChecked = value;
                                });
                              },
                              activeColor: Colors.white,
                              activeTrackColor: Colors.teal,
                              inactiveTrackColor: Colors.grey[400],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Dropdown for selecting a card to delete
                DropdownButton<String>(
                  value: _selectedCardKey,
                  hint: const Text('Select a card to delete'),
                  items: questionAnswerPairs.map((pair) {
                    return DropdownMenuItem<String>(
                      value: pair['question'],
                      child: Text(pair['question'] ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCardKey = value;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: _deleteSelectedCard,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text(
                    'Delete Selected Card',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                // "Added Cards" section
                const Text(
                  'Added Cards',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                questionAnswerPairs.isEmpty
                    ? const Text('No cards added yet.')
                    : Column(
                  children: questionAnswerPairs.map((pair) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text('Q: ${pair['question']}'),
                        subtitle: Text('A: ${pair['answer']}'),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
