import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/controller/dashboard_controller.dart';
import 'package:gadi_customer_repo/utils/app_colors.dart';
import 'package:gadi_customer_repo/utils/app_enums.dart';
import 'package:gadi_customer_repo/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FilterDialog extends StatelessWidget {
  final DashBoardController controller = Get.put(DashBoardController());
  final VoidCallback onApplyFilters;

  FilterDialog({required this.onApplyFilters});

  Widget buildFilterSection(String title, List<String> options, RxString selectedOption, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: options.map((option) {
            return GestureDetector(
              onTap: () => onSelect(option),
              child: Obx(() => Container(
                    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.51.h),
                    decoration: BoxDecoration(
                      color: selectedOption.value == option ? ColorsForApp.primaryColor.withOpacity(0.05) : Colors.grey[100],
                      border:
                          selectedOption.value == option ? Border.all(color: ColorsForApp.primaryColor) : Border.all(color: Colors.grey),
                    ),
                    child: Text(
                      option,
                      style: TextStyle(fontSize: 16.sp, color: selectedOption.value == option ? ColorsForApp.primaryColor : Colors.black),
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
          spacing: 4.w,
          runSpacing: 2.h,
          children: options.map((option) {
            return GestureDetector(
              onTap: () {
                onSelect(option);
              },
              child: Obx(() => Container(
                    width: 7.w, // Circle diameter
                    height: 7.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: getColorFromEnum(option),
                      border: selectedOption.value == option
                          ? Border.all(color: Colors.black, width: 2)
                          : Border.all(color: Colors.grey, width: 1),
                    ),
                  )),
            );
          }).toList(),
        ),
        SizedBox(height: 1.h),
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
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14.px),
                  ),
                  children: [
                    buildFilterSection(
                      "Fuel Types",
                      ["Petrols", "Diesel", "CNG", "LPG"],
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
                  title: Text("By Number of Owners", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14.px)),
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
                      fontSize: 14.px,
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
                  title: Text("By Colour", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14.px)),
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
              CustomButton(
                onPressed: () {
                  onApplyFilters();
                  Get.back();
                },
                label: 'Apply Filters',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
