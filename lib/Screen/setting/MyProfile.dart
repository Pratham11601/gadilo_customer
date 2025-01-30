import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/controller/setting_controller.dart';
import 'package:gadi_customer_repo/utils/text_style.dart';
import 'package:gadi_customer_repo/widgets/common_textfield.dart';
import 'package:gadi_customer_repo/widgets/constant_widgets.dart';
import 'package:gadi_customer_repo/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utils/app_colors.dart';
import '../../widgets/back_common_button.dart';

class MyProfile extends StatelessWidget {
  MyProfile({super.key});

  SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          " My Profile ",
          style: TextHelper.size18(context).copyWith(
            color: ColorsForApp.tertiaryExtraLightColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: CommonBackButton(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 100.h,
          child: Stack(
            children: [
              Positioned(
                child: Container(
                  color: ColorsForApp.primaryColor,
                  width: 100.w,
                  height: 40.h,
                ),
              ),
              Positioned(
                top: 4.h,
                left: 5.w,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1, 1),
                          blurRadius: 4.0,
                          spreadRadius: 1.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: 90.w,
                    height: 78.h,
                    child: Stack(
                      children: [
                        Positioned(
                            top: 3.h,
                            left: 24.w,
                            child: ClipOval(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorsForApp.backGroundColor,
                                  shape: BoxShape.circle,
                                ),
                                width: 37.w,
                                height: 37.w,
                                child: Obx(() {
                                  return Image.network(
                                    "${settingController.profile_photo.value}",
                                    fit: BoxFit.fill,
                                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                      return Center(
                                        child: CupertinoActivityIndicator(
                                          radius: 20,
                                          color: ColorsForApp.primaryColor,
                                        ),
                                      );
                                    },
                                  );
                                }),
                              ),
                            )),
                        Positioned(
                          top: 16.h,
                          right: 30.w,
                          child: Container(
                            width: 4.h,
                            height: 4.h,
                            decoration: BoxDecoration(
                                color: ColorsForApp.backGroundColor,
                                border: Border.all(color: ColorsForApp.primaryColor),
                                borderRadius: BorderRadius.circular(27)),
                            child: InkWell(
                              onTap: () {
                                settingController.pickImage();
                              },
                              child: Icon(
                                Icons.mode_outlined,
                                color: ColorsForApp.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 21.h,
                          left: 2.w,
                          child: Container(
                            width: 89.w,
                            child: Column(
                              children: [
                                TextEditing("Name", settingController.name.value, context),
                                TextEditing("Phone", settingController.phone.value, context),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 55.h,
                          left: 2.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              height(11.h),
                              SizedBox(
                                width: 85.w,
                                child: CustomButton(
                                  label: "Save",
                                  onPressed: () {
                                    settingController.UpdateUseDetails();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

  Widget _addressContainer({
    required String addressText,
    required IconData iconData,
    void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue), // Blue border
          borderRadius: BorderRadius.circular(35), // Rounded corners
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content
          children: [
            Icon(
              iconData,
              color: Colors.blue, // Icon color
            ),
            SizedBox(width: 8), // Space between icon and text
            Text(
              addressText,
              style: TextStyle(
                color: Colors.black, // Text color
                fontSize: 16, // Text size
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget TextEditing(String title, TextEditingController contoller, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextHelper.size18(context).copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            SizedBox(
              height: 5.h,
              width: 83.w,
              child: CommonTextField(
                controller: contoller,
                hintText: "Enter your ${title}",
                keyboardType: TextInputType.text,
              ),
            ),
          ],
        ),
        height(4.h),
      ],
    );
  }
}
