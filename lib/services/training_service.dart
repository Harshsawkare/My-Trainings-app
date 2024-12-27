import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_trainings_app/models/trainer_model.dart';
import 'package:my_trainings_app/models/training_model.dart';

import '../utils/constants.dart';
import '../utils/themes.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TrainingService {
  void fetchTrainingsData() async {
    const String url =
        'https://us-central1-my-trainings-app-1409.cloudfunctions.net/fetchTrainingsData';

    try {
      // Make the HTTP GET request
      final response = await http.get(Uri.parse(url));

      // Check if the request was successful
      if (response.statusCode == 200) {
        // If the request is successful, parse the JSON data
        final data = json.decode(response.body)['data'];
        var trainings = <TrainingModel>[];
        for (final map in data) {
          trainings.add(TrainingModel.fromMap(map));
        }
        log(trainings.toString());
      } else {
        // If the server didn't return a 200 OK response, throw an error
        log('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle errors (e.g., no internet, timeout)
      log('Error fetching data: $error');
    }
  }

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
