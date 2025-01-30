import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/controller/dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../models/dasboard/view_cars_model.dart';
import '../../routes/routes.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_bikes.dart';
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
              _buildbikeBrandssGridView(dashboardController.bikeList),
              height(4),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.BIKE_DEAL_SCREEN);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "View More",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromRGBO(0, 90, 192, 1),
                      ),
                    ),
                    Image.asset(
                      'assets/iuhg.png',
                      width: 18,
                      height: 18,
                    ),
                  ],
                ),
              ),
              height(4),
              Obx(() {
                if (dashboardController.isLoadingInBikes.value) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      height(42.h),
                      const Center(
                        child: CupertinoActivityIndicator(
                          radius: 30,
                          color: Colors.grey,
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
                if (dashboardController.getBikesRandom.isEmpty) {
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
                    height: 26.h,
                    width: 95.w,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: dashboardController.getBikesRandom.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          debugPrint("  <--debug--> ${dashboardController.getBikesRandom[index].toString()}");
                          final bikes = dashboardController.getBikesRandom[index];
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BikeDetails(bikes: bikes)));
                        },
                        child: buildBikeWidget(
                          context,
                          bike: dashboardController.getBikesRandom[index],
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
          child: Obx(() {
            if (dashboardController.getBannerImg.isNotEmpty) {
              return Image.network('${dashboardController.getBannerImg[1].banImg!}', width: 94.w, height: 26.h, fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.error, // Error icon
                  size: 24.0, // Adjust size as needed
                  color: Colors.red, // Color of the icon
                );
              });
            } else {
              return CircularProgressIndicator(); // Show a loading indicator while fetching
            }
          }),
        ),
        Positioned(
          bottom: -24,
          left: 1.w,
          child: SizedBox(
            height: 52,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                child: Row(
                  children: [
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
                          hintText: "Search Brand",
                          filled: true,
                          fillColor: Colors.white,
                          // Background color
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildbikeBrandssGridView(List<VehicleBrandsModel> cars) {
    return Container(
      height: 80.h,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
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
              dashboardController.getBikeByBrandList.clear();
              dashboardController.setFilterBrand(brandName);
              dashboardController.getbikesDealsListApi();
              Get.toNamed(Routes.BIKE_DEAL_SCREEN);
            },
            child: Container(
              height: 40.h,
              width: 31.h,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color.fromRGBO(244, 244, 244, 1),
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
                  const SizedBox(height: 5),
                  Text(
                    car.brand.toString().split('.').last, // Get the enum name
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: const Color.fromRGBO(15, 15, 20, 1),
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
