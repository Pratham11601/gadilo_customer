import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gadi_customer_repo/models/dasboard/bike_model.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../controller/dashboard_controller.dart';
import '../../utils/app_colors.dart';
import '../../utils/string_utils.dart';
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
    final images = (bikes.carImage as List<String>?) ?? [];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(10),
        child: AppBar(backgroundColor: Colors.white, elevation: 0, automaticallyImplyLeading: false, flexibleSpace: const Text("")),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
                  child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonBackButton(),
              width(40),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 20.h,
                  autoPlay: true,
                  viewportFraction: 0.8,
                  enableInfiniteScroll: true,
                  autoPlayInterval: const Duration(seconds: 9),
                  autoPlayCurve: Curves.easeInCubic,
                  enlargeCenterPage: true,
                  enlargeFactor: 1,
                ),
                items: images.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image(
                            image: NetworkImage(imageUrl),
                            width: 96.w,
                            height: 20.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 8.5),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "   ${capitalizeFirstLetter(bikes.brand!)}",
                style: GoogleFonts.poppins(fontSize: 24.px, fontWeight: FontWeight.w500, color: const Color.fromRGBO(15, 15, 20, 1)),
              ),
              Text(
                " ${formatPriceRange(bikes.carPrice!)} ",
                style: GoogleFonts.poppins(fontSize: 18.px, fontWeight: FontWeight.w400, color: const Color.fromRGBO(15, 15, 20, 1)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 10.h,
            child: images.isNotEmpty
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      final imageModel = images[index];
                      return Padding(
                        padding: EdgeInsets.only(right: 1.w, left: 1.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image(
                            image: NetworkImage(
                              "${imageModel}",
                            ),
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
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 12),
              Text(
                "Dealer Details",
                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, color: const Color.fromRGBO(15, 15, 20, 1)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 12),
              Text(
                "Cre Used Bikes Showroom",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: const Color.fromRGBO(15, 15, 20, 1)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 12),
              RichText(
                text: TextSpan(
                  text: 'Address:',
                  style: GoogleFonts.poppins(fontSize: 14, color: const Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.w400),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${bikes.city}',
                      style: GoogleFonts.poppins(fontSize: 13, color: const Color.fromRGBO(15, 15, 20, 0.76), fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              width(2.w),
              Text(
                "Reviews",
                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: const Color.fromRGBO(15, 15, 20, 1)),
              ),
              width(1.w),
              RatingBar.builder(
                initialRating: double.parse("5"),
                minRating: 1,
                direction: Axis.horizontal,
                itemSize: 4.5.w,
                itemPadding: const EdgeInsets.symmetric(horizontal: 1),
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: index < double.parse(bikes.numberOfOwners!)
                      ? const Color.fromRGBO(255, 238, 83, 1)
                      : const Color.fromRGBO(210, 210, 210, 1),
                ),
                onRatingUpdate: (rating) {},
              ),
              width(5.w),
              InkWell(
                onTap: () {
                  dashBoardController.makePhoneCall(bikes.contactNumber!);
                },
                child: Container(
                  width: 47.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(247, 247, 247, 1),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      const BoxShadow(
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
                        Text(
                          "Call Dealer",
                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: const Color.fromRGBO(15, 15, 20, 1)),
                        ),
                        Image.asset(
                          'assets/hgfs.png',
                          width: 5,
                          height: 26,
                        ),
                        Image.asset(
                          'assets/yyfrc.png',
                          width: 20,
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
              SizedBox(
                width: 32.w,
                height: 28.w,
              )
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
            if (dashBoardController.isLoading.value) {
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

            if (dashBoardController.bikeList.isEmpty) {
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
                    crossAxisCount: 2, childAspectRatio: 1, crossAxisSpacing: 1.w, mainAxisSpacing: 1.h, mainAxisExtent: 26.h),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: dashBoardController.getBikeSuggestionList.length,
                itemBuilder: (context, index) => buildBikeWidget(
                  context,
                  bike: dashBoardController.getBikeSuggestionList[index],
                ),
              );
            }
          }),
        ],
      )))),
    );
  }
}
