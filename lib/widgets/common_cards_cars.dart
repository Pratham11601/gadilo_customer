import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/utils/string_utils.dart';
import 'package:gadi_customer_repo/widgets/constant_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../models/dasboard/cars_model.dart';

Widget buildCommonCarsCard(BuildContext context, {required CarsList cars}) {
  return Container(
    width: 44.w,
    height: 25.h,
    margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
    padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.w),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(
            "${cars.carImage![0]}",
            width: 96.w,
            height: 19.h,
            fit: BoxFit.fill,
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
        height(3),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              " ${capitalizeFirstLetter(cars.brand!)}",
              style: GoogleFonts.poppins(fontSize: 22.px, fontWeight: FontWeight.w500, color: const Color.fromRGBO(15, 15, 20, 1)),
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
