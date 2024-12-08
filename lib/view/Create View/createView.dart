import 'package:flutter/material.dart';

class AddFlashcardView extends StatefulWidget {
  const AddFlashcardView({super.key});
  @override
  State<AddFlashcardView> createState() => _AddFlashcardViewState();
}

class _AddFlashcardViewState extends State<AddFlashcardView> {
  bool _isChecked = false;
  bool _isHoveredImport = false;
  bool _isHoveredGenerate = false;
  TextEditingController _topicController = TextEditingController();

  final MaterialStateProperty<Icon?> thumbIcon = MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(
          Icons.check,
          color: Colors.white,
        );
      }
      return const Icon(
        Icons.close,
        color: Colors.white,
      );
    },
  );

  List<Map<String, String>> _cards = []; // List to store the question and answer pairs

  void _delayedVisibility(bool value) {
    setState(() {
      _isChecked = value;
    });
  }

  void _addCard(String question, String answer) {
    setState(() {
      _cards.add({
        'question': question,
        'answer': answer,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Blue Background with Profile Section
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3.5,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Create Your Own FlashCards!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[400],
                      child: ClipOval(
                        child: Image.network(
                          'https://pop.inquirer.net/files/2021/05/gigachad.jpg',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Andrei Castro',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Enter A Topic Input
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: TextField(
                  controller: _topicController,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Enter A Topic',
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Import and Front & Back Buttons (Larger)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: MouseRegion(
                    onEnter: (_) {
                      setState(() {
                        _isHoveredImport = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        _isHoveredImport = false;
                      });
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50, // Height of the button
                          width: double.infinity, // Full width
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _addCard("Sample Question", "Sample Answer");
                              print("question and answer");
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isHoveredImport ? Colors.grey[700] : Colors.grey[600],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 5,
                              shadowColor: Colors.black.withOpacity(0.3),
                            ),
                            icon: Icon(Icons.upload, color: Colors.white),
                            label: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 200),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: _isHoveredImport ? 16 : 14,
                              ),
                              child: const Text('Import'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 50, // Height of the button
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Front & Back',
                            style: TextStyle(
                              color: _isChecked ? Colors.white : Colors.grey[400],
                              fontWeight: _isChecked ? FontWeight.normal : FontWeight.w400,
                            ),
                          ),
                          Switch(
                            thumbIcon: thumbIcon,
                            value: _isChecked,
                            onChanged: (bool value) {
                              _delayedVisibility(value);
                            },
                            activeColor: Colors.green,
                            inactiveThumbColor: Colors.red[400],
                            inactiveTrackColor: Colors.grey[400],
                            activeTrackColor: Colors.green.withOpacity(0.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // Generate Button with Hover Effect
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MouseRegion(
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
              child: Column(
                children: [
                  SizedBox(
                    height: 50, // Height of the button
                    width: double.infinity, // Full width
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _addCard("Generated Question", "Generated Answer");
                        print("question and answer");
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isHoveredGenerate ? Colors.grey[700] : Colors.grey[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 5,
                        shadowColor: Colors.black.withOpacity(0.3),
                      ),
                      icon: Icon(Icons.autorenew, color: Colors.white),
                      label: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: _isHoveredGenerate ? 16 : 14,
                        ),
                        child: const Text('Generate'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Divider
          const Divider(thickness: 1),

          // Added Cards Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Added Cards',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),

          // Display each card in a styled box
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: _cards.length,
                itemBuilder: (context, index) {
                  final card = _cards[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Question:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            card['question'] ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Answer:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            card['answer'] ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
