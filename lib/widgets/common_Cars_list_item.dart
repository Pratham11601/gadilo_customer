import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../models/dasboard/cars_model.dart';

Widget buildRideCardWidget(BuildContext context, {required CarsList cars}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 1.w, vertical: 2.w),
    padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.w),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.grey,
        width: 0.5,
      ),
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0, 2),
          blurRadius: 4.0,
          spreadRadius: 1.0,
        ),
      ],
    ),
    child: Column(
      children: [
        Image(
          image: NetworkImage(
            "${cars.carImage![0]}",
          ),
          width: double.infinity,
          height: 151,
          fit: BoxFit.fill,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${cars.brand}",
              style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w500, color: Color.fromRGBO(15, 15, 20, 1)),
            ),
            Text(
              "Rs:-${cars.carPrice}",
              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(15, 15, 20, 1)),
            ),
          ],
        )
      ],
    ),
  );
}
