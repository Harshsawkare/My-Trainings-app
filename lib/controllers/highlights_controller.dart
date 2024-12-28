import 'dart:developer';

import 'package:get/get.dart';

import '../models/training_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HighlightsController extends GetxController {
// The list of highlightsList
  var highlightsList = <TrainingModel>[].obs;
  var noHighlightsFound = false.obs;

  // Function to fetch 3 training data from the API
  void fetchHighlightsData() async {
    const url =
        "https://us-central1-my-trainings-app-1409.cloudfunctions.net/fetchHighlightedTrainings";

    try {
      // Make the HTTP GET request
      final response = await http.get(Uri.parse(url));

      // Check if the request was successful
      if (response.statusCode == 200) {
        // If the request is successful, parse the JSON data
        final List<dynamic> responseData = json.decode(response.body)['data'];
        final List<TrainingModel> fetchedHighlights = [];

        for (final map in responseData) {
          try {
            fetchedHighlights.add(TrainingModel.fromMap(map));
          } catch (error) {
            log('Error parsing fetchHighlightsData: $error');
          }
        }

        highlightsList.value = fetchedHighlights;
      } else {
        // If the server didn't return a 200 OK response, throw an error
        noHighlightsFound.value = true;
        log('Failed to load fetchHighlightsData. '
            'Status code: ${response.statusCode}');
      }
    } catch (error) {
      noHighlightsFound.value = true;
      log('Error fetching fetchHighlightsData: $error');
    }
  }
}
