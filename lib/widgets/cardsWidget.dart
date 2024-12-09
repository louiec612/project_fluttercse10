import 'package:flutter/material.dart';

import '../model/cardModel.dart';
import '../provider/cardProvider.dart';

class CardWidget extends StatelessWidget {

  final Cards card;
  final CardClass provider;

  const CardWidget(this.card,this.provider,{super.key});


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
                trailing:  PopupMenuButton(
                  itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry>[
                    PopupMenuItem(
                      child: const Text('Delete'),
                      onTap: (){
                        provider.deleteCard(card);
                      },
                    ),
                    PopupMenuItem(
                      child: const Text('Edit'),
                      onTap: (){
                        provider.questionController.text = card.question;
                        provider.answerController.text = card.answer;
                        showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Confirmation'),
                          content: const Text('AlertDialog description'),
                          actions: <Widget>[
                            TextField(
                              controller: provider.questionController,
                            ),
                            TextField(
                              controller: provider.answerController,
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: (){provider.updateCard(card);
                              Navigator.pop(context, 'OK');
                                },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );}
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height:10),
            Divider(),
          ],
        ),

    );
  }
}
