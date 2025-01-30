import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controller/dashboard_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/text_style.dart';
import '../../widgets/Common_dialog.dart';
import '../../widgets/clear_filter_button.dart';
import '../../widgets/common_bikes.dart';
import '../../widgets/common_filter_container.dart';
import '../../widgets/constant_widgets.dart';
import 'BikeDetails.dart';

class BikeDeal extends StatelessWidget {
  final DashBoardController dashboardController = Get.find();
  BikeDeal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                hintText: "Search By Model",
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
                    visible: dashboardController.isBikeFilterApplied.value,
                    child: GestureDetector(
                        onTap: () {
                          dashboardController.clearFilters();
                          dashboardController.filterBrand.value = "";
                          dashboardController.filterColor.value = "";
                          dashboardController.filterBudget.value = "";
                          dashboardController.filterColor.value = "";
                          dashboardController.selectedFuelType.value = "";
                          dashboardController.isBikeFilterApplied.toggle();
                          dashboardController.getbikesDealsListApi();
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
                          dashboardController.getBikeByBrandList.clear();
                          dashboardController.isCarFilterApplied.value = true;
                          dashboardController.isBikeFilterApplied.value = true;
                          dashboardController.getbikesDealsListApi();
                        },
                      );
                    },
                  );
                },
                child: FilterContainer(),
              ),
            ],
          ),
          height(1.h),
          Obx(() {
            if (dashboardController.isLoadingInBikes.value) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  height(12.h),
                  Center(
                    child: CupertinoActivityIndicator(
                      radius: 20,
                      color: ColorsForApp.primaryColor,
                    ),
                  ),
                  Text(
                    'Loading Bikes..',
                    style: TextHelper.size16(context).copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }

            if (dashboardController.getBikeByBrandList.isEmpty) {
              return Center(
                child: Text(
                  'There are no Bike Available',
                  style: TextHelper.size16(context).copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return SizedBox(
                height: 78.h,
                width: 99.w,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1, crossAxisSpacing: 1.w, mainAxisSpacing: 1.h, mainAxisExtent: 30.h),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: dashboardController.getBikeByBrandList.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      final bikes = dashboardController.getBikeByBrandList[index];
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BikeDetails(bikes: bikes)));
                    },
                    child: buildBikeWidget(
                      context,
                      bike: dashboardController.getBikeByBrandList[index],
                    ),
                  ),
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
