import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gadi_customer_repo/controller/dashboard_controller.dart';
import 'package:gadi_customer_repo/models/dasboard/spares_model.dart';
import 'package:gadi_customer_repo/utils/string_utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_colors.dart';
import '../../utils/text_style.dart';
import '../../widgets/back_common_button.dart';
import '../../widgets/common_spare_item.dart';
import '../../widgets/constant_widgets.dart';

class SandADetails extends StatelessWidget {
  final DashBoardController dashBoardController = Get.find();
  final SparesList spares;

  SandADetails({required this.spares});

  @override
  Widget build(BuildContext context) {
    final images = (spares.images as List<String>?) ?? [];
    final review = spares.review != null ? double.parse(spares.review!) : 0.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                _buildHeader(),
                _buildCarousel(images),
                const SizedBox(height: 8.5),
                _buildTitleAndPrice(),
                const SizedBox(height: 20),
                _buildImageList(images),
                Divider(),
                _buildSectionTitle("Description"),
                _buildSectionTitle("Dealer Details"),
                _buildDealerAddress(),
                SizedBox(height: 15),
                _buildSectionTitle("Reviews"),
                _buildReviewSection(review),
                const SizedBox(height: 18),
                _buildSectionTitle("View Similar"),
                const SizedBox(height: 30),
                Obx(() {
                  if (dashBoardController.isLoading.value) {
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
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.all(1.w),
                      itemCount: dashBoardController.getSparedList.length,
                      itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            final spares = dashBoardController.getSparedList[index];
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SandADetails(spares: spares)));
                          },
                          child: spareItem(
                            spares: dashBoardController.getSparedList[index],
                          )),
                    );
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [CommonBackButton(), height(7.h)],
    );
  }

  Widget _buildCarousel(List<String> images) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 20.h,
        autoPlay: true,
        viewportFraction: 0.8,
        enableInfiniteScroll: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayCurve: Curves.easeInOutQuad,
        enlargeCenterPage: true,
        enlargeFactor: 1,
      ),
      items: images.map((imageUrl) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                imageUrl,
                width: 96.w,
                height: 20.h,
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildTitleAndPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "   ${capitalizeFirstLetter(spares.name!)}",
          style: GoogleFonts.poppins(
            fontSize: 24.px,
            fontWeight: FontWeight.w500,
            color: const Color.fromRGBO(15, 15, 20, 1),
          ),
        ),
        Text(
          " ${formatPriceRange(spares.price!)} ",
          style: GoogleFonts.poppins(
            fontSize: 18.px,
            fontWeight: FontWeight.w400,
            color: const Color.fromRGBO(15, 15, 20, 1),
          ),
        ),
      ],
    );
  }

  Widget _buildImageList(List<String> images) {
    return SizedBox(
      height: 10.h,
      child: images.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      images[index],
                      width: 14.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'No images available',
                style: GoogleFonts.poppins(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(0, 0, 0, 0.6),
                ),
              ),
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
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color.fromRGBO(15, 15, 20, 1),
          ),
        ),
      ],
    );
  }

  Widget _buildDealerAddress() {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            text: '   Address:',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(15, 15, 20, 1),
            ),
            children: <TextSpan>[
              TextSpan(
                text: spares.address,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(79, 79, 79, 1),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReviewSection(double review) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        RatingBar.builder(
          initialRating: review,
          minRating: 1,
          direction: Axis.horizontal,
          itemSize: 15.52,
          itemPadding: EdgeInsets.symmetric(horizontal: 1),
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: index < review ? Color.fromRGBO(255, 238, 83, 1) : Color.fromRGBO(210, 210, 210, 1),
          ),
          onRatingUpdate: (rating) {},
        ),
        _buildCallButton()
      ],
    );
  }

  Widget _buildCallButton() {
    return InkWell(
      onTap: () {
        dashBoardController.makePhoneCall(spares.phoneNumber ?? "1");
      },
      child: Container(
        width: 178,
        height: 39,
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
            children: [
              SizedBox(width: 30),
              Text(
                "Call Dealer",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(15, 15, 20, 1),
                ),
              ),
              SizedBox(width: 8),
              Image.asset(
                'assets/hgfs.png',
                width: 5,
                height: 26,
              ),
              SizedBox(width: 8),
              Image.asset(
                'assets/yyfrc.png',
                width: 20,
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
