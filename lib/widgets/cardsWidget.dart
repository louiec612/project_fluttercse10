import 'package:flutter/material.dart';

import '../model/cardModel.dart';

class CardWidget extends StatelessWidget {

  final Cards card;

  const CardWidget(this.card,{super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(

        child: Column(
          children: [
            Container(
              height: 150,
              width: 350,
              child: ListTile(
                  tileColor: Colors.blue, // Background color of the tile
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                  ),
                title: Text(card.question),
                subtitle: Text(card.answer),
                trailing: Icon(Icons.more_vert),
                  isThreeLine: true
              ),
            ),
            Divider(),
          ],
        ),

    );
  }
}
