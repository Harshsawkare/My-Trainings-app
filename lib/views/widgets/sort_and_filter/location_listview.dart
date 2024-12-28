import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_trainings_app/services/filter_service.dart';
import 'package:my_trainings_app/utils/constants.dart';
import 'package:my_trainings_app/utils/themes.dart';

class LocationListView extends StatefulWidget {
  final List<String> locations;
  const LocationListView({super.key, required this.locations});

  @override
  LocationListViewState createState() => LocationListViewState();
}

class LocationListViewState extends State<LocationListView> {
  // List of items
  List<String> locations = [];

  // Observable list to keep track of selected items
  RxList<String> selectedItems = <String>[].obs;

  // Text controller for the search input
  TextEditingController searchController = TextEditingController();

  // Filtered list to display
  RxList<String> filteredItems = <String>[].obs;

  @override
  void initState() {
    super.initState();
    locations.addAll(widget.locations);
    setPrefData();

    // Initialize the filtered list with all items
    filteredItems.addAll(locations);
    searchController.addListener(() {
      _filterItems();
    });
  }

  ///Filter out the filteredItems list
  void _filterItems() {
    String query = searchController.text.toLowerCase();
    filteredItems.value =
        locations.where((item) => item.toLowerCase().contains(query)).toList();
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
        .saveFilterPreferences(Constants.locationPrefList, selectedItems);
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
                  String location = filteredItems[index];
                  return ListTile(
                    title: Text(location),
                    trailing: Obx(
                      () => Checkbox(
                        value: selectedItems.contains(location),
                        activeColor: Themes.tertiaryColor,
                        onChanged: (bool? value) {
                          _toggleSelection(location);
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
        await FilterService().loadFilterPreferences(Constants.locationPrefList);
    selectedItems.addAllIf(true, filter);
  }
}
