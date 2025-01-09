import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../utils/string_utils.dart';
import 'constant_widgets.dart';

class CommonSpecifications extends StatelessWidget {
  final String? labelStyle;
  final String? imagePath;
  final String? value;

  const CommonSpecifications({super.key, this.labelStyle, this.imagePath, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      width: 32.w,
      height: 28.w,
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        border: Border.all(
          color: Color.fromRGBO(217, 217, 217, 1),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(children: [
          SizedBox(height: 11),
          Image.asset(
            "$imagePath",
            width: 4.h,
            height: 4.h,
          ),
          Text(
            "${labelStyle}",
            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: Color.fromRGBO(74, 74, 74, 1)),
          ),
          height(1.h),
          Text(
            "${capitalizeFirstLetter(value!)}",
            style: GoogleFonts.poppins(fontSize: 15.px, fontWeight: FontWeight.w500, color: Color.fromRGBO(15, 15, 20, 1)),
          ),
          height(1.h),
        ]),
      ),
    );
  }
}
