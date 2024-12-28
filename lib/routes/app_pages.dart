import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:my_trainings_app/views/home_scaffold.dart';
import 'package:my_trainings_app/views/training_details_scaffold.dart';
import 'app_routes.dart';


///All the app screens
class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScaffold(),
      popGesture: false,
    ),
    GetPage(
      name: AppRoutes.trainingDetails,
      page: () => const TrainingDetailsScaffold(),
    ),
  ];
}
