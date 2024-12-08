import 'package:flutter/material.dart';
import 'package:project_fluttercse10/getset.dart';

import '../../main.dart';

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
              const BorderRadius.vertical(bottom: Radius.circular(15)),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0,top: 50.0),
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.network(
                        'https://pop.inquirer.net/files/2021/05/gigachad.jpg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Andrei Castro', style: TextStyle(fontSize: 20,color: Colors.white),),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 160),
              Center(
                child: Container(
                  width: getWid.wSize * 0.93,
                  height: 220,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(27)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 15,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Text("Search Flashcards",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                        SizedBox(height: 10,),
                        Text("It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."),
                        SizedBox(height: 10),
                        TextField( decoration: InputDecoration( hintText: 'Search Here', border: OutlineInputBorder( borderRadius: BorderRadius.all(Radius.circular(12)), ), prefixIcon: Icon(Icons.search),
                        ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("Flashcard",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        homePageKey.currentState?.onButtonPressed(4);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black26,
                        fixedSize: const Size(110, 35),
                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('View All',style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return  Padding(
                        padding: const EdgeInsets.all(3.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color.fromARGB(228,227,233,255),width: 3),
                              borderRadius: BorderRadius.circular(15),

                            ),
                            child: InkWell(
                              onTap: () {
                                print('Flashcard ${index + 1} clicked');
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      'Flashcard ${index + 1}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ),

                    );
                  },
                ),
              ),
              const SizedBox(height: 50,)
            ],
          ),
        ],
      ),
    );
  }
}