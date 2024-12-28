import 'package:get/get.dart';

import '../models/training_model.dart';


///This controller will be used to keep track of highlighted training data
class HighlightsController extends GetxController {
  var highlightsList = <TrainingModel>[].obs;
  var noHighlightsFound = false.obs;
}
