import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_trainings_app/models/training_model.dart';
import 'package:my_trainings_app/services/home_service.dart';
import 'package:my_trainings_app/services/training_service.dart';
import 'package:my_trainings_app/utils/constants.dart';
import 'package:my_trainings_app/utils/themes.dart';

import 'dashed_line.dart';

class EnrollmentCard extends StatelessWidget {
  final TrainingModel training;
  const EnrollmentCard({
    super.key,
    required this.training,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: Get.size.width,
        height: 200,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Themes.secondaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date section
            SizedBox(
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //date
                  Text(
                    HomeService().formatEnrollDateRange(
                      training.fromTime,
                      training.toTime,
                    ),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //time
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      HomeService().formatEnrollTimeRange(
                        training.fromTime,
                        training.toTime,
                      ),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Themes.primaryColor,
                      ),
                    ),
                  ),
                  const Spacer(),

                  //venue
                  Text(
                    training.venue,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Themes.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Divider
            const Padding(
              padding: EdgeInsets.all(5),
              child: DashedLine(
                axis: Axis.vertical,
                dashWidth: 8,
                dashHeight: 1.0,
                dashSpacing: 4,
                color: Colors.black45,
              ),
            ),

            // Event Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //status
                  Text(
                    training.enrollments > 10
                        ? Constants.fillingFastLabel
                        : Constants.earlyBirdLabel,
                    style: const TextStyle(
                      color: Themes.tertiaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //title
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      training.title,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Themes.primaryColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),

                  //trainer
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                  training.trainer.url,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: Image.asset(Constants.logoPath),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            Constants.keynoteSpeakerLabel,
                            style: TextStyle(
                              color: Themes.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            training.trainer.name,
                            style: const TextStyle(
                              color: Themes.primaryColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Enrol Now button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () => TrainingService().openOrderDialog(
                          training.fromTime,
                          training.toTime,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Themes.tertiaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          Constants.enrolNowLabel,
                          style: TextStyle(
                            color: Themes.secondaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
