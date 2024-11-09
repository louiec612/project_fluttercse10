import 'package:flutter/material.dart';
//VIEW FOR PROFILE
class profileView extends StatefulWidget {
  const profileView({super.key});

  @override
  State<profileView> createState() => _profileViewState();
}

class _profileViewState extends State<profileView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 350,
            decoration: BoxDecoration(
                color: Colors.cyan[300],
                borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(15))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height:20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.network(
                    'https://pop.inquirer.net/files/2021/05/gigachad.jpg',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height:20),
                const Text('Andrei Castro',style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),),

                const Text('Angeles, Philippines',style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w100,
                ),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
