import 'package:flutter/material.dart';
import 'package:project_fluttercse10/getset.dart';
import 'package:project_fluttercse10/provider/pageProvider.dart';
import 'package:provider/provider.dart';
import '../../provider/deckProvider.dart';
import '../../widgets/deckWidgetSquare.dart';

class homeView extends StatefulWidget {
  const homeView({super.key});

  @override
  State<homeView> createState() => _homeViewState();
}

class _homeViewState extends State<homeView> {
  @override
  Widget build(BuildContext context) {
    final deck = Provider.of<deckProvider>(context);
    final page = Provider.of<PageProvider>(context);
    deck.fetchRecentTables();
    return Stack(
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
              padding: const EdgeInsets.only(left: 20.0, top: 50.0),
              child: Row(
                children: [
                  const SizedBox(
                    width: 0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.network(
                        'https://pop.inquirer.net/files/2021/05/gigachad.jpg',
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Welcome Back Andrei Castro!',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Column(
            children: [
              SizedBox(height: getWid.wSize/1.8),
              Center(
                child: Container(
                  width: getWid.wSize * 0.93,
                  height: 160,
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
                        SizedBox(height: 8,),
                        SizedBox(height: 7),
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
                    child: Text("Flashcard"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        page.jumpToPage(3);
                      },
                      child: const Text('View All'),
                    ),
                  ),
                ],
              ),
              const deckWidgetSquare() ,
            ],
          ),

        ],
    );
  }
}