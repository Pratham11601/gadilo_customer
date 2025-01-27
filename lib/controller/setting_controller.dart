import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/models/setting/status_string_response_model.dart';
import 'package:gadi_customer_repo/models/setting/user_details_model.dart';
import 'package:gadi_customer_repo/repository/setting_repositiory.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
    Map<String, dynamic> params = {
      'id': userId,
      'name': name.value.text,
      'address': address.value.text,
      'phone': phone.value.text,
    };
    debugPrint(params.toString());
    try {
      Get.back();

      userDetails userResponse = await SettingRepositiory.updateUserDetailsAPi(params: params);
      if (userResponse.status == "success") {
        name.value.text = userResponse.data!.name!;
        phone.value.text = userResponse.data!.phone!;
        address.value.text = userResponse.data!.address!;
        profile_photo.value = userResponse.data!.profilePhoto!;

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
    Map<String, dynamic> params = {'id': userId};
    debugPrint(params.toString());
    try {
      userDetails userResponse = await SettingRepositiory.getUserDeatils(params: params);
      if (userResponse.status == "success") {
        name.value.text = userResponse.data!.name!;
        phone.value.text = userResponse.data!.phone!; // Assuming phone exists
        address.value.text = userResponse.data!.address!;
        profile_photo.value = userResponse.data!.profilePhoto!;

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

  Future<StatusStringResponseModel?> changePasswordApiCall() async {
    Map<String, dynamic> params = {
      'user_id': userId,
      'current_password': currentPassword.value,
      'new_password': newPassword.value,
    };
    debugPrint(params.toString());
    try {
      StatusStringResponseModel supportApiresponse = await SettingRepositiory.changePasswordApi(params: params);
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
          CircularProgressIndicator(),
        ],
      )),
      barrierDismissible: false,
    );

    try {
      dio.FormData formData = dio.FormData.fromMap({
        'id': '1',
        'name': name.value.text,
        'address': address.value.text,
        'phone': phone.value.text,
        'profile_photo': await dio.MultipartFile.fromFile(imagePath),
      });

      dio.Response response = await _dio.post(
        'https://testingsites.in/Gadilo_api/update_profile1',
        data: formData,
        options: dio.Options(
          headers: {
            'Cookie': 'ci_session=7afod0o04bceoioindkjvi362pkv2ept',
          },
        ),
      );

      // Close the loader
      Get.back();

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
