import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_trainings_app/controllers/filter_controller.dart';

import '../controllers/trainings_controller.dart';
import '../models/training_model.dart';
import '../utils/constants.dart';
import '../utils/themes.dart';
import 'package:http/http.dart' as http;

import 'filter_service.dart';

class TrainingsService {
  final TrainingsController _trainingController =
      Get.put(TrainingsController());
  final FilterController _filterController = Get.put(FilterController());

  ///Function to fetch all trainings data from the API
  void fetchTrainingsData({
    List<String>? title,
    List<String>? location,
    List<String>? trainerName,
  }) async {
    _trainingController.loading.value = true;
    const url =
        "https://us-central1-my-trainings-app-1409.cloudfunctions.net/fetchTrainingsData";

    final payload = {
      "title": title ?? [],
      "location": location ?? [],
      "trainerName": trainerName ?? [],
    };
    try {
      // Make the HTTP POST request
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(payload),
      );

      // Check if the request was successful
      if (response.statusCode == 200) {
        // If the request is successful, parse the JSON data
        final List<dynamic> responseData = json.decode(response.body)['data'];
        final List<TrainingModel> fetchedTrainings = [];

        for (final map in responseData) {
          try {
            fetchedTrainings.add(TrainingModel.fromMap(map));
          } catch (error) {
            log('Error parsing fetchTrainingsData: $error');
          }
        }

        // Update the trainingsList with the fetched data.
        _trainingController.trainingsList.value = fetchedTrainings;

        if (fetchedTrainings.isEmpty) {
          _trainingController.noTrainingFound.value = true;
        } else {
          _trainingController.noTrainingFound.value = false;
        }

        // On initial data fetch, create list of titles, locations and trainer
        // names for filter
        if (_filterController.titles.value.isEmpty ||
            _filterController.trainers.value.isEmpty ||
            _filterController.locations.value.isEmpty) {
          _filterController.titles.value =
              FilterService.getTitles(_trainingController);
          _filterController.trainers.value =
              FilterService.getTrainers(_trainingController);
          _filterController.locations.value =
              FilterService.getLocations(_trainingController);
        }
      } else {
        // If the server didn't return a 200 OK response, throw an error
        _trainingController.noTrainingFound.value = true;
        log('Failed to load fetchTrainingsData. '
            'Status code: ${response.statusCode}');
      }
    } catch (error) {
      _trainingController.noTrainingFound.value = true;
      log('Error fetching fetchTrainingsData: $error');
    }
    _trainingController.loading.value = false;
  }

  ///Alert popUp when user enrolls into a training
  void openEnrolDialog(DateTime fromTime, DateTime toTime) {
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
