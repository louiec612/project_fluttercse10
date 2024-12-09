import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_fluttercse10/main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: Center(
          child: Lottie.asset(
            'assets/animation/Animation - 1733751232280.json'
          ),
        ),
        nextScreen: HomePage(),
      duration: 5600,
      backgroundColor: Colors.white,
      splashIconSize: 1000,
      
    );
  }
}
