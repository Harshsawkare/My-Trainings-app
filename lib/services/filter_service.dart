import 'package:my_trainings_app/services/trainings_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/trainings_controller.dart';
import '../utils/constants.dart';

class FilterService {

  ///apply filter on trainings listview
  void applyFilter() async {
    var locations = await loadFilterPreferences(Constants.locationPrefList);
    var titles = await loadFilterPreferences(Constants.titlePrefList);
    var trainers = await loadFilterPreferences(Constants.trainerPrefList);

    //hit the API call will filter queries
    TrainingsService().fetchTrainingsData(
      location: locations,
      title: titles,
      trainerName: trainers,
    );
  }

  ///Load Filter preferences
  ///@param[key] : pref key from which the value needs to be extracted
  Future<List<String>> loadFilterPreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  ///Save Filter preferences
  ///@param[key] : pref key in which the value needs to be stored
  ///@param[value] : pref value that needs to be stored
  void saveFilterPreferences(String key, List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, value);
  }

  ///Clear Filter preferences
  void clearFilterPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    //hit the API call to fetch all the trainging data
    TrainingsService().fetchTrainingsData();
  }

  ///Get all the locations from the initial list of trainings
  static List<String> getLocations(TrainingsController trainingsController) {
    return trainingsController.trainingsList
        .map((training) => training.location)
        .toSet()
        .toList();
  }

  ///Get all the training titles from the initial list of trainings
  static List<String> getTitles(TrainingsController trainingsController) {
    return trainingsController.trainingsList
        .map((training) => training.title)
        .toSet()
        .toList();
  }

  ///Get all the trainer names from the initial list of trainings
  static List<String> getTrainers(TrainingsController trainingsController) {
    return trainingsController.trainingsList
        .map((training) => training.trainer.name)
        .toSet()
        .toList();
  }
}
