import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/controller/auth_controller.dart';
import 'package:gadi_customer_repo/utils/app_colors.dart';
import 'package:gadi_customer_repo/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
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
  FocusNode otpFocusNode = FocusNode();
  final TextEditingController text1Controller = TextEditingController();
  final TextEditingController text2Controller = TextEditingController();
  final TextEditingController text3Controller = TextEditingController();
  final TextEditingController text4Controller = TextEditingController();
  final TextEditingController text5Controller = TextEditingController();
  final TextEditingController text6Controller = TextEditingController();

  final TextEditingController otp = TextEditingController();
  int _start = 15;
  bool _isClickable = false;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    setState(() {
      _isClickable = false;
    });
    _start = 12;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        timer.cancel();
        setState(() {
          _isClickable = true; // Enable clicking after timer ends
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
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
      body: Center(
          child: Column(
        children: [
          Image.asset(
            "assets/otpround.png",
            width: 100.w,
            fit: BoxFit.fill,
            height: 20.h,
          ),
          SizedBox(height: 20),
          Text(
            "Verify It’s You",
            style: GoogleFonts.poppins(fontSize: 22, color: Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 4.h),
          Text(
            " OTP has sent to your registered\n"
            "mobile number XXXXXX${authController.phone.value.text.substring(authController.phone.value.text.length - 4)}, we\n"
            "  are auto fetching, please wait.",
            style: GoogleFonts.poppins(fontSize: 16, color: Color.fromRGBO(59, 56, 68, 1), fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 40),
          PinCodeTextField(
            autofocus: true,
            controller: otp,
            highlightColor: ColorsForApp.primaryColor,
            defaultBorderColor: Colors.grey,
            highlightPinBoxColor: Colors.transparent,
            maxLength: 6,
            onTextChanged: (text) {},
            onDone: (text) {
              authController.verifyOTPApiCall(otp.text);
            },
            pinBoxWidth: 50,
            pinBoxHeight: 64,
            wrapAlignment: WrapAlignment.spaceAround,
            pinTextStyle: TextStyle(fontSize: 18.0),
            pinTextAnimatedSwitcherTransition: ProvidedPinBoxTextAnimation.scalingTransition,
            pinTextAnimatedSwitcherDuration: Duration(milliseconds: 300),
            highlightAnimationBeginColor: Colors.black,
            highlightAnimationEndColor: Colors.white12,
            keyboardType: TextInputType.number,
          ),
          height(17.h),
          CustomButton(
            width: 85.w,
            label: "Verify OTP",
            onPressed: () {
              authController.verifyOTPApiCall(otp.text);
            },
          ),
          SizedBox(height: 20),
          RichText(
            text: TextSpan(
              text: _isClickable ? " " : 'Resend OTP in ',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color.fromRGBO(9, 8, 24, 1),
                fontWeight: FontWeight.w400,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: _isClickable ? 'Resend OTP' : '  ${_start.toString().padLeft(2, '0')}:00 Sec',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: _isClickable
                        ? ColorsForApp.primaryColor // Blue when clickable
                        : const Color.fromRGBO(9, 8, 24, 1), // Default color
                    fontWeight: FontWeight.w400,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = _isClickable
                        ? () {
                            startTimer();
                            authController.sendOTPApiCall();
                          }
                        : null, // Only allow tap when clickable
                ),
              ],
            ),
          ),
          Spacer(),
          RotatedBox(
            quarterTurns: 90,
            child: Image.asset(
              "assets/otpround.png",
              fit: BoxFit.fill,
              width: 100.w,
              height: 16.h,
            ),
          ),
        ],
      )),
    );
  }
}
