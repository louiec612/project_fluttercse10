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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PageView with Back Button'),
      ),
      body: Stack(
        children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                width:700,
                  height:400,

                  decoration: const BoxDecoration(
                      color: Colors.grey
                  ),
                child: const Center(child: Text('WEW')),
              ),
            ),
          Positioned.fill(bottom:10,child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height:50,
              width:50,
              color: Colors.red,
            ),
          ))
          ],
        ),
    );
  }


}
