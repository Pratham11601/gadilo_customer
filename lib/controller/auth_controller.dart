import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/models/app/status_message_common_model.dart';
import 'package:gadi_customer_repo/routes/routes.dart';
import 'package:gadi_customer_repo/utils/app_enums.dart';
import 'package:gadi_customer_repo/widgets/snack_abar.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/auth/sedn_otp_model.dart';
import '../models/setting/privacy_policy_model.dart';
import '../models/setting/user_details_model.dart';
import '../repository/auth_repository.dart';
import '../repository/setting_repositiory.dart';
import '../utils/app_colors.dart';
import '../utils/storage_config.dart';

class AuthController extends GetxController {
  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> emailId = TextEditingController().obs;
  Rx<TextEditingController> phone = TextEditingController().obs;
  Rx<TextEditingController> shopName = TextEditingController().obs;
  Rx<TextEditingController> shopAddress = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> longitude = TextEditingController().obs;
  Rx<TextEditingController> latitude = TextEditingController().obs;
  Rx<TextEditingController> otp = TextEditingController().obs;
  RxList<PrivacyPolicy> privacyPolicyList = <PrivacyPolicy>[].obs;
  RxList<TermsList> terms = <TermsList>[].obs;

  RxString id = ''.obs;
  RxString phoneError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    privacyPolicy();
    termsAndCondn();
    loadToken();
  }

  var isChecked = false.obs;

  void toggleCheckbox() {
    isChecked.value = !isChecked.value;
  }

  Future<void> loadToken() async {
    id.value = await LocalStorage.fetchValue(StorageKey.userid) ?? '';

    debugPrint("User Id is --------->  ${id.value} ");
  }

  Future<PrivacyPolicyModel?> privacyPolicy() async {
    try {
      PrivacyPolicyModel privacyPolicyApiresponse = await SettingRepositiory.privacyPolicyApi();
      if (privacyPolicyApiresponse.status == true) {
        privacyPolicyList.value = privacyPolicyApiresponse.privacyPolicy!;
        return privacyPolicyApiresponse;
      } else {
        Get.snackbar(
          'Failed',
          "something went wrong",
          backgroundColor: ColorsForApp.alertColor,
        );
      }
    } catch (e) {
      debugPrint("Error in Contact ${e..toString}");
    }
    return null;
  }

  Future<termsModel?> termsAndCondn() async {
    try {
      termsModel privacyPolicyApiresponse = await SettingRepositiory.termsCondnApi();
      if (privacyPolicyApiresponse.status == true) {
        terms.value = privacyPolicyApiresponse.data!;
        return privacyPolicyApiresponse;
      } else {
        Get.snackbar(
          'Failed',
          "something went wrong",
          backgroundColor: ColorsForApp.alertColor,
        );
      }
    } catch (e) {
      debugPrint("Error in Contact ${e..toString}");
    }
    return null;
  }

  String? ids; // Declare as nullable

  Future<userDetails?> UpdateUseDetails() async {
    Map<String, dynamic> params = {'id': id.value, 'name': name.value.text};
    debugPrint(params.toString());
    try {
      Get.back();

      userDetails userResponse = await SettingRepositiory.updateUserDetailsAPi(params: params);
      if (userResponse.status == "success") {
        name.value.text = userResponse.data!.username!;

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

  Future<SendOtpModel?> sendOTPApiCall() async {
    Get.toNamed(Routes.OTP_SCREEN);
    showToast("Sending OTP Request ");

    Map<String, dynamic> params = {
      'mobile_number': phone.value.text,
    };

    try {
      SendOtpModel newUserRegister = await AuthRepository.sendOTPApi(params: params);
      if (newUserRegister.success == "true") {
        showToast(newUserRegister.message.toString());

        if (newUserRegister.id != null && newUserRegister.id!.isNotEmpty) {
          ids = newUserRegister.id;
        }

        return newUserRegister;
      } else {
        Get.snackbar(newUserRegister.message.toString(), 'Please Contact Support',
            icon: Icon(
              Icons.warning_amber,
              color: Colors.white,
              size: 41,
            ),
            colorText: Colors.white,
            backgroundColor: ColorsForApp.alertColor,
            duration: Duration(seconds: 7));
        debugPrint("Error in Dealer register");
      }
    } catch (e) {
      debugPrint("Error in Dealer register ${e..toString}");
    }
    return null;
  }

  Future<StatusMessageCommonModel?> verifyOTPApiCall(String otp) async {
    showToast("Please wait while Verifing OTP..");
    Map<String, dynamic> params = {
      'dealer_id': ids,
      'otp': "$otp",
    };
    debugPrint(params.toString());

    try {
      StatusMessageCommonModel verifyOtpResponse = await AuthRepository.verifyOTPApi(params: params);
      if (verifyOtpResponse.status == true) {
        showToast("OTP verification Success");

        LocalStorage.storeValue(StorageKey.userid, verifyOtpResponse.user_id.toString());

        Get.offAllNamed(Routes.SELECT_CITY_SCREEN);

        return verifyOtpResponse;
      } else {
        showToast("OTP verification Failed");

        debugPrint("Error in Verify OTP");
      }
    } catch (e) {
      debugPrint("Error in Verify OTP ${e..toString}");
    }
    return null;
  }
}
