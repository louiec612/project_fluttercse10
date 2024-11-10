// ignore_for_file: file_names, camel_case_types

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:project_fluttercse10/main.dart';
import '../test.dart';

//VIEW FOR PROFILE
class profileView extends StatefulWidget {
  const profileView({super.key});

  @override
  State<profileView> createState() => _profileViewState();
}

class _profileViewState extends State<profileView> {
  @override
  Widget build(BuildContext context) {
    return const Stack(children: [
      UserBar(),
      UserSpent(),
    ]);
  }
}


class UserBar extends StatelessWidget {
  const UserBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWid.wSize,
      height: getHgt.hSize / 2.8,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius:
              const BorderRadius.vertical(bottom: Radius.circular(15))),
      child: const UserInfo(),
    );
  }
}

class UserSpent extends StatelessWidget {
  const UserSpent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Positioned(
      top: getHgt.hSize *.32,
      left: getWid.wSize/19,
      child: Container(
        width: getWid.wSize*0.89,
        height: 85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))
          ,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 5,
              color: Colors.black26,
            ),
          ],),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Icon(
                  BootstrapIcons.lightning_fill,
                  color: Colors.grey[600],
                  size: 30,
                ),
                const SizedBox(width:20),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('3',style: TextStyle(fontSize: 20)),
                    Text('Flashcards added',style: TextStyle(fontSize: 13)),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Icon(BootstrapIcons.clock_fill, color: Colors.grey[600], size: 30),
                const SizedBox(width:20),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('3',style: TextStyle(fontSize: 20)),
                    Text('Hours Spent',style: TextStyle(fontSize: 13)),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: Image.network(
              'https://pop.inquirer.net/files/2021/05/gigachad.jpg',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Andrei Castro',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Text(
            'Angeles, Philippines',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w100,
            ),
          ),
        ],
      ),
    );
  }
}
