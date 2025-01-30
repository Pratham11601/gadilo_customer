import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/routes/routes.dart';
import 'package:gadi_customer_repo/widgets/custom_button.dart';
import 'package:gadi_customer_repo/widgets/snack_abar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../controller/auth_controller.dart';
import '../../widgets/common_phone_textfileds.dart';
import '../../widgets/constant_widgets.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final AuthController authController = Get.find();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipPath(
                      clipper: BottomCurveClipper(),
                      child: Image.asset(
                        'assets/ggygg.png',
                        width: 100.w,
                        height: 30.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 55,
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
                SizedBox(height: 9.h),
                Text(
                  'Log  ln',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Color.fromRGBO(15, 15, 20, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 22.sp,
                    ),
                  ),
                ),
                SizedBox(height: 2.3.h),
                buildPhoneNumberField(
                  authController.phone.value,
                  " Enter your Phone Number",
                ),
                SizedBox(height: 23.h),
                _buildLoginButton(),
                SizedBox(height: 3.h),
                _buildNewToAppText(context),
                SizedBox(height: 1.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return CustomButton(
      width: 85.w,
      label: "Login",
      onPressed: () {
        showToast("Sending OTP Request ");
        if (_formKey.currentState!.validate()) {
          authController.sendOTPApiCall();
        }
      },
    );
  }

  Widget _buildNewToAppText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() => InkWell(
              onTap: () {
                authController.toggleCheckbox();
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: authController.isChecked.value ? Color.fromRGBO(10, 98, 148, 1) : Colors.transparent,
                  border: Border.all(color: Color.fromRGBO(181, 181, 181, 1)),
                ),
                child: authController.isChecked.value ? Icon(Icons.check, color: Color.fromRGBO(251, 254, 255, 1), size: 20) : null,
              ),
            )),
        width(5),
        SizedBox(
          width: 77.w,
          child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'By creating an account you confirm ',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Color.fromRGBO(15, 15, 20, 1),
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                TextSpan(
                  text: 'Terms of use',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.blue, // Change color as needed
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.toNamed(Routes.TERMS_CONDN_SCREEN);
                    },
                ),
                TextSpan(
                  text: ' and ',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Color.fromRGBO(15, 15, 20, 1),
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                TextSpan(
                  text: 'Privacy policy',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.blue, // Change color as needed
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.toNamed(Routes.PRIVACY_POLICY_SCREEN);
                    },
                ),
                TextSpan(
                  text: '.',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Color.fromRGBO(15, 15, 20, 1),
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);

    var controlPoint = Offset(size.width / 2, size.height - 50);
    var endPoint = Offset(size.width, size.height);

    path.quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    path.lineTo(size.width, 0.0);
    path.lineTo(0.0, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
