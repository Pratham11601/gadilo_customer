import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gadi_customer_repo/models/dasboard/bike_model.dart';
import 'package:gadi_customer_repo/routes/routes.dart';
import 'package:gadi_customer_repo/utils/string_utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../controller/dashboard_controller.dart';
import '../../generated/assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/text_style.dart';
import '../../widgets/back_common_button.dart';
import '../../widgets/common_bikes.dart';
import '../../widgets/common_specifications.dart';
import '../../widgets/constant_widgets.dart';

class BikeDetails extends StatelessWidget {
  final DashBoardController dashBoardController = Get.find();
  final BikeList bikes;
  BikeDetails({super.key, required this.bikes});

  @override
  Widget build(BuildContext context) {
    final images = (bikes.bikeImage as List<String>?) ?? [];
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.HOME_SCREEN);
        return false; // Prevent the default back action
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Center(
                child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 25.h,
              child: Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 25.h, // Set the height of the carousel
                      autoPlay: true,
                      viewportFraction: 1.0,
                      enableInfiniteScroll: true,
                      autoPlayInterval: Duration(seconds: 4),
                      autoPlayCurve: Curves.easeInCubic,
                      enlargeCenterPage: false,
                    ),
                    items: images.map((imageUrl) {
                      return Stack(
                        children: [
                          SizedBox(
                            width: double.infinity, // Full width
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.fill,
                              height: 30.h, // Set the height of the carousel
                            ),
                          ),
                          Positioned(
                              right: 4,
                              bottom: 1,
                              child: Image.asset(
                                Assets.assetsPngWaterMarks,
                                height: 9.h,
                              )),
                        ],
                      );
                    }).toList(),
                  ),
                  Positioned(
                    left: 4,
                    top: 4,
                    child: CommonBackButton(),
                  ),
                ],
              ),
            ),
            //Price
            Row(
              children: [
                Text(
                  textAlign: TextAlign.left,
                  "    ₹ ${bikes.bikePrice}/-",
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w400, color: Color.fromRGBO(15, 15, 20, 1)),
                ),
              ],
            ),
            //model
            Row(
              children: [
                Text(
                  textAlign: TextAlign.left,
                  "    ${capitalizeFirstLetter(bikes.brand!)} ${capitalizeFirstLetter(bikes.model!)} ",
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(15, 15, 20, 1)),
                ),
              ],
            ),

            Row(
              children: [
                SizedBox(width: 5.w),
                Text(
                  "${bikes.city}",
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),

            // call and Mpas
            Row(
              children: [
                width(3.w),
                RatingBar.builder(
                  initialRating: double.parse(bikes.ratings ?? "4.0"),
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemSize: 4.5.w,
                  itemPadding: EdgeInsets.symmetric(horizontal: 1),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: index < double.parse(bikes.numberOfOwners!) ? Color.fromRGBO(255, 238, 83, 1) : Color.fromRGBO(210, 210, 210, 1),
                  ),
                  onRatingUpdate: (rating) {},
                ),
                Spacer(),
                Container(
                  width: 47.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(247, 247, 247, 1),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.10),
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            dashBoardController.makePhoneCall(bikes.contactNumber ?? "0");
                          },
                          child: Image.asset(
                            '${Assets.assetsCalll}',
                            width: 22,
                            height: 22,
                          ),
                        ),
                        Container(
                          color: Colors.grey.shade700,
                          width: 2,
                          height: 3.5.h,
                        ),
                        InkWell(
                          onTap: () {
                            dashBoardController.openMaps(bikes.shopAddress ?? "Viman Nagar");
                          },
                          child: Image.asset(
                            '${Assets.assetsMappp}',
                            width: 22,
                            height: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                width(3.w),
              ],
            ),

            const SizedBox(height: 14),
            Row(
              children: [
                const SizedBox(width: 10),
                Text(
                  "Specifications",
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: const Color.fromRGBO(15, 15, 20, 1)),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CommonSpecifications(
                  imagePath: 'assets/waz.png',
                  value: "${bikes.color}",
                  labelStyle: "Color",
                ),
                CommonSpecifications(
                  imagePath: 'assets/jhgf.png',
                  value: "${bikes.kilometersDriven}",
                  labelStyle: "Km driven",
                ),
                CommonSpecifications(
                  imagePath: 'assets/rewsz.png',
                  value: "${bikes.year}",
                  labelStyle: "Year",
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CommonSpecifications(
                  imagePath: 'assets/eddc.png',
                  value: "${bikes.numberOfOwners}",
                  labelStyle: "No. of owner",
                ),
                CommonSpecifications(
                  imagePath: 'assets/fcv.png',
                  value: "${bikes.fuelType}",
                  labelStyle: "Fuel",
                ),
                CommonSpecifications(
                  imagePath: 'assets/fcv.png',
                  value: "${bikes.fuelType}",
                  labelStyle: "Fuel",
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const SizedBox(width: 15),
                Text(
                  "More like this",
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: const Color.fromRGBO(15, 15, 20, 1)),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Obx(() {
              if (dashBoardController.isLoadingInBikes.value) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    height(12.h),
                    const Center(
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
              if (dashBoardController.getBikeByBrandList.isEmpty) {
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
                  height: 30.h,
                  width: 100.w,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      itemCount: dashBoardController.getBikeByBrandList.length,
                      itemBuilder: (context, index) {
                        return buildBikeWidget(
                          context,
                          bike: dashBoardController.getBikeByBrandList[index],
                        );
                      }),
                );
              }
            }),
          ],
        ))),
      ),
    );
  }
}
