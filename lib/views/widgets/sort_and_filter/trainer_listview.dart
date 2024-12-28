import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_trainings_app/services/trainings_service.dart';
import 'package:my_trainings_app/utils/themes.dart';

import '../../../controllers/trainings_controller.dart';
import '../../../services/filter_service.dart';
import '../../../utils/constants.dart';

class TrainerListView extends StatefulWidget {
  final List<String> trainerNames;
  const TrainerListView({super.key, required this.trainerNames});

  @override
  TrainerListViewState createState() => TrainerListViewState();
}

class TrainerListViewState extends State<TrainerListView> {
  final TrainingsController _trainingsController =
      Get.put(TrainingsController());

  // List of items
  List<String> trainers = [];

  // Observable list to keep track of selected items
  RxList<String> selectedItems = <String>[].obs;

  // Text controller for the search input
  TextEditingController searchController = TextEditingController();

  // Filtered list to display
  RxList<String> filteredItems = <String>[].obs;

  @override
  void initState() {
    super.initState();
    TrainingsService().fetchTrainingsData();
    trainers.addAll(widget.trainerNames);
    setPrefData();

    // Initialize the filtered list with all items
    filteredItems.addAll(trainers);
    searchController.addListener(() {
      _filterItems();
    });
  }

  ///Filter out the filteredItems list
  void _filterItems() {
    String query = searchController.text.toLowerCase();
    filteredItems.value =
        trainers.where((item) => item.toLowerCase().contains(query)).toList();
  }

  ///Handles selection/deselection of list items
  void _toggleSelection(String item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
    //save updated items in pref
    FilterService()
        .saveFilterPreferences(Constants.trainerPrefList, selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search,
                color: Themes.tertiaryColor,
              ),
              hintText: "Search",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Themes.tertiaryColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Themes.tertiaryColor)),
            ),
          ),
        ),
        Expanded(
          child: Obx(
            () {
              return ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  String trainer = filteredItems[index];
                  return ListTile(
                    title: Text(trainer),
                    trailing: Obx(
                      () => Checkbox(
                        value: selectedItems.contains(trainer),
                        activeColor: Themes.tertiaryColor,
                        onChanged: (bool? value) {
                          _toggleSelection(trainer);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  ///Update filter items as per previously preserved data
  Future<void> setPrefData() async {
    var filter =
    await FilterService().loadFilterPreferences(Constants.trainerPrefList);
    selectedItems.addAllIf(true, filter);
  }
}
