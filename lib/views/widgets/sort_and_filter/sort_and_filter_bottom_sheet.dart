import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_trainings_app/services/filter_service.dart';
import 'package:my_trainings_app/utils/constants.dart';
import 'package:my_trainings_app/utils/themes.dart';
import 'package:my_trainings_app/views/widgets/sort_and_filter/location_listview.dart';
import 'package:my_trainings_app/views/widgets/sort_and_filter/trainer_listview.dart';
import 'package:my_trainings_app/views/widgets/sort_and_filter/training_listview.dart';

class SortAndFilterContent extends StatefulWidget {
  final List<String> titles;
  final List<String> locations;
  final List<String> trainerNames;
  const SortAndFilterContent({
    super.key,
    required this.titles,
    required this.locations,
    required this.trainerNames,
  });

  @override
  SortAndFilterContentState createState() => SortAndFilterContentState();
}

class SortAndFilterContentState extends State<SortAndFilterContent> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      TabButton(
        title: Constants.sortByLabel,
        index: 0,
        selectedIndex: selectedTabIndex,
        onTap: onTabSelected,
      ),
      TabButton(
        title: Constants.locationLabel,
        index: 1,
        selectedIndex: selectedTabIndex,
        onTap: onTabSelected,
      ),
      TabButton(
        title: Constants.trainingNameLabel,
        index: 2,
        selectedIndex: selectedTabIndex,
        onTap: onTabSelected,
      ),
      TabButton(
        title: Constants.trainerLabel,
        index: 3,
        selectedIndex: selectedTabIndex,
        onTap: onTabSelected,
      ),
    ];

    List<Widget> tabContents = [
      const Center(
        child: Text(
          Constants.comingSoonLabel,
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      LocationListView(
        locations: widget.locations,
      ),
      TrainerListView(
        trainerNames: widget.trainerNames,
      ),
      TrainingListView(
        titles: widget.titles,
      ),
    ];

    return Column(
      children: [

        // Top bar
        Container(
          decoration: const BoxDecoration(
            color: Themes.secondaryColor,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  Constants.sortAndFilterLabel,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ),

        // Tabs
        Expanded(
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
                color: Themes.secondaryColor,
                child: Column(
                  children: [
                    for (var tab in tabs) tab,
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: tabContents[selectedTabIndex],
                ),
              ),
            ],
          ),
        ),

        // Buttons
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Clear filter
              ElevatedButton(
                onPressed: () async {
                  FilterService().clearFilterPreferences();
                  FilterService().applyFilter();
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Themes.secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: const BorderSide(
                    color: Themes.tertiaryColor,
                    width: 2,
                  )
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Constants.clearLabel,
                    style: TextStyle(
                      color: Themes.tertiaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // Apply filter
              ElevatedButton(
                onPressed: () async {
                  FilterService().applyFilter();
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Themes.tertiaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Constants.applyLabel,
                    style: TextStyle(
                      color: Themes.secondaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void onTabSelected(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }
}

class TabButton extends StatelessWidget {
  final String title;
  final int index;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const TabButton({
    super.key,
    required this.title,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == selectedIndex;
    return InkWell(
      onTap: () => onTap(index),
      child: Container(
        color: isSelected ? Themes.secondaryColor : Themes.bgColor,
        child: Row(
          children: [
            Container(
              width: 4,
              height: 50,
              color: isSelected ? Themes.tertiaryColor : Colors.transparent,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: Themes.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
