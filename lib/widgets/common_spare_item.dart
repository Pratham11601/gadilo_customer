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
                spares.photo![0],
                fit: BoxFit.fill,
                height: 15.h,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 14.h, // Match the height of the original image
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400, // Placeholder color
                      borderRadius: BorderRadius.circular(10.0), // Match the border radius
                    ),
                    child: Center(
                      child: Text(
                        'Image not available',
                        style: TextStyle(color: Colors.white, fontSize: 15), // Placeholder text color
                      ),
                    ),
                  );
                },
              ),
            ),
            Column(
              children: [
                Text(
                  "${spares.model}",
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
      left: 14.5.w,
      child: Container(
        width: 55,
        height: 21,
        decoration: BoxDecoration(
          color: spares.type == "old" ? Colors.blue : Colors.green,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Center(
          child: Column(
            children: [
              Text(
                capitalizeFirstLetter(spares.type!),
                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.bold, color: const Color.fromRGBO(0, 0, 0, 1)),
              ),
            ],
          ),
        ),
      ),
    ),
  ]);
}
