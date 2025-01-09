import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gadi_customer_repo/controller/setting_controller.dart';
import 'package:gadi_customer_repo/routes/routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/custom_button.dart';

class AboutUs extends StatefulWidget {
  AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  double _currentRating = 3.0;
  final SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10),
        child: AppBar(backgroundColor: Colors.white, elevation: 0, automaticallyImplyLeading: false, flexibleSpace: Text("")),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
                  child: Column(
        children: [
          SizedBox(height: 4),
          Row(
            children: [
              SizedBox(width: 20),
              Container(
                width: 50,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color.fromRGBO(15, 15, 20, 0.32),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(27),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/assa.png',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            "About Us",
            style: GoogleFonts.poppins(fontSize: 18, color: Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 21),
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                "Rate Us",
                style: GoogleFonts.poppins(fontSize: 16, color: Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: 30),
          RatingBar.builder(
            initialRating: _currentRating,
            minRating: 1,
            direction: Axis.horizontal,
            itemSize: 50,
            itemPadding: EdgeInsets.symmetric(horizontal: 1),
            itemBuilder: (context, index) => Icon(
              Icons.star,
              color: index < _currentRating ? Color.fromRGBO(255, 238, 83, 1) : Color.fromRGBO(235, 235, 235, 1),
            ),
            onRatingUpdate: (rating) {
              setState(() {
                _currentRating = rating;
              });
            },
          ),
          SizedBox(height: 50),
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                "Give us feedback",
                style: GoogleFonts.poppins(fontSize: 16, color: Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
                width: double.infinity,
                height: 93,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(242, 242, 242, 1),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(91, 91, 91, 0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 0, right: 5),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Type here...",
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 12, fontWeight: FontWeight.w400, color: Color.fromRGBO(15, 15, 20, 0.6)),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                ),
                                style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 16)),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          ),
          SizedBox(height: 120),
          CustomButton(
            width: 85.w,
            label: "Submit",
            onPressed: () async {
              await settingController.FeedbackApiCall();
              await settingController.RateUsApiCall(_currentRating.toString());
              Get.toNamed(Routes.HOME_SCREEN);
            },
          ),
        ],
      )))),
    );
  }
}
