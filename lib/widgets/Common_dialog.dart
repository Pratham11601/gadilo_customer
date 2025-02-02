import 'package:cupertino_range_slider_improved/cupertino_range_slider.dart';
import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/controller/dashboard_controller.dart';
import 'package:gadi_customer_repo/utils/app_colors.dart';
import 'package:gadi_customer_repo/utils/app_enums.dart';
import 'package:gadi_customer_repo/utils/string_utils.dart';
import 'package:gadi_customer_repo/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'constant_widgets.dart';

class FilterDialog extends StatelessWidget {
  final DashBoardController controller = Get.put(DashBoardController());
  final VoidCallback onApplyFilters;
  final double budgetMaxPrice;

  FilterDialog({required this.onApplyFilters, required this.budgetMaxPrice});

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
        return Colors.green[800]!; // Darker green for darkGreen
      case Colour.white:
        return Colors.white;
      case Colour.yellow:
        return Colors.yellow;
      case Colour.purple:
        return Colors.purple;
      case Colour.orange:
        return Colors.orange;
      case Colour.pink:
        return Colors.pink;
      case Colour.cyan:
        return Colors.cyan;
      case Colour.brown:
        return Colors.brown;
      default:
        return Colors.transparent; // Fallback color
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                      ["Petrol", "Diesel", "CNG", "EV"],
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
                      ["1", "2", "3", "4"],
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
                    Obx(() {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: CupertinoRangeSlider(
                          minValue: controller.minValue.value,
                          maxValue: controller.maxValue.value,
                          min: 0.0,
                          max: budgetMaxPrice,
                          onMinChanged: (minVal) {
                            controller.updateMin(minVal);
                          },
                          onMaxChanged: (maxVal) {
                            controller.updateMax(maxVal);
                          },
                        ),
                      );
                    }),
                    Obx(() {
                      return Text(
                        'Price Range: ${formatToRoundedFigure(controller.minValue.value)} - ${formatToRoundedFigure(controller.maxValue.value)}',
                        style: TextStyle(fontSize: 20),
                      );
                    }),
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
                    Center(
                      child: SizedBox(
                        width: 68.w,
                        child: buildFilterSectionColors(
                          "Colors",
                          Colour.values,
                          controller.selectedColor,
                          controller.setFilterColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                onPressed: () {
                  Get.back();

                  onApplyFilters();
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

class FilterDialogForSpares extends StatelessWidget {
  final DashBoardController controller = Get.put(DashBoardController());
  final VoidCallback onApplyFilters;

  FilterDialogForSpares({required this.onApplyFilters});

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
                      style: TextStyle(fontSize: 19.sp, color: selectedOption.value == option ? ColorsForApp.primaryColor : Colors.black),
                    ),
                  )),
            );
          }).toList(),
        ),
      ],
    );
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: ExpansionTile(
                  title: Text(
                    "Motors",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14.px),
                  ),
                  children: [
                    buildFilterSection(
                      "Vehicle Types",
                      ["car", "bike"],
                      controller.VehicleType,
                      controller.selectVehicleType,
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
                    "Type",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14.px),
                  ),
                  children: [
                    buildFilterSection(
                      "Types",
                      ["old", "new"],
                      controller.spareType,
                      controller.selectSpareType,
                    ),
                  ],
                ),
              ),
              height(10),
              CustomButton(
                onPressed: () {
                  Get.back();

                  onApplyFilters();
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
