import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/routes/routes.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_enums.dart';
import '../utils/storage_config.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10),
        child: AppBar(backgroundColor: Colors.white, elevation: 0, automaticallyImplyLeading: false, flexibleSpace: Text("")),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
                  child: Column(
        children: [
          SizedBox(height: 35),
          Text(
            "Profile",
            style: GoogleFonts.poppins(fontSize: 18, color: Color.fromRGBO(0, 0, 0, 1), fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {
              Get.toNamed(Routes.PROFILE_SCREEN);
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                  width: double.infinity,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(204, 236, 255, 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.12),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 22.5),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Column(
                              children: [
                                Image.asset(
                                  'assets/dewd.png',
                                  width: 30,
                                  height: 30,
                                ),
                              ],
                            ),
                            SizedBox(width: 20),
                            Column(
                              children: [
                                Text(
                                  "My Profile",
                                  style:
                                      GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: Color.fromRGBO(15, 15, 20, 1)),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      "Edit Profile",
                                      style: GoogleFonts.poppins(
                                          fontSize: 13, fontWeight: FontWeight.w400, color: Color.fromRGBO(102, 102, 102, 1)),
                                    ),
                                    SizedBox(width: 8),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(Routes.SupportAndF_SCREEN);
              // Navigator.push(context, MaterialPageRoute(builder: (context) =>  SupportAndF()));
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                  width: double.infinity,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(204, 236, 255, 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.12),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Row(
                          children: [
                            SizedBox(width: 20),
                            Column(
                              children: [
                                Image.asset(
                                  'assets/vfv.png',
                                  width: 30,
                                  height: 30,
                                ),
                              ],
                            ),
                            SizedBox(width: 20),
                            Column(
                              children: [
                                Text(
                                  "Support & Feedback",
                                  style:
                                      GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: Color.fromRGBO(15, 15, 20, 1)),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      "Privacy Policy",
                                      style: GoogleFonts.poppins(
                                          fontSize: 13, fontWeight: FontWeight.w400, color: Color.fromRGBO(102, 102, 102, 1)),
                                    ),
                                    SizedBox(width: 74),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      "Contact Support/Report",
                                      style: GoogleFonts.poppins(
                                          fontSize: 13, fontWeight: FontWeight.w400, color: Color.fromRGBO(102, 102, 102, 1)),
                                    ),
                                    SizedBox(width: 5),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          InkWell(
            onTap: () {
              Get.toNamed(Routes.ABOUT_US_SCREEN);
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(204, 236, 255, 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.12),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Image.asset(
                          'assets/xsxcs.png',
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Rate Us",
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: Color.fromRGBO(15, 15, 20, 1)),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          InkWell(
            onTap: () {
              LocalStorage.removeValue(StorageKey.userid);
              Get.offNamed(Routes.LOGIN_SCREEN);
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(204, 236, 255, 1),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.12),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        Image.asset(
                          'assets/xsxcs.png',
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Logout",
                          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400, color: Color.fromRGBO(15, 15, 20, 1)),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      )))),
    );
  }
}
