import 'package:flutter/material.dart';
import 'package:my_trainings_app/utils/constants.dart';

import '../services/splash_screen_service.dart';
import '../utils/themes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to the home screen
    SplashScreenService().navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Themes.secondaryColor,
      body: Center(
        child: Image.asset(
          Constants.logoPath,
          width: 100,
        ), // Display logo
      ),
    );
  }
}
