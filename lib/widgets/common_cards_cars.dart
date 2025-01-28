import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/utils/string_utils.dart';
import 'package:gadi_customer_repo/widgets/constant_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../models/dasboard/cars_model.dart';

Widget buildCommonCarsCard(BuildContext context, {required CarsList cars}) {
  return Container(
    width: 63.w,
    margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade300,
          offset: Offset(0, 4),
          blurRadius: 1.0,
          spreadRadius: 1.0,
        ),
      ],
    ),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(
            "${cars.carImage![0]}",
            width: 96.w,
            height: 151,
            fit: BoxFit.cover,
            // Error handling
            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
              return Container(
                width: 96.w,
                height: 151,
                color: Colors.grey[300], // Placeholder background color
                child: Center(
                  child: Icon(
                    Icons.error,
                    size: 55,
                    color: Colors.red,
                  ),
                ),
              );
            },
          ),
        ),
        height(1.h),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              " ${capitalizeFirstLetter(cars.brand!)}",
              style: GoogleFonts.poppins(fontSize: 20.px, fontWeight: FontWeight.w500, color: const Color.fromRGBO(15, 15, 20, 1)),
            ),
            Text(
              "₹${cars.carPrice} ",
              style: GoogleFonts.poppins(fontSize: 14.px, fontWeight: FontWeight.w400, color: const Color.fromRGBO(15, 15, 20, 1)),
            ),
          ],
        )
      ],
    ),
  );
}
