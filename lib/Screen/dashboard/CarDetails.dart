import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gadi_customer_repo/controller/dashboard_controller.dart';
import 'package:gadi_customer_repo/models/dasboard/cars_model.dart';
import 'package:gadi_customer_repo/widgets/back_common_button.dart';
import 'package:gadi_customer_repo/widgets/common_cards_cars.dart';
import 'package:gadi_customer_repo/widgets/common_specifications.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_colors.dart';
import '../../utils/string_utils.dart';
import '../../utils/text_style.dart';
import '../../widgets/constant_widgets.dart';

class CarDetails extends StatelessWidget {
  final DashBoardController dashBoardController = Get.find();
  final CarsList cars;
  CarDetails({required this.cars});

  @override
  Widget build(BuildContext context) {
    final images = (cars.carImage as List<String>?) ?? [];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
                  child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonBackButton(),
              width(40),
            ],
          ),
          SizedBox(height: 20),
          CarouselSlider(
            options: CarouselOptions(
              height: 20.h,
              autoPlay: true,
              viewportFraction: 0.8,
              enableInfiniteScroll: true,
              autoPlayInterval: Duration(seconds: 4),
              autoPlayCurve: Curves.easeInCubic,
              enlargeCenterPage: true,
              enlargeFactor: 1,
            ),
            items: cars.carImage!.map((imageUrl) {
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "   ${capitalizeFirstLetter(cars.brand!)}",
                style: GoogleFonts.poppins(fontSize: 24.px, fontWeight: FontWeight.w500, color: const Color.fromRGBO(15, 15, 20, 1)),
              ),
              Text(
                " ${formatPriceRange(cars.carPrice!)} ",
                style: GoogleFonts.poppins(fontSize: 18.px, fontWeight: FontWeight.w400, color: const Color.fromRGBO(15, 15, 20, 1)),
              ),
            ],
          ),
          SizedBox(height: 20),
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
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),
                  ),
          ),
          height(2.w),
          Row(
            children: [
              SizedBox(width: 12),
              Text(
                "Dealer Details",
                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, color: Color.fromRGBO(15, 15, 20, 1)),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 12),
              Text(
                "Budget Car",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Color.fromRGBO(15, 15, 20, 1)),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 12),
              RichText(
                text: TextSpan(
                  text: 'Address:',
                  style: GoogleFonts.poppins(fontSize: 14, color: Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.w400),
                  children: <TextSpan>[
                    TextSpan(
                      text: "${cars.city}",
                      style: GoogleFonts.poppins(fontSize: 13, color: Color.fromRGBO(15, 15, 20, 0.76), fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              width(2.w),
              Text(
                "Reviews",
                style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: Color.fromRGBO(15, 15, 20, 1)),
              ),
              width(1.w),
              RatingBar.builder(
                initialRating: double.parse(cars.numberOfOwners!),
                minRating: 1,
                direction: Axis.horizontal,
                itemSize: 4.5.w,
                itemPadding: EdgeInsets.symmetric(horizontal: 1),
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: index < double.parse(cars.numberOfOwners!) ? Color.fromRGBO(255, 238, 83, 1) : Color.fromRGBO(210, 210, 210, 1),
                ),
                onRatingUpdate: (rating) {},
              ),
              width(5.w),
              InkWell(
                onTap: () {
                  dashBoardController.makePhoneCall(cars.contactNumber!);
                },
                child: Container(
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
                        Text(
                          "Call Dealer",
                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(15, 15, 20, 1)),
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
          SizedBox(height: 14),
          Row(
            children: [
              SizedBox(width: 10),
              Text(
                "Specifications",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: Color.fromRGBO(15, 15, 20, 1)),
              ),
            ],
          ),
          SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CommonSpecifications(
                imagePath: 'assets/waz.png',
                value: "${cars.color}",
                labelStyle: "Color",
              ),
              CommonSpecifications(
                imagePath: 'assets/jhgf.png',
                value: "${cars.kilometersDriven}",
                labelStyle: "Km driven",
              ),
              CommonSpecifications(
                imagePath: 'assets/kiuj.png',
                value: "${cars.transmissionType}",
                labelStyle: "Transmission",
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CommonSpecifications(
                imagePath: 'assets/rewsz.png',
                value: "${cars.year}",
                labelStyle: "Year",
              ),
              CommonSpecifications(
                imagePath: 'assets/eddc.png',
                value: "${cars.numberOfOwners}",
                labelStyle: "No. of owner",
              ),
              CommonSpecifications(
                imagePath: 'assets/fcv.png',
                value: "${cars.fuelType}",
                labelStyle: "Fuel",
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 15),
              Text(
                "You may like this",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Color.fromRGBO(15, 15, 20, 1)),
              ),
            ],
          ),
          Obx(() {
            if (dashBoardController.isLoading.value) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  height(12.h),
                  Center(
                    child: CupertinoActivityIndicator(
                      radius: 30,
                      color: ColorsForApp.primaryColor,
                    ),
                  ),
                  Text(
                    'Loading cars',
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
                  height(12.h),
                  Text(
                    'There are no Cars Available',
                    style: TextHelper.size16(context).copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            } else {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: dashBoardController.getCarsSuggestionList.length >= 4 ? 4 : dashBoardController.getCarsList.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    final cars = dashBoardController.getCarsSuggestionList[index];
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CarDetails(cars: cars)));
                  },
                  child: buildCommonCarsCard(
                    context,
                    cars: dashBoardController.getCarsSuggestionList[index],
                  ),
                ),
              );
            }
          }),
          height(3.h)
        ],
      )))),
    );
  }
}
