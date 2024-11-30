// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:project_fluttercse10/main.dart';
import 'package:project_fluttercse10/getset.dart';
//VIEW FOR FLASHCARD LISTS

void main(){
  runApp(Main());
}
class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          Text("WEW"),
          Stack(
            children: [
              Positioned(
                width: getWid.wSize,
                height: getHgt.hSize/2.8,
                child: Container(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      );
  }
}
