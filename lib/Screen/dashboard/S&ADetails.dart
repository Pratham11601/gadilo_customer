import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gadi_customer_repo/controller/dashboard_controller.dart';
import 'package:gadi_customer_repo/models/dasboard/spares_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../generated/assets.dart';
import '../../routes/routes.dart';
import '../../utils/app_colors.dart';
import '../../utils/text_style.dart';
import '../../widgets/back_common_button.dart';
import '../../widgets/common_spare_item.dart';
import '../../widgets/common_specifications.dart';
import '../../widgets/constant_widgets.dart';

class SandADetails extends StatelessWidget {
  final DashBoardController dashBoardController = Get.find();
  final SparesList spares;

  SandADetails({required this.spares});

  @override
  Widget build(BuildContext context) {
    final images = (spares.photo as List<String>?) ?? [];
    final review = spares.ratings != null ? double.parse(spares.ratings!) : 0.0;

    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(Routes.HOME_SCREEN);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  _buildCarousel(images),
                  Row(
                    children: [
                      Text(
                        textAlign: TextAlign.left,
                        "    ₹ ${spares.price}/-",
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w400, color: Color.fromRGBO(15, 15, 20, 1)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        textAlign: TextAlign.left,
                        "    ${spares.brand} ${spares.model} ",
                        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromRGBO(15, 15, 20, 1)),
                      ),
                    ],
                  ),
                  _buildCallButton(),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        "Specifications",
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: const Color.fromRGBO(15, 15, 20, 1)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CommonSpecifications(
                        imagePath: 'assets/eddc.png',
                        value: "${spares.numberOfOwners}",
                        labelStyle: "No. of owner",
                      ),
                      CommonSpecifications(
                        imagePath: Assets.assetsModel,
                        value: "${spares.type}",
                        labelStyle: "Type",
                      ),
                      CommonSpecifications(
                        imagePath: Assets.assetsModel,
                        value: "${spares.vehicleType ?? "Not Added"}",
                        labelStyle: "Vehicle Type",
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _buildSectionTitle("View Similar"),
                  const SizedBox(height: 7),
                  Obx(() {
                    if (dashBoardController.isLoadingInSpares.value) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          height(12.h),
                          Center(
                            child: CupertinoActivityIndicator(
                              radius: 1,
                              color: ColorsForApp.primaryColor,
                            ),
                          ),
                          Text(
                            'Loading',
                            style: TextHelper.size16(context).copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    }
                    if (dashBoardController.getCarsList.isEmpty) {
                      return Column(
                        children: [
                          height(32.h),
                          Text(
                            'There are no Spares available',
                            style: TextHelper.size18(context).copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    } else {
                      return SizedBox(
                        height: 24.h,
                        width: 99.w,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: dashBoardController.getSparedList.length,
                          itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                final spares = dashBoardController.getSparedList[index];
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SandADetails(spares: spares)));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: spareItem(
                                  spares: dashBoardController.getSparedList[index],
                                ),
                              )),
                        ),
                      );
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCarousel(List<String> images) {
    return SizedBox(
      height: 30.h,
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: 30.h, // Set the height of the carousel
              autoPlay: true,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              autoPlayInterval: Duration(seconds: 4),
              autoPlayCurve: Curves.easeOut,
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
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        SizedBox(width: 20),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(15, 15, 20, 1),
          ),
        ),
      ],
    );
  }

  Widget _buildCallButton() {
    return Row(
      children: [
        width(3.w),
        RatingBar.builder(
          initialRating: double.parse(spares.ratings ?? "0.0"),
          minRating: 1,
          direction: Axis.horizontal,
          itemSize: 4.5.w,
          itemPadding: EdgeInsets.symmetric(horizontal: 1),
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: index < double.parse(spares.numberOfOwners!) ? Color.fromRGBO(255, 238, 83, 1) : Color.fromRGBO(210, 210, 210, 1),
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
                    dashBoardController.makePhoneCall(spares.contactNumber ?? "0");
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
                    dashBoardController.openMaps(spares.shopAddress ?? "katraj puhe");
                  },
                  child: Image.asset(
                    '${Assets.assetsMaps}',
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
    );
  }
}
