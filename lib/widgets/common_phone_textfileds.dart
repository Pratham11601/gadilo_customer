import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../utils/app_colors.dart';

Widget buildPhoneNumberField(
  TextEditingController controller,
  String hint,
) {
  return SizedBox(
    width: 84.w,
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        counterText: "",
        prefixIcon: SizedBox(
          width: 16.5.w,
          child: Row(
            children: [
              const SizedBox(width: 9),
              Image.asset(
                "assets/drd.png",
                width: 21,
                height: 21,
              ),
              const SizedBox(width: 3),
              Text(
                "+91",
                style: GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Color.fromRGBO(15, 15, 20, 1)),
              ),
            ],
          ),
        ),
        hintText: hint,
        hintStyle: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color.fromRGBO(6, 10, 14, 0.62)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: ColorsForApp.primaryColor, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Color.fromRGBO(155, 155, 155, 0.3), width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        errorStyle: GoogleFonts.poppins(
          fontSize: 15.sp,
          color: Colors.red,
        ),
      ),
      maxLength: 10,
      style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16.sp)),
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your mobile number';
        }
        if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
          return 'Please enter a valid 10-digit mobile number';
        }
        return null;
      },
    ),
  );
}
