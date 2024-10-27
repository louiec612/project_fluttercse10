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
      child: const Column(
        children: [
          Center(child: Text('pfView'),),
        ],
      ),
    );
  }
}
