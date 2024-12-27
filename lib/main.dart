import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_trainings_app/routes/app_pages.dart';
import 'package:my_trainings_app/utils/themes.dart';
import 'package:my_trainings_app/views/splash_screen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Trainings App',
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Themes.secondaryColor, // Set your desired color
          surfaceTintColor:
              Colors.transparent, // Prevent color change on scroll
          elevation: 0, // Optional: remove shadow
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
