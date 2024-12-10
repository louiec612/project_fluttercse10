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
            const SizedBox(height:10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color.fromARGB(228,227,233,255),width: 3),
                  borderRadius: BorderRadius.circular(15),
              ),
                child: ListTile(// Background color of the tile
                  titleAlignment: ListTileTitleAlignment.top,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(card.question,style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),),
                      const Divider(indent: 5,),
                      Text(card.answer)
                    ],
                  ),
                  trailing:  Padding(
                    padding: const EdgeInsets.all(0),
                    child: PopupMenuButton(
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
              ),
            ),
            const SizedBox(height:10),
          ],
        ),

    );
  }
}
