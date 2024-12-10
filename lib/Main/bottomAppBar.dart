import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class bottomAppBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onButtonPressed;
  const bottomAppBar({
    Key? key,
    required this.currentIndex,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            spreadRadius: 5.0,
            offset: Offset(0.0, 2.0), // changes position of shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15), topLeft: Radius.circular(15)),
        child: BottomAppBar(
          color: Colors.white,
          elevation: 20,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ZoomTapAnimation(
                child: Column(
                  children: [
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () => onButtonPressed(0), // Navigate to page 0
                      icon: const Icon(BootstrapIcons.house_door, size: 25),
                      color: currentIndex == 0
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                    const Text('Home'),
                  ],
                ),

              ),
              ZoomTapAnimation(
                child: Column(
                  children: [
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () => onButtonPressed(3), // Navigate to page 0
                      icon: const Icon(Icons.filter_none, size: 25),
                      color: currentIndex == 3
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                    const Text('Decks'),
                  ],
                ),

              ),
              ZoomTapAnimation(
                child: Column(
                  children: [
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () => onButtonPressed(2), // Navigate to page 0
                      icon: const Icon(Icons.add, size: 25),
                      color: currentIndex == 2
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                    const Text('Add')
                  ],
                ),
              ),
              ZoomTapAnimation(
                child: Column(
                  children: [
                    IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () => onButtonPressed(1), // Navigate to page 1
                      icon: const Icon(Icons.account_circle_outlined, size: 25),
                      color: currentIndex == 1
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                    const Text('Profile')
                  ],
                ),
              ),

              ZoomTapAnimation(
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: (){}, // Navigate to page 1
                  icon: const Icon(Icons.settings, size: 25),
                  color: currentIndex == 4
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}