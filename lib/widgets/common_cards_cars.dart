import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../models/dasboard/cars_model.dart';
import '../utils/string_utils.dart';

Widget buildCommonCarsCard(BuildContext context, {required CarsList cars}) {
  return Container(
    width: 54.w,
    height: 24.h,
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
                  child: Text("NO Image Avalable"),
                ),
              );
            },
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Text(
                " ${capitalizeFirstLetter(cars.brand!)} ",
                style: GoogleFonts.poppins(fontSize: 17.px, fontWeight: FontWeight.w500, color: const Color.fromRGBO(15, 15, 20, 1)),
              ),
            ),
            Text(
              "₹${cars.carPrice}/-",
              style: GoogleFonts.poppins(fontSize: 12.px, fontWeight: FontWeight.w400, color: const Color.fromRGBO(15, 15, 20, 1)),
            ),
          ],
        )
      ],
    ),
  );
}
