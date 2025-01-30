import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/controller/setting_controller.dart';
import 'package:gadi_customer_repo/widgets/constant_widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/back_common_button.dart';

class SupportAndF extends StatelessWidget {
  SupportAndF({super.key});

  final SettingController settingController = Get.find();
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
          SizedBox(height: 4),
          Row(
            children: [
              SizedBox(width: 5),
              CommonBackButton(),
              width(12.w),
              Text(
                "Support & Feedback",
                style: GoogleFonts.poppins(fontSize: 18, color: Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 12),
          SizedBox(height: 21),
          Row(
            children: [
              SizedBox(width: 15),
              Text(
                "Contact Support/Report",
                style: GoogleFonts.poppins(fontSize: 16, color: Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              SizedBox(width: 15),
              Text(
                "Report an issue regarding fake information or anything ",
                style: GoogleFonts.poppins(fontSize: 12.5, color: Color.fromRGBO(15, 15, 20, 0.7), fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: 3),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
                width: double.infinity,
                height: 123,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(242, 242, 242, 1),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(91, 91, 91, 0.1),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 00, right: 5),
                              child: TextField(
                                controller: settingController.message.value,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  hintText: "I have an issue regarding..",
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: 12, fontWeight: FontWeight.w400, color: Color.fromRGBO(15, 15, 20, 0.6)),
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                ),
                                style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 16)),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          ),
          SizedBox(height: 120),
          Padding(
            padding: const EdgeInsets.all(0),
            child: ElevatedButton(
              onPressed: () async {
                await settingController.supportApiCall();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(308, 44),
                backgroundColor: Color.fromRGBO(10, 98, 148, 1),
                elevation: 0,
              ),
              child: Text(
                "Report",
                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Color.fromRGBO(251, 254, 255, 1)),
              ),
            ),
          ),
        ],
      )))),
    );
  }
}
