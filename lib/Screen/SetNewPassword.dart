import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/controller/auth_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../widgets/custom_button.dart';

class SetNewPassword extends StatelessWidget {
  SetNewPassword({super.key});
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250),
        child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: Center(
              child: Container(
                width: double.infinity,
                height: 338,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color.fromRGBO(6, 76, 116, 1), Color.fromRGBO(154, 211, 243, 1)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 200),
                      Text(
                        'Forgot Password?',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color.fromRGBO(15, 15, 20, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
                  child: Column(
        children: [
          SizedBox(height: 35),
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                "Set New Password",
                style: GoogleFonts.poppins(fontSize: 16, color: Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 20),
              SizedBox(
                height: 46,
                width: 318,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(155, 155, 155, 0.3), width: 1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10.7, right: 10),
                          child: TextField(
                            controller: authController.password.value,
                            decoration: InputDecoration(
                              hintText: "Enter New Password",
                              hintStyle:
                                  GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(6, 10, 14, 0.62)),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                            style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 16)),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 20),
              Text(
                "Confirm Password",
                style: GoogleFonts.poppins(fontSize: 16, color: Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              SizedBox(width: 20),
              SizedBox(
                height: 46,
                width: 318,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(155, 155, 155, 0.3), width: 1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 10.7, right: 10),
                          child: TextField(
                            controller: authController.confirmPassword.value,
                            decoration: InputDecoration(
                              hintText: "Enter Confirm Password",
                              hintStyle:
                                  GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(6, 10, 14, 0.62)),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                            ),
                            style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 16)),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 70),
          CustomButton(
            width: 85.w,
            label: "Reset Password",
            onPressed: () {
              authController.passwordAPi();
            },
          ),
        ],
      )))),
    );
  }
}
