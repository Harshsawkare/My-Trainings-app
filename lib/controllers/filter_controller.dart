import 'package:get/get.dart';


///This controller will be used to store the complete list of titles, locations
///and trainer names throughout the app session for filter bottom sheet
class FilterController extends GetxController {
  var titles = <String>[].obs;
  var locations = <String>[].obs;
  var trainers = <String>[].obs;
}
