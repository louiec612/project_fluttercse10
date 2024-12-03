import 'package:flutter/material.dart';
import 'package:project_fluttercse10/getset.dart';
import 'package:project_fluttercse10/view/quizView.dart';

class homeView extends StatefulWidget {
  const homeView({super.key});

  @override
  State<homeView> createState() => _homeViewState();
}

class _homeViewState extends State<homeView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Makes the content scrollable
      child: Stack(
        children: [
          Container(
            width: getWid.wSize,
            height: getHgt.hSize / 2.8,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(15))),
          ),
          Column(
            children: [
              ElevatedButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const quizView())
                  );
              }, child: Text("Card 1"))
            ],
          ),
        ],
      ),
    );
  }
}
