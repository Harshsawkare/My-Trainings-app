import 'dart:developer';

import 'package:get/get.dart';

import '../models/training_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TrainingsController extends GetxController {
  // The list of trainings
  var trainingsList = <TrainingModel>[].obs;
  var noTrainingFound = false.obs;

  // Function to fetch training data from the API
  void fetchTrainingsData({
    String? title,
    String? location,
    String? trainerName,
  }) async {
    const url =
        "https://us-central1-my-trainings-app-1409.cloudfunctions.net/fetchTrainingsData";

    final payload = {
      "title": title,
      "location": location,
      "trainerName": trainerName,
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
        trainingsList.value = fetchedTrainings;
      } else {
        // If the server didn't return a 200 OK response, throw an error
        noTrainingFound.value = true;
        log('Failed to load fetchTrainingsData. '
            'Status code: ${response.statusCode}');
      }
    } catch (error) {
      noTrainingFound.value = true;
      log('Error fetching fetchTrainingsData: $error');
    }
  }
}
