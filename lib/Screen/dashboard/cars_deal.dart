import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controller/dashboard_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/text_style.dart';
import '../../widgets/Common_dialog.dart';
import '../../widgets/clear_filter_button.dart';
import '../../widgets/common_cards_cars.dart';
import '../../widgets/common_filter_container.dart';
import '../../widgets/constant_widgets.dart';
import 'CarDetails.dart';

class CarsDeal extends StatelessWidget {
  final DashBoardController dashboardController = Get.find();

  CarsDeal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            height(5.h),
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(1, 1),
                ),
              ]),
              width: 91.w,
              child: TextField(
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search Cities",
                  filled: true,
                  fillColor: Colors.white, // Background color
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
                  ),
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    dashboardController.fetchCities(value);
                  } else {
                    dashboardController.fetchCities("");
                  }
                },
              ),
            ),
            height(2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() {
                  return Visibility(
                      visible: dashboardController.isCarFilterApplied.value,
                      child: GestureDetector(
                          onTap: () {
                            dashboardController.clearFilters();
                            dashboardController.filterBrand.value = "";
                            dashboardController.filterColor.value = "";
                            dashboardController.filterBudget.value = "";
                            dashboardController.filterColor.value = "";
                            dashboardController.selectedFuelType.value = "";
                            dashboardController.isCarFilterApplied.toggle();
                            dashboardController.getCarsDealsListApi();
                          },
                          child: CustomClearFilterButton()));
                }),
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return FilterDialog(
                          onApplyFilters: () {
                            dashboardController.getCarsByBrandList.clear();
                            dashboardController.isCarFilterApplied.value = true;
                            dashboardController.getCarsDealsListApi();
                          },
                        );
                      },
                    );
                  },
                  child: FilterContainer(),
                ),
              ],
            ),
            height(5),
            Obx(() {
              if (dashboardController.isLoadingInCas.value) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    height(32.h),
                    const Center(
                      child: CupertinoActivityIndicator(
                        radius: 40,
                        color: ColorsForApp.primaryColor,
                      ),
                    ),
                    Text(
                      'Loading cars',
                      style: TextHelper.size16(context).copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }
              if (dashboardController.getCarsByBrandList.isEmpty) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        height(42.h),
                        Text(
                          'There are no Cars Available',
                          style: TextHelper.size16(context).copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                return SizedBox(
                  height: 85.h,
                  width: 99.w,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2,
                      mainAxisExtent: 30.h,
                      crossAxisSpacing: 0.w,
                      mainAxisSpacing: 0.h,
                    ),
                    shrinkWrap: true,
                    itemCount: dashboardController.getCarsByBrandList.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        final cars = dashboardController.getCarsByBrandList[index];
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CarDetails(cars: cars)));
                      },
                      child: buildCommonCarsCard(
                        context,
                        cars: dashboardController.getCarsByBrandList[index],
                      ),
                    ),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
