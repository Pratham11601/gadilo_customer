import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/widgets/back_common_button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../controller/auth_controller.dart';
import '../../utils/text_style.dart';
import '../../widgets/constant_widgets.dart';

class Terms_ofUser extends StatelessWidget {
  Terms_ofUser({super.key});
  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10),
        child: AppBar(backgroundColor: Colors.white, elevation: 0, automaticallyImplyLeading: false, flexibleSpace: Text("")),
      ),
      body: SafeArea(
          child: Center(
              child: Column(
        children: [
          Row(
            children: [
              CommonBackButton(),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 15),
              Text(
                "Terms of use",
                style: GoogleFonts.poppins(fontSize: 19, color: Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              SizedBox(width: 15),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              SizedBox(width: 15),
              SizedBox(
                height: 70.h,
                width: 80.w,
                child: Obx(() {
                  if (authController.terms.isEmpty) {
                    return Column(
                      children: [
                        height(12.h),
                        Text(
                          'empty Data ',
                          style: TextHelper.size16(context).copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: authController.terms.length,
                      itemBuilder: (context, index) {
                        var privacyPolicy = authController.terms[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            privacyPolicy.content.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 12.5,
                              color: Color.fromRGBO(79, 79, 79, 1),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ],
      ))),
    );
  }
}
