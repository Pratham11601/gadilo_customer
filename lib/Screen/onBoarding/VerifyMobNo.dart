import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gadi_customer_repo/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/constant_widgets.dart';
import '../../widgets/custom_button.dart';

class VerifyMobNo extends StatefulWidget {
  VerifyMobNo({super.key});

  @override
  State<VerifyMobNo> createState() => _VerifyMobNoState();
}

class _VerifyMobNoState extends State<VerifyMobNo> {
  final TextEditingController textEditingController = TextEditingController();
  List<FocusNode> focusNodes = List.generate(5, (_) => FocusNode());

  final AuthController authController = Get.find();

  final TextEditingController text1Controller = TextEditingController();
  final TextEditingController text2Controller = TextEditingController();
  final TextEditingController text3Controller = TextEditingController();
  final TextEditingController text4Controller = TextEditingController();
  final TextEditingController text5Controller = TextEditingController();
  final TextEditingController text6Controller = TextEditingController();

  void _autoFillNextField(TextEditingController currentController, TextEditingController nextController) {
    if (currentController.text.length == 1) {
      FocusScope.of(context).nextFocus();
    } else if (currentController.text.isEmpty) {
      FocusScope.of(context).previousFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(10, 98, 148, 1),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
                  child: Column(
        children: [
          SizedBox(height: 180),
          Container(
              width: 361,
              height: 432,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color.fromRGBO(246, 246, 246, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 60),
                    Text(
                      'Verify OTP',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color.fromRGBO(15, 15, 20, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Please enter OTP sent to your\n'
                      '   registered mobile number',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color.fromRGBO(15, 15, 20, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 45,
                          height: 43,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: TextField(
                              controller: text1Controller,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                _autoFillNextField(text1Controller, text2Controller);
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                hintText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Color.fromRGBO(234, 234, 234, 1),
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                              ),
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(9, 8, 24, 1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 13),
                        Container(
                          width: 45,
                          height: 43,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: TextField(
                              controller: text2Controller,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                _autoFillNextField(text2Controller, text3Controller);
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                hintText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Color.fromRGBO(234, 234, 234, 1),
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                              ),
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(9, 8, 24, 1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 13),
                        Container(
                          width: 45,
                          height: 43,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: TextField(
                              controller: text3Controller,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                _autoFillNextField(text3Controller, text4Controller);
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                hintText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Color.fromRGBO(234, 234, 234, 1),
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                              ),
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(9, 8, 24, 1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 13),
                        Container(
                          width: 45,
                          height: 43,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: TextField(
                              controller: text4Controller,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                _autoFillNextField(text4Controller, text4Controller);
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                hintText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Color.fromRGBO(234, 234, 234, 1),
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                              ),
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(9, 8, 24, 1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 13),
                        Container(
                          width: 45,
                          height: 43,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: TextField(
                              controller: text5Controller,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                _autoFillNextField(text5Controller, text6Controller);
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                hintText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Color.fromRGBO(234, 234, 234, 1),
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                              ),
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(9, 8, 24, 1),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 13),
                        Container(
                          width: 45,
                          height: 43,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: TextField(
                              controller: text6Controller,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {},
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: InputDecoration(
                                hintText: '',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Color.fromRGBO(234, 234, 234, 1),
                                contentPadding: EdgeInsets.symmetric(vertical: 10),
                              ),
                              style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(9, 8, 24, 1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    height(20.w),
                    CustomButton(
                      width: 85.w,
                      label: "Verify OTP",
                      onPressed: () {
                        authController.forgetPasswordOtpVerify(
                          text1Controller.text,
                          text2Controller.text,
                          text3Controller.text,
                          text4Controller.text,
                          text5Controller.text,
                          text6Controller.text,
                        );
                      },
                    ),
                  ],
                ),
              ))
        ],
      )))),
    );
  }
}
