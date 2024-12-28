import 'package:get/get.dart';

import '../models/training_model.dart';


///This controller will be used to keep track of all training data
class TrainingsController extends GetxController {
  var trainingsList = <TrainingModel>[].obs;
  var loading = false.obs;
  var noTrainingFound = false.obs;
}
