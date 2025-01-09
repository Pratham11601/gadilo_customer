import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/controller/auth_controller.dart';
import 'package:gadi_customer_repo/widgets/constant_widgets.dart';
import 'package:gadi_customer_repo/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ResetPassword extends StatefulWidget {
  ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool _isChecked = false;
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(140),
        child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: Center(
              child: Image.asset(
                'assets/rxsd.png',
                width: double.infinity,
                height: 170,
                fit: BoxFit.cover,
              ),
            )),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
                  child: Column(
        children: [
          SizedBox(height: 70),
          Text(
            "Forgot Password?",
            style: GoogleFonts.poppins(fontSize: 22, color: Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 40),
          Text(
            "Enter your registered mobile number",
            style: GoogleFonts.poppins(fontSize: 16, color: Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 30),
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
                      padding: EdgeInsets.only(bottom: 10.3, right: 10),
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
          height(50.w),
          CustomButton(
            width: 85.w,
            label: "Send OTP",
            onPressed: () {
              authController.forgetPasswordSendOtpAPiCall();
            },
          ),
          SizedBox(height: 100),
          Image.asset(
            'assets/sxa.png',
            width: double.infinity,
            height: 35.h,
            fit: BoxFit.cover,
          ),
        ],
      )))),
    );
  }
}
