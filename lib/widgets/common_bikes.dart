import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../Screen/dashboard/BikeDetails.dart';
import '../models/dasboard/bike_model.dart';
import '../utils/string_utils.dart';

Widget buildBikeWidget(BuildContext context, {required BikeList bike}) {
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => BikeDetails(bikes: bike)));
    },
    child: Column(
      children: [
        Image(
          image: NetworkImage(
            "${bike.carImage![0] ?? ""}",
          ),
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        SizedBox(
          width: 49.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${bike.brand} ${bike.brand}  ",
                style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w500, color: Color.fromRGBO(15, 15, 20, 1)),
              ),
              Center(
                child: Text(
                  "${formatPriceRange(bike.carPrice!)}",
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(15, 15, 20, 1)),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
