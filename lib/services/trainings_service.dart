import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../utils/constants.dart';
import '../utils/themes.dart';

class TrainingsService {

  void openOrderDialog(DateTime fromTime, DateTime toTime) {
    Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: 10),
      title: Constants.enrolledLabel,
      titleStyle: const TextStyle(
        color: Themes.primaryColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      cancel: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: ElevatedButton(
          onPressed: () => Get.back(),
          style: ElevatedButton.styleFrom(
            backgroundColor: Themes.secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: const BorderSide(
              color: Themes.tertiaryColor,
              width: 2,
            ),
            elevation: 0,
            minimumSize: const Size(double.infinity, 40),
          ),
          child: const Text(
            Constants.cancelLabel,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Themes.tertiaryColor,
            ),
          ),
        ),
      ),
      backgroundColor: Themes.secondaryColor,
      buttonColor: Themes.primaryColor,
      content: Center(
        child: Lottie.asset('assets/enrolledAnimation.json'),
      ),
    );
  }
}
