import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/controller/dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../models/auth/brandModel.dart';
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.SELECT_CITY_SCREEN);
                    },
                    child: Row(
                      children: [
                        Obx(() {
                          return Text(
                            dashboardController.location!.value,
                            style: TextHelper.size18(context),
                          );
                        }),
                        Image.asset(
                          'assets/juhf.png',
                          width: 24,
                          height: 24,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10.0), // Match the border radius
                              ),
                              child: Center(
                                child: Text(
                                  'Image not available',
                                  style: TextStyle(color: Colors.white, fontSize: 15), // Placeholder text color
                                ),
                              ),
                            );
                          },
                        ),
                        width(3.w)
                      ],
                    ),
                  ),
                ],
              ),
              _buildHeader(),
              SizedBox(height: 4.h),
              Obx(() {
                return _buildbikeBrandssGridView(dashboardController.bikebrand);
              }),
              height(4),
              Divider(),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.BIKE_DEAL_SCREEN);
                },
                child: Row(
                  children: [
                    width(15),
                    Text(
                      "Top Trending",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
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
                    width(5)
                  ],
                ),
              ),
              height(1.h),
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
                    width: 100.w,
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: dashboardController.getBikesRandom.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          debugPrint("  <--debug--> ${dashboardController.getBikesRandom[index].toString()}");
                          final bikes = dashboardController.getBikesRandom[index];

                          dashboardController.addInquiryApiCall(
                            bikes.id!,
                            "bike",
                            bikes.bikeId!,
                          );

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
          borderRadius: BorderRadius.circular(15.0),
          child: Obx(() {
            if (dashboardController.getBannerImg.isNotEmpty) {
              final filteredBanners = dashboardController.getBannerImg.where((banner) => banner.banFor == "bike").toList();
              if (filteredBanners.isNotEmpty) {
                return SizedBox(
                  width: 94.w,
                  height: 26.h,
                  child: Image.network(
                    '${filteredBanners[0].banImg!}',
                    width: 94.w,
                    height: 26.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Text("Failed to Fetch Image");
                    },
                  ),
                );
              } else {
                return SizedBox(
                  height: 24.h,
                  width: 94.w,
                  child: Text("No bike banner available"),
                );
              }
            } else {
              return SizedBox(
                width: 96.w,
                height: 24.h,
              );
            }
          }),
        ),
        Positioned(
          bottom: -24,
          left: 1.w,
          child: SizedBox(
            height: 52,
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
                        hintText: "Search Bike Brands",
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
                          dashboardController.fetchBikeBrandsBySearchAPI(value);
                        } else {
                          dashboardController.fetchBikeBrandsBydefaultAPI();
                        }
                      },
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

  Widget _buildbikeBrandssGridView(List<BrandNamesList> bike) {
    const int maxRows = 4;
    double rowHeight = 16.h;

    final itemCount = bike.length;
    final rowCount = (itemCount / 3).ceil();
    print(rowCount);
    print(rowCount);
    print(rowCount);
    print(rowCount);
    final gridHeight = rowCount > maxRows ? maxRows * rowHeight : rowCount * rowHeight;

    return Container(
      height: gridHeight,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 1.w,
          mainAxisSpacing: 1.h,
        ),
        itemCount: bike.length,
        itemBuilder: (context, index) {
          final bikes = bike[index];
          return InkWell(
            onTap: () {
              dashboardController.getBikeByBrandList.clear();
              dashboardController.setFilterBrand(bikes.brandName!);
              dashboardController.getbikesDealsListApi();
              Get.toNamed(Routes.BIKE_DEAL_SCREEN);
            },
            child: Container(
              height: 20.h,
              width: 31.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(244, 244, 244, 1),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    bikes.brandImg ?? "",
                    width: 51,
                    height: 51,
                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      return Icon(Icons.error, size: 51); // Display an error icon
                    },
                  ),
                  const SizedBox(height: 5),
                  Text(
                    bikes.brandName ?? " ", // Get the enum name
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
