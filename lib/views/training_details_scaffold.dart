import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_trainings_app/models/training_model.dart';
import 'package:my_trainings_app/views/widgets/dashed_line.dart';

import '../services/home_service.dart';
import '../services/trainings_service.dart';
import '../utils/constants.dart';
import '../utils/themes.dart';

class TrainingDetailsScaffold extends StatelessWidget {
  const TrainingDetailsScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final training = Get.arguments as TrainingModel;

    return Scaffold(
      backgroundColor: Themes.secondaryColor,
      appBar: AppBar(
        backgroundColor: Themes.tertiaryColor,
        foregroundColor: Themes.secondaryColor,
        title: const Text(
          Constants.trainingDetailsTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            //training image
            Container(
              width: Get.size.width,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(training.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //status
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                training.enrollments > 10
                    ? Constants.fillingFastLabel
                    : Constants.earlyBirdLabel,
                style: const TextStyle(
                  color: Themes.tertiaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //title
            Text(
              training.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Themes.primaryColor,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            //date
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                HomeService().formatEnrollDateRange(
                  training.fromTime,
                  training.toTime,
                ),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //time
            Text(
              HomeService().formatEnrollTimeRange(
                training.fromTime,
                training.toTime,
              ),
              style: const TextStyle(
                fontSize: 12,
                color: Themes.primaryColor,
              ),
            ),

            //venue and location
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                '${training.venue} | ${training.location}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Themes.primaryColor,
                ),
              ),
            ),

            // Divider
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: DashedLine(
                axis: Axis.horizontal,
                dashWidth: 8,
                dashHeight: 1.0,
                dashSpacing: 4,
                color: Colors.black45,
              ),
            ),

            //trainer
            const Text(
              '${Constants.keynoteSpeakerLabel}:',
              style: TextStyle(
                  fontSize: 14,
                  color: Themes.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
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
                  Text(
                    training.trainer.name,
                    style: const TextStyle(
                      color: Themes.primaryColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // Divider
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: DashedLine(
                axis: Axis.horizontal,
                dashWidth: 8,
                dashHeight: 1.0,
                dashSpacing: 4,
                color: Colors.black45,
              ),
            ),

            //description
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                '${Constants.heresWhyLabel}:',
                style: TextStyle(
                    fontSize: 14,
                    color: Themes.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),

            ...training.description.map((e) => Text(
                  e,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Themes.primaryColor,
                  ),
                )),
            const Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: SizedBox.shrink(),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ElevatedButton(
          onPressed: () => TrainingsService().openOrderDialog(
            training.fromTime,
            training.toTime,
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Themes.tertiaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size(double.infinity, 40),
          ),
          child: const Text(
            Constants.enrolNowLabel,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Themes.secondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
