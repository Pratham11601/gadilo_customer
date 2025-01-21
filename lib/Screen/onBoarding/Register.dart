import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../controller/auth_controller.dart';
import '../../generated/assets.dart';
import '../../utils/app_colors.dart';
import '../../widgets/constant_widgets.dart';

class Register extends StatelessWidget {
  Register({super.key});
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsForApp.backGroundColor,
      body: SingleChildScrollView(
          child: Center(
              child: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: BottomCurveClipper(),
                child: Image.asset(
                  Assets.assetsYyyft,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 40.h,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 10.h,
                child: ClipPath(
                  clipper: BottomCurveClipper(),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ),
            ],
          ),
          height(10.h),
          Text(
            'Registration',
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                color: Color.fromRGBO(15, 15, 20, 1),
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
            ),
          ),
          SizedBox(height: 23),
          SizedBox(
            height: 45,
            width: 316,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(155, 155, 155, 0.3), width: 1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 90,
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        Image.asset(
                          "assets/drd.png",
                          width: 21,
                          height: 21,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "+91",
                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(15, 15, 20, 1)),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 6, right: 10),
                      child: TextField(
                        controller: authController.phone.value,
                        decoration: InputDecoration(
                          hintText: "Enter your mobile number",
                          hintStyle: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(6, 10, 14, 0.62)),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 16)),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 130),
          CustomButton(
            width: 85.w,
            label: "Send OTP",
            onPressed: () {
              authController.sendOTPApiCall();
            },
          ),
        ],
      ))),
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height); // Start from bottom-left

    var controlPoint = Offset(size.width / 2, size.height - 50);
    var endPoint = Offset(size.width, size.height); // End at the bottom-right

    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0.0);
    path.lineTo(0.0, 0.0);
    path.close(); // Completes the path

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; // Return true if you want to reclip when the widget updates
  }
}
