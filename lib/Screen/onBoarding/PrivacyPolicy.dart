import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/controller/auth_controller.dart';
import 'package:gadi_customer_repo/widgets/back_common_button.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../utils/text_style.dart';
import '../../widgets/constant_widgets.dart';

class PrivacyPolicy extends StatelessWidget {
  PrivacyPolicy({super.key});

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
          SizedBox(height: 4),
          Row(
            children: [SizedBox(width: 20), CommonBackButton()],
          ),
          SizedBox(height: 12),
          Text(
            "Privacy & Security",
            style: GoogleFonts.poppins(fontSize: 18, color: Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 15),
              Text(
                "Privacy Policy",
                style: GoogleFonts.poppins(fontSize: 16, color: Color.fromRGBO(15, 15, 20, 1), fontWeight: FontWeight.w400),
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
                  if (authController.privacyPolicyList.isEmpty) {
                    return Column(
                      children: [
                        height(12.h),
                        Text(
                          'NO Privacys fetch Try again',
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
                      itemCount: authController.privacyPolicyList.length,
                      itemBuilder: (context, index) {
                        var privacyPolicy = authController.privacyPolicyList[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            privacyPolicy.policyText.toString(),
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
