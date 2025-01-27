import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/controller/dashboard_controller.dart';
import 'package:gadi_customer_repo/generated/assets.dart';
import 'package:gadi_customer_repo/utils/app_colors.dart';
import 'package:gadi_customer_repo/widgets/clear_filter_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../models/dasboard/view_cars_model.dart';
import '../../routes/routes.dart';
import '../../utils/text_styles.dart';
import '../../widgets/Common_dialog.dart';
import '../../widgets/common_bikes.dart';
import '../../widgets/common_filter_container.dart';
import '../../widgets/constant_widgets.dart';
import 'BikeDetails.dart';

class BikeScreen extends StatelessWidget {
  BikeScreen({super.key});

  final DashBoardController dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Obx(() {
                    return Visibility(
                        visible: dashboardController.isCarFilterApplied.value,
                        child: GestureDetector(
                            onTap: () {
                              dashboardController.filterBrand.value = "";
                              dashboardController.filterColor.value = "";
                              dashboardController.filterBudget.value = "";
                              dashboardController.filterColor.value = "";
                              dashboardController.isBikeFilterApplied.toggle();
                              dashboardController.getbikesListApi();
                            },
                            child: CustomClearFilterButton()));
                  }),
                  Obx(() {
                    return Visibility(visible: dashboardController.isCarFilterApplied.value, child: CustomClearFilterButton());
                  }),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return FilterDialog(
                            onApplyFilters: () {
                              dashboardController.getbikesListApi();
                              dashboardController.isBikeFilterApplied.value = true;
                            },
                          );
                        },
                      );
                    },
                    child: FilterContainer(),
                  ),
                ],
              ),
              Center(
                child: Text(
                  "Explore by brands",
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Color.fromRGBO(15, 15, 20, 1)),
                ),
              ),
              _buildBrandRow(),
              Obx(() {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: dashboardController.isBikeImageVisible.value,
                      child: Row(
                        children: [
                          SizedBox(width: 125),
                          InkWell(
                            onTap: () {
                              dashboardController.isBikeImageVisible.toggle();
                            },
                            child: Text(
                              "View all brands",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(0, 90, 192, 1),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Image.asset(
                            'assets/iuhg.png',
                            width: 24,
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                    if (dashboardController.isBikeImageVisible.value == false) _buildbikeBrandssGridView(dashboardController.bikeList),
                  ],
                );
              }),
              Obx(() {
                if (dashboardController.isLoading.value) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      height(42.h),
                      Center(
                        child: CupertinoActivityIndicator(
                          radius: 30,
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

                if (dashboardController.bikeList.isEmpty) {
                  return Column(
                    children: [
                      height(12.h),
                      Text(
                        'There are no Bike Available',
                        style: TextHelper.size16(context).copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                } else {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 1, crossAxisSpacing: 1.w, mainAxisSpacing: 1.h, mainAxisExtent: 30.h),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: dashboardController.getBikeList.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        debugPrint("  <--debug--> ${dashboardController.getBikeList[index].toString()}");

                        final bikes = dashboardController.getBikeList[index];
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BikeDetails(bikes: bikes)));
                      },
                      child: buildBikeWidget(
                        context,
                        bike: dashboardController.getBikeList[index],
                      ),
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          'assets/cdcoih.png',
          width: 361,
          height: 205,
        ),
        Positioned(
          top: 30,
          left: 86,
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/kjhg.png',
                    width: 26,
                    height: 26,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Best Value Deals',
                    style: TextStyle(
                      color: Color.fromRGBO(15, 15, 20, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 15),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Affordable prices on top brands.',
                    style: TextStyle(
                      color: Color.fromRGBO(15, 15, 20, 1),
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          top: 90,
          left: 35.w,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: ElevatedButton(
              onPressed: () {
                dashboardController.filterBrand.value = "";
                dashboardController.filterColor.value = "";
                dashboardController.filterColor.value = "";
                dashboardController.getbikesDealsListApi();
                Get.toNamed(Routes.BIKE_DEAL_SCREEN);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(29),
                ),
                minimumSize: Size(116, 36),
                backgroundColor: Color.fromRGBO(10, 98, 148, 1),
                elevation: 0,
              ),
              child: Text(
                "Find a Deal",
                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Color.fromRGBO(251, 254, 255, 1)),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -24,
          left: 7,
          child: SizedBox(
            height: 52,
            width: 350,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  const BoxShadow(
                    color: Color.fromRGBO(111, 111, 111, 0.13),
                    spreadRadius: 2,
                    blurRadius: 9,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(29),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        Image.asset(
                          "assets/rcr.png",
                          width: 15,
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.3, right: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color.fromRGBO(91, 91, 91, 1),
                          ),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: InkWell(
                              onTap: () {
                                dashboardController.getbikesListApi();
                              },
                              child: Container(
                                width: 20.w,
                                height: 4.h,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(10, 98, 148, 1),
                                  borderRadius: BorderRadius.circular(70),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 3),
                                  child: Image.asset(
                                    "assets/wdeded.png",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBrandRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildBrandContainer('assets/njkn.png', "TVS"),
        _buildBrandContainer('assets/vfcxdc.png', "Yamaha"),
        _buildBrandContainer(Assets.bikeimagesHonda, "Honda"),
      ],
    );
  }

  Widget _buildBrandContainer(String assetPath, String brandName) {
    return InkWell(
      onTap: () {
        dashboardController.getBikeList().clear();
        dashboardController.setFilterBrand(brandName);
        dashboardController.getbikesListApi();
        dashboardController.isBikeImageVisible.value == true ? true.obs : dashboardController.isBikeImageVisible.toggle();
      },
      child: Container(
        height: 13.h,
        width: 31.w,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 1),
          border: Border.all(
            color: Color.fromRGBO(244, 244, 244, 1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            SizedBox(height: 11),
            Image.asset(
              assetPath,
              width: 46,
              height: 46,
            ),
            SizedBox(height: 5),
            Text(
              brandName,
              style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: Color.fromRGBO(15, 15, 20, 1)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildbikeBrandssGridView(List<VehicleBrandsModel> cars) {
    return Container(
      height: 80.h,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 1.w,
          mainAxisSpacing: 1.h,
        ),
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return InkWell(
            onTap: () {
              String brandName = car.brand.toString().split('.').last;
              dashboardController.getBikeList.clear();
              dashboardController.setFilterBrand(brandName);
              dashboardController.getbikesListApi();
              dashboardController.isBikeImageVisible.value == true ? true.obs : dashboardController.isBikeImageVisible.toggle();
            },
            child: Container(
              height: 40.h,
              width: 31.h,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color.fromRGBO(244, 244, 244, 1),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    car.imagePath,
                    width: 46,
                    height: 46,
                  ),
                  SizedBox(height: 5),
                  Text(
                    car.brand.toString().split('.').last, // Get the enum name
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(15, 15, 20, 1),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
