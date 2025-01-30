import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/models/app/status_message_common_model.dart';
import 'package:gadi_customer_repo/models/auth/get_city_model.dart';
import 'package:gadi_customer_repo/routes/routes.dart';
import 'package:gadi_customer_repo/utils/app_enums.dart';
import 'package:gadi_customer_repo/widgets/snack_abar.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/auth/sedn_otp_model.dart';
import '../models/setting/privacy_policy_model.dart';
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

  RxString id = ''.obs;
  RxString phoneError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    privacyPolicy();

    loadToken();
    getCityApiCall();
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

  String? ids; // Declare as nullable

  Future<SendOtpModel?> sendOTPApiCall() async {
    Map<String, dynamic> params = {
      'mobile_number': phone.value.text,
    };

    if (isChecked.value == false) {
      showToast("Accept terms and Conditions to Login");
      return null;
    }

    try {
      SendOtpModel newUserRegister = await AuthRepository.sendOTPApi(params: params);
      if (newUserRegister.success == "true") {
        showToast(newUserRegister.message.toString());

        if (newUserRegister.id != null && newUserRegister.id!.isNotEmpty) {
          ids = newUserRegister.id; // This is now valid
        }

        Get.toNamed(Routes.OTP_SCREEN);

        return newUserRegister;
      } else {
        Get.snackbar(
          'Registration Failed',
          newUserRegister.message.toString(),
          backgroundColor: ColorsForApp.alertColor,
        );
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

  Future<GetCityModel?> getCityApiCall() async {
    try {
      GetCityModel getCityResponse = await AuthRepository.getCityAPi();
      if (getCityResponse.status == true) {
        return getCityResponse;
      } else {
        debugPrint("Error in getCityApiCall");
      }
    } catch (e) {
      debugPrint("Error in getCityApiCall ${e..toString}");
    }
    return null;
  }

  Future<GetCityModel?> addCityApiCall() async {
    try {
      GetCityModel getCityResponse = await AuthRepository.getCityAPi();
      if (getCityResponse.status == true) {
        return getCityResponse;
      } else {
        debugPrint("Error in getCityApiCall");
      }
    } catch (e) {
      debugPrint("Error in getCityApiCall ${e..toString}");
    }
    return null;
  }

  Future<StatusMessageCommonModel?> forgetPasswordOtpVerify(
      String one, String two, String three, String four, String five, String six) async {
    Map<String, dynamic> params = {
      'mobile': phone.value.text,
      'otp': "${one}${two}${three}${four}${five}${six} ",
    };
    debugPrint(params.toString());

    try {
      StatusMessageCommonModel verifyOtpResponse = await AuthRepository.verifyOTPApi(params: params);
      if (verifyOtpResponse.status == true) {
        Get.toNamed(Routes.SET_NEW_PASSWORD_SCREEN);

        Get.snackbar(
          verifyOtpResponse.message.toString(),
          '',
          backgroundColor: ColorsForApp.secondaryColor,
        );
        return verifyOtpResponse;
      } else {
        Get.snackbar(
          'Failed',
          verifyOtpResponse.message.toString(),
          backgroundColor: ColorsForApp.alertColor,
        );
        debugPrint("Error in Verify OTP");
      }
    } catch (e) {
      debugPrint("Error in Verify OTP ${e..toString}");
    }
    return null;
  }
}
