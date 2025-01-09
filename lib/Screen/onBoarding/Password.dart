import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/controller/setting_controller.dart';
import 'package:gadi_customer_repo/widgets/constant_widgets.dart';
import 'package:gadi_customer_repo/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/back_common_button.dart';
import '../../widgets/common_password_field.dart';

class Password extends StatelessWidget {
  Password({super.key});
  SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
                  child: Column(
        children: [
          height(1.h),
          CommonBackButton(),
          SizedBox(height: 12),
          Text(
            "Password & Security",
            style: GoogleFonts.poppins(fontSize: 18, color: Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 23),
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                "Change Password",
                style: GoogleFonts.poppins(fontSize: 16, color: Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                "Current Password",
                style: GoogleFonts.poppins(fontSize: 13, color: Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: 9),
          Common_text_field(
            settingController.currentPassword.value,
            " Current Pasword",
            "Password should includes combination letter capital,small,numbers and special symbols",
            (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                "New Password",
                style: GoogleFonts.poppins(fontSize: 13, color: Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: 9),
          Common_text_field(
            settingController.newPassword.value,
            "Enter New Pasword",
            "Password should includes combination letter capital,small,numbers and special symbols",
            (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                "Confirm New Password",
                style: GoogleFonts.poppins(fontSize: 13, color: Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: 9),
          Common_text_field(
            settingController.confirmnewPassword.value,
            "Enter New Pasword",
            "Password should includes combination letter capital,small,numbers and special symbols",
            (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }
              return null;
            },
          ),
          SizedBox(height: 100),
          CustomButton(
            width: 85.w,
            label: "Change Password",
            onPressed: () async {
              if (settingController.newPassword.value.text.toString() == settingController.confirmnewPassword.value.text.toString()) {
                settingController.changePasswordApiCall();
                Get.back();
              } else {
                print(settingController.newPassword.value.toString());
                print(settingController.confirmnewPassword.value.text.toString());
                Get.snackbar("Error", "Please Password dont match");
              }
            },
          ),
        ],
      )))),
    );
  }
}
