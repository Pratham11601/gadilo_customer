import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/models/app/status_message_common_model.dart';
import 'package:gadi_customer_repo/models/auth/get_city_model.dart';
import 'package:gadi_customer_repo/routes/routes.dart';
import 'package:gadi_customer_repo/utils/app_enums.dart';
import 'package:gadi_customer_repo/utils/dialog_box.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/auth/login_user_model.dart';
import '../models/auth/register_user_model.dart';
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
  Rx<TextEditingController> confirmPassword = TextEditingController().obs;
  RxList<PrivacyPolicy> privacyPolicyList = <PrivacyPolicy>[].obs;

  RxString id = ''.obs;
  RxString phoneError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadToken();
    getCityApiCall();
    privacyPolicy();
  }

  Future<void> loadToken() async {
    id.value = await LocalStorage.fetchValue(StorageKey.userid) ?? '';

    debugPrint("User Id is --------->  ${id.value} ");
  }

  Future<PrivacyPolicyModel?> privacyPolicy() async {
    try {
      PrivacyPolicyModel privacyPolicyApiresponse = await SettingRepositiory.privacyPolicyApi();
      if (privacyPolicyApiresponse.status == true) {
        privacyPolicyList.value = privacyPolicyApiresponse.cities;
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

  Future<SendOtpModel?> sendOTPApiCall() async {
    Map<String, dynamic> params = {
      'mobile': phone.value.text,
    };

    try {
      SendOtpModel newUserRegister = await AuthRepository.sendOTPApi(params: params);
      if (newUserRegister.status == true) {
        Get.snackbar(
          "OTP ${newUserRegister.otp} ",
          'Only for testing it will get remove ',
          backgroundColor: ColorsForApp.secondaryColor,
        );

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

  Future<SendOtpModel?> resetPasswordOTPApi() async {
    Map<String, dynamic> params = {
      'mobile': phone.value.text,
    };

    try {
      SendOtpModel newUserRegister = await AuthRepository.sendOTPApi(params: params);
      if (newUserRegister.status == true) {
        Get.snackbar(
          "OTP ${newUserRegister.otp} ",
          'Only for testing it will get remove ',
          backgroundColor: ColorsForApp.secondaryColor,
        );

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

  Future<StatusMessageCommonModel?> verifyOTPApiCall(String one, String two, String three, String four, String five, String six) async {
    Map<String, dynamic> params = {
      'mobile': phone.value.text,
      'otp': "${one}${two}${three}${four}${five}${six} ",
    };
    debugPrint(params.toString());

    Get.toNamed(Routes.CREATE_PASSWORD_SCREEN);

    try {
      StatusMessageCommonModel verifyOtpResponse = await AuthRepository.verifyOTPApi(params: params);
      if (verifyOtpResponse.status == true) {
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

  Future<StatusMessageCommonModel?> passwordAPi() async {
    Map<String, dynamic> params = {
      'mobile': phone.value.text,
      'password': password.value.text.toString(),
      'confirm_password': confirmPassword.value.text.toString(),
    };
    debugPrint(params.toString());

    try {
      StatusMessageCommonModel verifyOtpResponse = await AuthRepository.resetPasswordAPi(params: params);
      if (verifyOtpResponse.status == true) {
        Get.snackbar(
          verifyOtpResponse.message.toString(),
          '',
          backgroundColor: ColorsForApp.secondaryColor,
        );

        showRegistrationDialog();

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

  Future<LoginUserModel?> loginUser() async {
    Map<String, dynamic> params = {
      'mobile': phone.value.text,
      'password': password.value.text,
    };

    debugPrint(params.toString());
    try {
      LoginUserModel loginUser = await AuthRepository.loginApi(params: params);
      if (loginUser.status == true) {
        LocalStorage.storeValue(StorageKey.token, loginUser.token);
        LocalStorage.storeValue(StorageKey.userid, loginUser.user!.id ?? "");
        Get.toNamed(Routes.SELECT_CITY_SCREEN);
        return loginUser;
      } else {
        Get.snackbar(
          loginUser.message.toString(),
          'Login Failed',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorsForApp.alertColor.withOpacity(0.75),
        );
      }
    } catch (e) {
      debugPrint("Error in Login-- ${e..toString}");
    }
    return null;
  }

  Future<RegisterUserModel?> createPasswordAndRegisterUser() async {
    Map<String, dynamic> params = {
      'mobile': phone.value.text,
      'password': password.value.text,
      'confirm_password': confirmPassword.value.text,
    };

    debugPrint(params.toString());
    try {
      RegisterUserModel userDetails = await AuthRepository.createPasswordandRegisterAPI(params: params);
      if (userDetails.status == true) {
        LocalStorage.storeValue(StorageKey.userid, userDetails.userId ?? null);
        Get.toNamed(Routes.SELECT_CITY_SCREEN);
        return userDetails;
      } else {
        Get.snackbar(
          userDetails.message.toString(),
          'Login Failed',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: ColorsForApp.alertColor.withOpacity(0.75),
        );
      }
    } catch (e) {
      debugPrint("Error in Login-- ${e..toString}");
    }
    return null;
  }

  Future<SendOtpModel?> forgetPasswordSendOtpAPiCall() async {
    Map<String, dynamic> params = {
      'mobile': phone.value.text,
    };

    try {
      SendOtpModel newUserRegister = await AuthRepository.resetPasswordSendOTPApi(params: params);
      if (newUserRegister.status == true) {
        Get.snackbar(
          "OTP ${newUserRegister.otp} ",
          'Only for testing it will get remove ',
          backgroundColor: ColorsForApp.secondaryColor,
        );

        Get.toNamed(Routes.VERIFY_MOB_SCREEN);

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
