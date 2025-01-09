import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routes/routes.dart';

void showRegistrationDialog() {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: Get.width * 0.8, // Responsive width using GetX
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Text(
              'Registration Successful! 🎉',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Color.fromRGBO(15, 15, 20, 1),
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Start Your Journey and find\n'
              'your dream car today!',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 17),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(Routes.SELECT_CITY_SCREEN);
                  Get.back(); // Close the dialog using GetX
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  minimumSize: Size(150, 45),
                  backgroundColor: Color.fromRGBO(10, 98, 148, 1),
                  elevation: 0,
                ),
                child: Text(
                  "GOT IT !",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(251, 254, 255, 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
