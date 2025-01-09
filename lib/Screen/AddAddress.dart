import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../routes/routes.dart';
import '../widgets/custom_button.dart';

class AddAddress extends StatelessWidget {
  const AddAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
                  child: Column(
        children: [
          SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => Get.back(),
                child: Container(
                  width: 50,
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color.fromRGBO(15, 15, 20, 0.32),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(27),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/assa.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
              ),
              Text(
                "Add Address",
                style: GoogleFonts.poppins(fontSize: 18, color: Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 20),
            ],
          ),

          SizedBox(height: 100),

          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: 64,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(217, 217, 217, 1), width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 30, right: 5),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Add Address",
                          hintStyle:
                              GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Color.fromRGBO(146, 146, 146, 1)),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 16)),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 50.h),
          CustomButton(
            label: "Save",
            width: 85.w,
            onPressed: () {
              Get.toNamed(Routes.PROFILE_SCREEN);
            },
          ),

          // Padding(
          //   padding: const EdgeInsets.all(0),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => const  MyProfile()));
          //     },
          //     style: ElevatedButton.styleFrom(
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(30),
          //       ),
          //       minimumSize: Size(308,44),
          //       backgroundColor: Color.fromRGBO(10, 98, 148, 1),
          //       elevation: 0,
          //     ),
          //     child: Text(
          //       "Add",
          //       style: GoogleFonts.poppins(
          //           fontSize: 16,
          //           fontWeight: FontWeight.w500,
          //           color: Color.fromRGBO(251, 254, 255, 1)
          //       ),
          //     ),
          //   ),
          // ),
        ],
      )))),
    );
  }
}
