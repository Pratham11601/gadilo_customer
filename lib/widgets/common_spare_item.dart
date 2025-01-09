import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../models/dasboard/spares_model.dart';
import '../utils/string_utils.dart';

Widget spareItem({required SparesList spares}) {
  return Stack(clipBehavior: Clip.none, children: [
    Container(
        height: 24.h,
        width: 45.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                spares.images![0],
                fit: BoxFit.fill,
                height: 17.h,
              ),
            ),
            Column(
              children: [
                Text(
                  "${spares.name}",
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: const Color.fromRGBO(15, 15, 20, 1)),
                ),
                Text(
                  "${formatPriceRange(spares.price!)}",
                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color.fromRGBO(15, 15, 20, 1)),
                ),
              ],
            )
          ],
        )),
    Positioned(
      top: -9,
      left: 60,
      child: Container(
        width: 52,
        height: 20,
        decoration: BoxDecoration(
          color: spares.spareVersion == "old" ? Colors.blue : Color.fromRGBO(126, 255, 131, 1),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 2.9),
              Text(
                "${spares.spareVersion}",
                style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w400, color: const Color.fromRGBO(0, 0, 0, 1)),
              ),
            ],
          ),
        ),
      ),
    ),
  ]);
}
