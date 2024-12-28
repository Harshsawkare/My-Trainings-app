import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:my_trainings_app/controllers/filter_controller.dart';
import 'package:my_trainings_app/controllers/highlights_controller.dart';
import 'package:my_trainings_app/services/filter_service.dart';
import 'package:my_trainings_app/services/highlights_service.dart';
import 'package:my_trainings_app/services/trainings_service.dart';
import 'package:my_trainings_app/utils/constants.dart';
import 'package:my_trainings_app/utils/themes.dart';
import 'package:my_trainings_app/views/widgets/enrollment_card.dart';
import 'package:my_trainings_app/views/widgets/sort_and_filter/sort_and_filter_bottom_sheet.dart';
import 'package:my_trainings_app/views/widgets/training_carousal_card.dart';

import '../controllers/trainings_controller.dart';

class HomeScaffold extends StatefulWidget {
  const HomeScaffold({super.key});

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  final TrainingsController _trainingsController =
      Get.put(TrainingsController());
  final HighlightsController _highlightsController =
      Get.put(HighlightsController());
  final FilterController _filterController = Get.put(FilterController());

  bool isConneted = true;
  Widget body = Container();

  @override
  void initState() {
    super.initState();

    //check network connectivity updates
    Connectivity().onConnectivityChanged.listen((result) async {
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi) ||
          await checkConnectivity()) {
        //fetch latest data ones the connection is restored
        _fetchData();
      } else {
        _showOfflineToast();
      }
    });

    updateBodyContent();

    //clear preexisting filter
    FilterService().clearFilterPreferences();
  }

  ///fetch latest data the web
  void _fetchData() {
    HighlightsService().fetchHighlightsData();
    TrainingsService().fetchTrainingsData();
    setState(() {
      isConneted = true;
    });
    updateBodyContent();
  }

  ///returns true, only when internet connection enabled otherwise false.
  Future<bool> checkConnectivity() async {
    try {
      //identifier for 24/7 software's host lookup address.
      const serverLookupAddress = 'https://www.google.com';
      final result = await InternetAddress.lookup(serverLookupAddress);
      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }

    return false;
  }

  ///show offline toast message
  void _showOfflineToast() {
    setState(() {
      isConneted = false;
    });
    updateBodyContent();
    Fluttertoast.showToast(
      msg: Constants.noNewtworkConnection,
      backgroundColor: Themes.primaryColor,
      textColor: Themes.secondaryColor,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  ///update body content based on network connectivity
  void updateBodyContent() {
    if (!isConneted) {
      setState(() {
        body = Center(
          child: Image.asset(
            'assets/noConnection.png',
            width: 200,
          ),
        );
      });
    } else {
      setState(() {
        body = Column(
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

                      Obx(() {
                        if (_highlightsController.highlightsList.isEmpty &&
                            !_highlightsController.noHighlightsFound.value) {
                          return SizedBox(
                            height: Get.size.height * 0.2,
                            width: Get.size.width,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Themes.primaryColor,
                                strokeWidth: 2,
                                strokeCap: StrokeCap.round,
                              ),
                            ),
                          );
                        }

                        if (_highlightsController.noHighlightsFound.value) {
                          return SizedBox(
                            height: Get.size.height * 0.2,
                            width: Get.size.width,
                            child: const Center(
                              child: Text(
                                Constants.noTrainingsAvailableLabel,
                                style: TextStyle(
                                  color: Themes.primaryColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          );
                        }

                        return CarouselSlider.builder(
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
                          ),
                          itemCount:
                              _highlightsController.highlightsList.length,
                          itemBuilder: (
                            BuildContext context,
                            int index,
                            int realIndex,
                          ) {
                            return TrainingCarousalCard(
                              training:
                                  _highlightsController.highlightsList[index],
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),

            // Training list view
            Obx(() {
              if ((_trainingsController.trainingsList.isEmpty ||
                      _trainingsController.loading.value) &&
                  !_trainingsController.noTrainingFound.value) {
                return SizedBox(
                  height: Get.size.height * 0.2,
                  width: Get.size.width,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Themes.primaryColor,
                      strokeWidth: 2,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                );
              }

              if (_trainingsController.noTrainingFound.value) {
                return SizedBox(
                  height: Get.size.height * 0.2,
                  width: Get.size.width,
                  child: const Center(
                    child: Text(
                      Constants.noTrainingsAvailableLabel,
                      style: TextStyle(
                        color: Themes.primaryColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              }

              return Expanded(
                child: SizedBox(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.all(15),
                    itemCount: _trainingsController.trainingsList.length,
                    itemBuilder: (context, index) {
                      return EnrollmentCard(
                        training: _trainingsController.trainingsList[index],
                      );
                    },
                  ),
                ),
              );
            }),
          ],
        );
      });
    }
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
            IconButton(
              icon: const Icon(
                Icons.filter_alt_rounded,
              ),
              onPressed: () {
                if (isConneted) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Themes.secondaryColor,
                    shape: const RoundedRectangleBorder(),
                    builder: (context) {
                      return FractionallySizedBox(
                        heightFactor: 0.7,
                        child: SortAndFilterContent(
                          titles: _filterController.titles.value,
                          locations: _filterController.locations.value,
                          trainerNames: _filterController.trainers.value,
                        ),
                      );
                    },
                  );
                } else {
                  _showOfflineToast();
                }
              },
            ),
          ],
        ),
        body: SizedBox(
          height: Get.size.height,
          width: Get.size.width,
          child: body,
        ),
      ),
    );
  }
}
