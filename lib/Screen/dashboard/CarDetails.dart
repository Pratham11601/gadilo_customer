import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gadi_customer_repo/controller/dashboard_controller.dart';
import 'package:gadi_customer_repo/models/dasboard/cars_model.dart';
import 'package:gadi_customer_repo/widgets/back_common_button.dart';
import 'package:gadi_customer_repo/widgets/common_specifications.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../generated/assets.dart';
import '../../utils/app_colors.dart';
import '../../utils/text_style.dart';
import '../../widgets/common_cards_cars.dart';
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
              child: Column(
        children: [
          //caurasel
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
                    return Container(
                      width: double.infinity, // Full width
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Positioned(
                    right: 4,
                    bottom: 4,
                    child: Image.asset(
                      "assets/kiuj.png",
                      height: 6.h,
                    )),
                Positioned(
                  left: 4,
                  top: 4,
                  child: CommonBackButton(),
                ),
              ],
            ),
          ),
          height(2.w),

          //Price
          Row(
            children: [
              Text(
                textAlign: TextAlign.left,
                "    ₹ ${cars.carPrice}/-",
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w400, color: Color.fromRGBO(15, 15, 20, 1)),
              ),
            ],
          ),
          //model
          Row(
            children: [
              Text(
                textAlign: TextAlign.left,
                "    ${cars.brand} ${cars.model} ",
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w400, color: Color.fromRGBO(15, 15, 20, 1)),
              ),
            ],
          ),

          //Deatils // TODO
          Row(
            children: [
              SizedBox(width: 12),
              Icon(Icons.location_pin),
              Text(
                "car Details ?? API error",
                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, color: Color.fromRGBO(15, 15, 20, 1)),
              ),
            ],
          ),

          Row(
            children: [
              SizedBox(width: 5.w),
              Text(
                "${cars.city}",
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),

          // call and Mpas
          Row(
            children: [
              width(3.w),
              RatingBar.builder(
                initialRating: double.parse(cars.ratings ?? "0.0"),
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
                          dashBoardController.makePhoneCall(cars.contactNumber ?? "0");
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
                          dashBoardController.openMaps(cars.shop_address ?? "katraj puhe");
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
          ),

          SizedBox(height: 14),

          Row(
            children: [
              SizedBox(width: 10),
              Text(
                "Specifications",
                style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w400, color: Color.fromRGBO(15, 15, 20, 1)),
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
              return SizedBox(
                height: 30.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
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
                ),
              );
            }
          }),
          height(3.h)
        ],
      ))),
    );
  }
}
