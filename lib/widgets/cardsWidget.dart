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
            SizedBox(height:10),
            Container(
              height: 100,
              width: 350,decoration: BoxDecoration(
              color: Colors.white, // Background color of the box
              borderRadius: BorderRadius.circular(10), // Rounded corners
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
                  spreadRadius: 5, // How much the shadow spreads
                  blurRadius: 7, // Softness of the shadow
                  offset: Offset(0, 3), // Offset in x and y directions
                ),
              ],
            ),
              child: ListTile(// Background color of the tile
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                title: Text(card.question,style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                ),),
                subtitle: Text(card.answer),
                trailing: Icon(Icons.more_vert),
                  isThreeLine: true
              ),
            ),
            SizedBox(height:10),
            Divider(),
          ],
        ),

    );
  }
}
