import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/models/setting/status_string_response_model.dart';
import 'package:gadi_customer_repo/models/setting/user_details_model.dart';
import 'package:gadi_customer_repo/repository/setting_repositiory.dart';
import 'package:gadi_customer_repo/widgets/constant_widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../utils/app_colors.dart';
import '../utils/app_enums.dart';
import '../utils/storage_config.dart';

class SettingController extends GetxController {
  Rx<TextEditingController> message = TextEditingController().obs;

  Rx<TextEditingController> currentPassword = TextEditingController().obs;
  Rx<TextEditingController> newPassword = TextEditingController().obs;
  Rx<TextEditingController> confirmnewPassword = TextEditingController().obs;

  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> phone = TextEditingController().obs;
  Rx<TextEditingController> address = TextEditingController().obs;

  dynamic userId;
  RxString profile_photo = ''.obs;
  final ImagePicker _picker = ImagePicker();
  final dio.Dio _dio = dio.Dio();
  @override
  void onInit() async {
    super.onInit();
    userId = await LocalStorage.fetchValue(StorageKey.userid);
    getUserDetails();
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery, // Change to ImageSource.camera for camera
    );

    if (image != null) {
      await uploadImage(image.path);
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }

  Future<userDetails?> UpdateUseDetails() async {
    Map<String, dynamic> params = {'id': userId, 'name': name.value.text};
    debugPrint(params.toString());
    try {
      Get.back();

      userDetails userResponse = await SettingRepositiory.updateUserDetailsAPi(params: params);
      if (userResponse.status == "success") {
        name.value.text = userResponse.data!.username!;
        phone.value.text = userResponse.data!.mobileNumber!;
        profile_photo.value = userResponse.data!.profile!;

        debugPrint("${profile_photo.value}");

        return userResponse;
      } else {
        Get.snackbar(
          'Failed',
          userResponse.status.toString(),
          backgroundColor: ColorsForApp.alertColor,
        );
      }
    } catch (e) {
      debugPrint("Error in Contact ${e..toString}");
    }
    return null;
  }

  Future<userDetails?> getUserDetails() async {
    try {
      userDetails userResponse = await SettingRepositiory.getUserDeatils(id: userId);
      if (userResponse.status == "success") {
        name.value.text = userResponse.data!.username!;
        phone.value.text = userResponse.data!.mobileNumber!; // Assuming phone exists
        profile_photo.value = userResponse.data!.profile!;

        debugPrint("${profile_photo.value}");

        return userResponse;
      } else {
        Get.snackbar(
          'Customer Details APi Failed',
          userResponse.status.toString(),
          backgroundColor: ColorsForApp.alertColor,
        );
      }
    } catch (e) {
      debugPrint("Error in Contact ${e..toString}");
    }
    return null;
  }

  Future<StatusStringResponseModel?> supportApiCall() async {
    Map<String, dynamic> params = {
      'user_id': userId,
      'message': message.value.text.toString(),
    };
    debugPrint(params.toString());

    try {
      StatusStringResponseModel supportApiresponse = await SettingRepositiory.contactSupportApi(params: params);
      if (supportApiresponse.status == "success") {
        Get.back();
        Get.snackbar(
          supportApiresponse.message.toString(),
          '',
          backgroundColor: ColorsForApp.secondaryColor.withOpacity(0.7),
        );

        return supportApiresponse;
      } else {
        Get.snackbar(
          'Failed',
          supportApiresponse.message.toString(),
          backgroundColor: ColorsForApp.alertColor,
        );
      }
    } catch (e) {
      debugPrint("Error in Contact ${e..toString}");
    }
    return null;
  }

  Future<StatusStringResponseModel?> FeedbackApiCall() async {
    Map<String, dynamic> params = {
      'user_id': userId,
      'feedback': message.value.text.toString(),
    };
    debugPrint(params.toString());
    try {
      StatusStringResponseModel supportApiresponse = await SettingRepositiory.FeedbackApi(params: params);
      if (supportApiresponse.status == "success") {
        Get.snackbar(
          supportApiresponse.message.toString(),
          '',
          backgroundColor: ColorsForApp.secondaryColor.withOpacity(0.7),
        );

        return supportApiresponse;
      } else {
        Get.snackbar(
          'Failed',
          supportApiresponse.message.toString(),
          backgroundColor: ColorsForApp.alertColor,
        );
      }
    } catch (e) {
      debugPrint("Error in Contact ${e..toString}");
    }
    return null;
  }

  Future<StatusStringResponseModel?> RateUsApiCall(String rating) async {
    Map<String, dynamic> params = {
      'user_id': userId,
      'rating': rating,
    };
    debugPrint(params.toString());
    try {
      StatusStringResponseModel supportApiresponse = await SettingRepositiory.ratingApi(params: params);
      if (supportApiresponse.status == "success") {
        Get.snackbar(
          supportApiresponse.message.toString(),
          '',
          backgroundColor: ColorsForApp.secondaryColor,
        );

        return supportApiresponse;
      } else {
        Get.snackbar(
          'Failed',
          supportApiresponse.message.toString(),
          backgroundColor: ColorsForApp.alertColor,
        );
      }
    } catch (e) {
      debugPrint("Error in Contact ${e..toString}");
    }
    return null;
  }

  // final dio.Dio _dio = dio.Dio();
  Future<void> uploadImage(String imagePath) async {
    // Show loader
    Get.dialog(
      Center(
          child: Column(
        children: [
          height(42.h),
          CircularProgressIndicator(),
        ],
      )),
      barrierDismissible: false,
    );

    try {
      dio.FormData formData = dio.FormData.fromMap({
        'id': userId,
        'name': name.value.text,
        'profile': await dio.MultipartFile.fromFile(imagePath),
      });

      dio.Response response = await _dio.post('https://testingsites.in/Gadilo_api/update_user_profile', data: formData);

      // Close the loader
      Get.back();

      debugPrint(response.toString());

      if (response.statusCode == 200) {
        getUserDetails();
        Get.snackbar('Success', 'Image uploaded successfully');
      } else {
        Get.snackbar('Error', 'Failed to upload image: ${response.statusCode}');
      }
    } catch (e) {
      // Close the loader
      Get.back();

      Get.snackbar('Error', 'Error occurred while uploading image: $e');
    }
  }
}
