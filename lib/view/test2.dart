import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageViewExample(),
    );
  }
}

class PageViewExample extends StatefulWidget {
  @override
  _PageViewExampleState createState() => _PageViewExampleState();
}

class _PageViewExampleState extends State<PageViewExample> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PageView with Back Button'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (_pageController.hasClients) {
              if (_pageController.page! > 0) {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                Navigator.pop(context); // Exit the screen
              }
            }
          },
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          Center(child: Text('Page 1')),
          Center(child: Text('Page 2')),
          Center(child: Text('Page 3')),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
