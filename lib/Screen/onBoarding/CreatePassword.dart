import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/controller/auth_controller.dart';
import 'package:gadi_customer_repo/widgets/custom_button.dart';
import 'package:gadi_customer_repo/widgets/snack_abar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../routes/routes.dart';
import '../../widgets/constant_widgets.dart';

class CreatePassword extends StatefulWidget {
  CreatePassword({super.key});

  @override
  State<CreatePassword> createState() => _CreatePasswordState();
}

class _CreatePasswordState extends State<CreatePassword> {
  final AuthController authController = Get.find();

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(236),
        child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: Center(
              child: Image.asset(
                'assets/tcdf.png',
                width: double.infinity,
                height: 393,
                fit: BoxFit.cover,
              ),
            )),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
                  child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "Create Password",
            style: GoogleFonts.poppins(fontSize: 22, color: Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 25),
          SizedBox(
            height: 45,
            width: 316,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.12), width: 1),
                borderRadius: BorderRadius.circular(50.27),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2, right: 10),
                          child: Image.asset(
                            "assets/ffrf.png",
                            width: 19,
                            height: 19,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 9, right: 10),
                      child: TextField(
                        controller: authController.password.value,
                        decoration: InputDecoration(
                          hintText: "Create Password",
                          hintStyle:
                              GoogleFonts.poppins(fontSize: 14.36, fontWeight: FontWeight.w400, color: Color.fromRGBO(6, 10, 14, 0.62)),
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
          SizedBox(height: 18),
          SizedBox(
            height: 45,
            width: 316,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(0, 0, 0, 0.12), width: 1),
                borderRadius: BorderRadius.circular(50.27),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2, right: 10),
                          child: Image.asset(
                            "assets/ffrf.png",
                            width: 19,
                            height: 19,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 9, right: 10),
                      child: TextField(
                        controller: authController.confirmPassword.value,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          hintStyle:
                              GoogleFonts.poppins(fontSize: 14.36, fontWeight: FontWeight.w400, color: Color.fromRGBO(6, 10, 14, 0.62)),
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
          height(10.h),
          // SizedBox(height: 190),
          CustomButton(
            width: 85.w,
            label: "Continue",
            onPressed: () {
              if (_isChecked == true) {
                authController.createPasswordAndRegisterUser();
              } else {
                showSnackbar(context, "Accepts Terms of Use");
              }
            },
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 30),
              InkWell(
                onTap: () {
                  setState(() {
                    _isChecked = !_isChecked;
                  });
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: _isChecked ? Color.fromRGBO(10, 98, 148, 1) : Colors.transparent,
                    border: Border.all(color: Color.fromRGBO(181, 181, 181, 1)),
                  ),
                  child: _isChecked ? Icon(Icons.check, color: Color.fromRGBO(251, 254, 255, 1), size: 20) : null,
                ),
              ),
              SizedBox(width: 20),
              InkWell(
                  onTap: () {},
                  child: RichText(
                    text: TextSpan(
                      text: 'By creating an account you confirm',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Color.fromRGBO(9, 8, 24, 1),
                        fontWeight: FontWeight.w400,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '\nTerms of use',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Color.fromRGBO(0, 102, 219, 0.6),
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(Routes.TERMS_CONDN_SCREEN);
                            },
                        ),
                        TextSpan(
                          text: ' and ',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Color.fromRGBO(9, 8, 24, 1),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'Privacy policy',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Color.fromRGBO(0, 102, 219, 0.6),
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(Routes.PRIVACY_POLICY_SCREEN);
                            },
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ],
      )))),
    );
  }
}
