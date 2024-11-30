import 'package:flutter/material.dart';

class ExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Background occupying 1/3 of the screen
          Container(
            height: MediaQuery.of(context).size.height / 3,
            color: Colors.blue,
            child: Center(
              child: Text(
                "1/3 Background",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          // Stack to overlay the Positioned widget
          Stack(
            clipBehavior: Clip.none, // Ensures Positioned can overflow
            children: [
              // Content below the background
              Container(
                color: Colors.white,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 2 / 3,
                child: Center(
                  child: Text("Content Below"),
                ),
              ),
              // Widget positioned at the edge of the background
              Positioned(
                top: -40, // Negative value to "overlap" the background
                left: MediaQuery.of(context).size.width / 4,
                child: Container(
                  height: 80,
                  width: 200,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      "Positioned Widget",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}