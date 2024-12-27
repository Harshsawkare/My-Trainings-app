import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_trainings_app/models/training_model.dart';
import 'package:my_trainings_app/services/home_service.dart';
import 'package:my_trainings_app/utils/constants.dart';
import 'package:my_trainings_app/utils/themes.dart';

class TrainingCarousalCard extends StatelessWidget {
  final TrainingModel training;
  const TrainingCarousalCard({
    super.key,
    required this.training,
  });

  @override
  Widget build(BuildContext context) {
    var duration = HomeService()
        .formatHighlightsDateRange(training.fromTime, training.toTime);

    return GestureDetector(
      onTap: () => Get.toNamed(
        Constants.trainingDetailsRoute,
        arguments: training,
      ),
      child: Stack(
        children: [
          // training image
          Container(
            width: Get.size.width * 0.8,
            decoration: BoxDecoration(
              color: Themes.bgColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                training.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // training image tint
          Container(
            width: Get.size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(15),
            ),
          ),

          // training info
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //title
                Text(
                  training.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Themes.secondaryColor,
                  ),
                ),

                //location and duration
                Text(
                  '${training.location} | $duration',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Themes.secondaryColor,
                  ),
                ),

                //amount
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        training.amount,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Themes.tertiaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      const Text(
                        Constants.viewDetailsLabel,
                        style: TextStyle(
                            fontSize: 10,
                            color: Themes.secondaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: Themes.secondaryColor,
                        size: 12,
                      ), // Trailing icon
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
