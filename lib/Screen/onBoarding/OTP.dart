import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gadi_customer_repo/controller/auth_controller.dart';
import 'package:gadi_customer_repo/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/constant_widgets.dart';

class OTP extends StatefulWidget {
  OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  final AuthController authController = Get.find();

  final TextEditingController textEditingController = TextEditingController();
  List<FocusNode> focusNodes = List.generate(5, (_) => FocusNode());

  final TextEditingController text1Controller = TextEditingController();
  final TextEditingController text2Controller = TextEditingController();
  final TextEditingController text3Controller = TextEditingController();
  final TextEditingController text4Controller = TextEditingController();
  final TextEditingController text5Controller = TextEditingController();
  final TextEditingController text6Controller = TextEditingController();

  int _start = 45; // Countdown starts from 30 seconds
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer(); // Start the timer when the widget is initialized
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        _timer?.cancel(); // Stop the timer when it reaches 0
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

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
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(215),
        child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: Center(
              child: Image.asset(
                'assets/uhuyhui.png',
                width: double.infinity,
                height: 300,
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
            "Verify It’s You",
            style: GoogleFonts.poppins(fontSize: 22, color: Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 20),
          Text(
            " OTP has sent to your registered\n"
            "mobile number XXXXXXXX09, we\n"
            "  are auto fetching, please wait.",
            style: GoogleFonts.poppins(fontSize: 16, color: Color.fromRGBO(59, 56, 68, 1), fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 40),
          Row(
            children: [
              width(3.w),
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
                    controller: text6Controller,
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
            ],
          ),
          height(17.h),
          CustomButton(
            width: 85.w,
            label: "Verify OTP",
            onPressed: () {
              authController.verifyOTPApiCall(
                text1Controller.text,
                text2Controller.text,
                text3Controller.text,
                text4Controller.text,
                text5Controller.text,
                text6Controller.text,
              );
            },
          ),
          SizedBox(height: 20),
          RichText(
            text: TextSpan(
              text: 'Resend OTP in',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Color.fromRGBO(9, 8, 24, 1),
                fontWeight: FontWeight.w400,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '  ${_start.toString().padLeft(2, '0')}:00 Sec',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Color.fromRGBO(12, 121, 222, 1),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          )
        ],
      )))),
    );
  }
}
