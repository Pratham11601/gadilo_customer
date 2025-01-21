import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../utils/app_colors.dart';

Widget Common_text_field(
  TextEditingController controller,
  String hint,
  String validation,
  String? Function(String?)? validator,
) {
  return SizedBox(
    width: 84.w,
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Color.fromRGBO(6, 10, 14, 0.62)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(70),
          borderSide: BorderSide(color: ColorsForApp.primaryColor, width: 1.52),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(70),
          borderSide: BorderSide(color: Color.fromRGBO(155, 155, 155, 0.3), width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(70),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        errorStyle: GoogleFonts.poppins(
          fontSize: 15.sp,
          color: Colors.red,
        ),
      ),
      style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16.sp)),
      validator: validator,
    ),
  );
}
