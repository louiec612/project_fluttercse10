import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color _fabColor = Colors.blue; // Initial color

  void _changeFabColor() {
    setState(() {
      // Change color when FAB is pressed
      _fabColor = _fabColor == Colors.blue ? Colors.red : Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FAB Color Change Example')),
      body: const Center(child: Text('Press the FAB to change its color!')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _fabColor, // Set the background color
        onPressed: _changeFabColor, // Change color on press
        child: const Icon(Icons.color_lens),
      ),
    );
  }
}