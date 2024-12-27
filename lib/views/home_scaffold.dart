import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_trainings_app/services/training_service.dart';
import 'package:my_trainings_app/utils/constants.dart';
import 'package:my_trainings_app/utils/themes.dart';
import 'package:my_trainings_app/views/widgets/enrollment_card.dart';
import 'package:my_trainings_app/views/widgets/sort_and_filter_bottom_sheet.dart';
import 'package:my_trainings_app/views/widgets/training_carousal_card.dart';

class HomeScaffold extends StatefulWidget {
  const HomeScaffold({super.key});

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  final List<Widget> items = [
    TrainingCarousalCard(
      training: Constants.trainingModel,
    ),
  ];

  @override
  void initState() {
    super.initState();
    TrainingService().fetchTrainingsData();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Themes.bgColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Themes.tertiaryColor,
          foregroundColor: Themes.secondaryColor,
          title: const Text(
            Constants.trainingsTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          centerTitle: false,
          actions: [
            Transform.flip(
              flipX: true,
              child: IconButton(
                icon: const Icon(
                  Icons.sort_rounded,
                ),
                onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Themes.secondaryColor,
                  shape: const RoundedRectangleBorder(),
                  builder: (context) {
                    return const FractionallySizedBox(
                      heightFactor: 0.7,
                      child: SortAndFilterContent(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        body: SizedBox(
          height: Get.size.height,
          width: Get.size.width,
          child: Column(
            children: [
              //highlights
              Container(
                height: Get.size.height * 0.3,
                color: Themes.secondaryColor,
                child: Stack(
                  children: [
                    //app bar color extension
                    Container(
                      height: Get.size.height * 0.17,
                      color: Themes.tertiaryColor,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //highlights label
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            Constants.highlightsLabel,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Themes.secondaryColor),
                          ),
                        ),

                        CarouselSlider(
                            items: items,
                            options: CarouselOptions(
                              height: Get.size.height * 0.2,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.8,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.3,
                              scrollDirection: Axis.horizontal,
                            ))
                      ],
                    ),
                  ],
                ),
              ),

              // Training list view
              Expanded(
                child: SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.all(15),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return EnrollmentCard(training: Constants.trainingModel);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
