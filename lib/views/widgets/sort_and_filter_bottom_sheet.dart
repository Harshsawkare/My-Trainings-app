import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_trainings_app/utils/constants.dart';
import 'package:my_trainings_app/utils/themes.dart';

class SortAndFilterContent extends StatefulWidget {
  const SortAndFilterContent({super.key});

  @override
  _SortAndFilterContentState createState() => _SortAndFilterContentState();
}

class _SortAndFilterContentState extends State<SortAndFilterContent> {
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
      Center(child: Text("Sort options here")),
      buildLocationTab(),
      Center(child: Text("Training name options here")),
      Center(child: Text("Trainer options here")),
    ];

    return Column(
      children: [
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ),
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
      ],
    );
  }

  void onTabSelected(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  Widget buildLocationTab() {
    List<String> locations = [
      "West Des Moines",
      "Chicago, IL",
      "Phoenix, AZ",
      "Dallas, TX",
      "San Diego, CA",
      "San Francisco, CA",
      "New York, ZK",
    ];
    Map<String, bool> selectedLocations = {
      for (var location in locations) location: false,
    };

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: "Search",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              final location = locations[index];
              return CheckboxListTile(
                title: Text(location),
                value: selectedLocations[location],
                activeColor: Themes.tertiaryColor,
                selected: selectedLocations[location] ?? false,
                onChanged: (value) {
                  setState(() {
                    selectedLocations[location] = value!;
                  });
                },
              );
            },
          ),
        ),
      ],
    );
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
