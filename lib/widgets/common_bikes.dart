import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../Screen/dashboard/BikeDetails.dart';
import '../models/dasboard/bike_model.dart';

Widget buildBikeWidget(BuildContext context, {required BikeList bike}) {
  return SizedBox(
    height: 32.h,
    width: 43.w,
    child: InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => BikeDetails(bikes: bike)));
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 7),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
              child: Image.network(
                "${bike.bikeImage![0]}",
                height: 40.w,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 49.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${bike.brand} ${bike.model}  ",
                  style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w500, color: Color.fromRGBO(15, 15, 20, 1)),
                ),
                Center(
                  child: Text(
                    "₹${bike.bikePrice!}",
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(15, 15, 20, 1)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
