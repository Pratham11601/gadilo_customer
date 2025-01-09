import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/dashboard_controller.dart';
import '../utils/app_colors.dart';
import '../utils/app_enums.dart';

class FilterDialogStyle extends StatelessWidget {
  final DashBoardController controller = Get.put(DashBoardController());
  final VoidCallback onApplyFilters;

  FilterDialogStyle({required this.onApplyFilters});

  Widget buildFilterSection(String title, List<String> options, RxString selectedOption, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 4.0,
          runSpacing: 1.0,
          children: options.map((option) {
            return GestureDetector(
              onTap: () => onSelect(option),
              child: Obx(() => Container(
                    padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: selectedOption.value == option ? ColorsForApp.primaryColor.withOpacity(0.05) : Colors.grey[100],
                      border:
                          selectedOption.value == option ? Border.all(color: ColorsForApp.primaryColor) : Border.all(color: Colors.grey),
                    ),
                    child: Text(
                      option,
                      style: TextStyle(fontSize: 10.0, color: selectedOption.value == option ? ColorsForApp.primaryColor : Colors.black),
                    ),
                  )),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget buildFilterSectionColors(String title, List<Colour> options, Rx<Colour?> selectedOption, Function(Colour) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 16.0,
          runSpacing: 8.0,
          children: options.map((option) {
            return GestureDetector(
              onTap: () {
                onSelect(option);
              },
              child: Obx(() => Container(
                    width: 20.0, // Circle diameter
                    height: 20.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: getColorFromEnum(option),
                      border: selectedOption.value == option
                          ? Border.all(color: Colors.black, width: 1)
                          : Border.all(color: Colors.grey, width: 1),
                    ),
                  )),
            );
          }).toList(),
        ),
      ],
    );
  }

  Color getColorFromEnum(Colour color) {
    switch (color) {
      case Colour.black:
        return Colors.black;
      case Colour.grey:
        return Colors.grey;
      case Colour.red:
        return Colors.red;
      case Colour.blue:
        return Colors.blue;
      case Colour.darkGreen:
        return Colors.green;
      default:
        return Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(7.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ExpansionTile(
              title: Text(
                "By Fuel Type",
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14.0),
              ),
              children: [
                buildFilterSection(
                  "Fuel Types",
                  ["Petrol", "Diesel", "CNG", "LPG"],
                  controller.selectedFuelType,
                  controller.selectFuelType,
                ),
              ],
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ExpansionTile(
              title: Text("By Number of Owners", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14.0)),
              children: [
                buildFilterSection(
                  "Owners",
                  ["First", "Second", "Third", "Fourth"],
                  controller.filterOwners,
                  controller.selectOwner,
                ),
              ],
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ExpansionTile(
              title: Text(
                "By Budget",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                ),
              ),
              children: [
                buildFilterSection(
                  "Budgets",
                  ["1L-5L", "5L-10L", "10L-15L", "30L+"],
                  controller.filterBudget,
                  controller.selectBudget,
                ),
              ],
            ),
          ),
          Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ExpansionTile(
              title: Text("By Colour", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14.0)),
              children: [
                buildFilterSectionColors(
                  "Colors",
                  Colour.values,
                  controller.selectedColor,
                  controller.setFilterColor,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0), // Space before the button

          GestureDetector(
            onTap: () {
              onApplyFilters();
              Get.back();
            },
            child: Text("Apply Filters"),
          ),
        ],
      ),
    );
  }
}
