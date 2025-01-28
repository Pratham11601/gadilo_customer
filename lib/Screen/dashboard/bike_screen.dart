import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gadi_customer_repo/controller/dashboard_controller.dart';
import 'package:gadi_customer_repo/generated/assets.dart';
import 'package:gadi_customer_repo/utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../models/auth/brandModel.dart';
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
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return FilterDialog(
                            onApplyFilters: () {
                              dashboardController.isBikeFilterApplied.value = true;
                              dashboardController.getBikeByBrandList.clear();
                              dashboardController.getbikesDealsListApi();
                              dashboardController.isBikeFilterApplied.value = true;
                              Get.toNamed(Routes.BIKE_DEAL_SCREEN);
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
                  return SizedBox(
                    height: 32.h,
                    width: 95.w,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
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
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
          child: Image.network(
            'https://gadilobharat.com/assets/images/c.jpg',
            width: 361,
            height: 205,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: -24,
          left: 7,
          child: SizedBox(
            height: 52,
            width: 350,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
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
                            width: 5.w,
                            height: 5.w,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: TypeAheadField<BrandNamesList>(
                      controller: dashboardController.searchText.value,
                      decorationBuilder: (context, child) => Material(
                        borderRadius: BorderRadius.circular(200),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            border: Border.all(color: Colors.transparent), // Ensure no border
                          ),
                          child: child,
                        ),
                      ),
                      suggestionsCallback: (query) async {
                        await dashboardController.fetchBrands(query);
                        return dashboardController.brand;
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion.brandName ?? ""),
                        );
                      },
                      errorBuilder: (context, error) {
                        return Center(
                          child: Text("Error occurred!"),
                        );
                      },
                      onSelected: (BrandNamesList value) {
                        dashboardController.getBikeByBrandList.clear();
                        dashboardController.setFilterBrand(value.brandName!);
                        dashboardController.getBikeByBrandList();
                        Get.toNamed(Routes.BIKE_DEAL_SCREEN);
                        print(value.toString());
                        print(value.toJson());
                        print(value);
                        print(value);
                      },
                    )),
                  ],
                ),
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
        dashboardController.getBikeByBrandList.clear();
        dashboardController.setFilterBrand(brandName);
        dashboardController.getbikesDealsListApi();
        Get.toNamed(Routes.BIKE_DEAL_SCREEN);
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
              dashboardController.getbikesDealsListApi();
              Get.toNamed(Routes.BIKE_DEAL_SCREEN);

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
