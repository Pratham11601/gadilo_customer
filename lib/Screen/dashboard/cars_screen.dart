import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/controller/auth_controller.dart';
import 'package:gadi_customer_repo/controller/dashboard_controller.dart';
import 'package:gadi_customer_repo/utils/string_utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../models/auth/brandModel.dart';
import '../../routes/routes.dart';
import '../../utils/app_colors.dart';
import '../../utils/text_styles.dart';
import '../../widgets/common_cards_cars.dart';
import '../../widgets/constant_widgets.dart';
import 'CarDetails.dart';

class CarsScreen extends StatelessWidget {
  final DashBoardController dashboardController = Get.find();
  final AuthController authController = Get.find();

  CarsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    return Text(" Welcome ${capitalizeFirstLetter(dashboardController.name.value.text)}!",
                        style: TextHelper.size18(context)
                            .copyWith(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold));
                  }),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.SELECT_CITY_SCREEN);
                    },
                    child: Row(
                      children: [
                        Obx(() {
                          return Text(
                            dashboardController.location.value,
                            style: TextHelper.size18(context),
                          );
                        }),
                        Image.asset(
                          'assets/juhf.png',
                          width: 24,
                          height: 24,
                        ),
                        width(3.w)
                      ],
                    ),
                  ),
                ],
              ),
              _buildHeader(),
              height(4.h),
              Obx(() {
                return _buildCarGridView(dashboardController.carbrand);
              }),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("  Top Trending", style: TextHelper.size18(context).copyWith(fontWeight: FontWeight.bold, color: Colors.black)),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.CARS_DEAL_SCREEN);
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
                    ],
                  ),
                  height(1.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(() {
                        if (dashboardController.isLoadingInCas.value) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              height(11.h),
                              Center(
                                child: CupertinoActivityIndicator(
                                  radius: 30,
                                  color: ColorsForApp.primaryColor,
                                ),
                              ),
                            ],
                          );
                        }

                        if (dashboardController.getCarsRandomList.isEmpty) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              height(18.h),
                              Text(
                                'Opps ! No Cars Found ',
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
                            height: 31.h,
                            width: 95.w,
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
                              itemCount: dashboardController.getCarsRandomList.length,
                              itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  dashboardController.getCarsListSuggestionApi();
                                  final cars = dashboardController.getCarsRandomList[index];
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CarDetails(cars: cars)));
                                },
                                child: buildCommonCarsCard(
                                  context,
                                  cars: dashboardController.getCarsRandomList[index],
                                ),
                              ),
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                ],
              ),
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
              return Image.network('${dashboardController.getBannerImg[0].banImg!}', width: 94.w, height: 26.h, fit: BoxFit.cover,
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
                            dashboardController.fetchCarBrandsBySearchAPI(value);
                          } else {
                            dashboardController.fetchCarBrandsBydefaultAPI();
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

  Widget _buildCarGridView(List<BrandNamesList> cars) {
    // Define the number of rows and the height for each row
    const int maxRows = 4;
    double rowHeight = 16.h;

    final itemCount = cars.length;
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
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final bikes = cars[index];
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
