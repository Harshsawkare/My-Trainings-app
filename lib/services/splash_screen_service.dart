import 'package:get/get.dart';
import 'package:my_trainings_app/utils/constants.dart';

class SplashScreenService {
  ///Navigate to the home screen
  void navigate() {
    Future.delayed(const Duration(seconds: 3)).then((_) {
      Get.toNamed(Constants.homeRoute);
    });
  }
}
