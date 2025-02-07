import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../utils/string_utils.dart';

class CommonSpecifications extends StatelessWidget {
  final String? labelStyle;
  final String? imagePath;
  final String? value;

  const CommonSpecifications({super.key, this.labelStyle, this.imagePath, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      width: 30.w,
      height: 30.w,
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
            width: 18.w,
            height: 13.w,
          ),
          Text(
            "${labelStyle}",
            style: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w400, color: Color.fromRGBO(74, 74, 74, 1)),
          ),
          Text(
            "${capitalizeFirstLetter(value!)}",
            style: GoogleFonts.poppins(fontSize: 14.px, fontWeight: FontWeight.w500, color: Color.fromRGBO(15, 15, 20, 1)),
          ),
        ]),
      ),
    );
  }
}
