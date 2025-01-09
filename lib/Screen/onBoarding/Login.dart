import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/routes/routes.dart';
import 'package:gadi_customer_repo/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../controller/auth_controller.dart';
import '../../widgets/common_password_field.dart';
import '../../widgets/common_phone_textfileds.dart';

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
                  'Sign ln',
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
                  "Please Enter your Phone Number",
                ),
                SizedBox(height: 2.3.h),
                Common_text_field(
                  authController.password.value,
                  " Please Enter you Password",
                  "Password should includes combination letter capital,small,numbers and special symbols",
                  (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 1.h),
                _buildForgotPasswordLink(),
                SizedBox(height: 5.h),
                _buildLoginButton(),
                SizedBox(height: 3.h),
                _buildNewToAppText(),
                SizedBox(height: 1.h),
                _buildRegisterLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordLink() {
    return Row(
      children: [
        SizedBox(width: 60.w),
        InkWell(
          onTap: () {
            Get.toNamed(Routes.RESET_PASSWORD_SCREEN);
          },
          child: Text(
            'Forgot Password?',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.grey.shade800,
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return CustomButton(
      width: 85.w,
      label: "Login",
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          authController.loginUser();
        }
      },
    );
  }

  Widget _buildNewToAppText() {
    return Text(
      'New to App?',
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: Color.fromRGBO(15, 15, 20, 1),
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
        ),
      ),
    );
  }

  Widget _buildRegisterLink() {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.Register_SCREEN);
      },
      child: Text(
        'Register',
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: Color.fromRGBO(0, 90, 192, 1),
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            decoration: TextDecoration.underline,
            decorationColor: Color.fromRGBO(0, 90, 192, 1),
          ),
        ),
      ),
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
