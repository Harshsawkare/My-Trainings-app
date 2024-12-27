import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:my_trainings_app/utils/constants.dart';

class SplashScreenService {
  final firestore = FirebaseFirestore.instance;

  ///Navigate to the home screen
  void navigate() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      Get.toNamed(Constants.homeRoute);
    });
  }
}
