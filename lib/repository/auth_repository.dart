import 'package:flutter/foundation.dart';
import 'package:gadi_customer_repo/models/app/status_message_common_model.dart';
import 'package:gadi_customer_repo/models/auth/get_city_model.dart';

import '../api/api_manager.dart';
import '../models/auth/login_user_model.dart';
import '../models/auth/register_user_model.dart';
import '../models/auth/sedn_otp_model.dart';

class AuthRepository {
  AuthRepository._();
  static APIManager apiManager = APIManager();

  static Future<SendOtpModel> sendOTPApi({required dynamic params, bool showLoading = true}) async {
    try {
      var response = await apiManager.postFormAPICall(
        url: '/send_otpauth_user',
        params: params,
        showLoading: showLoading,
      );
      SendOtpModel sendOtpModel = SendOtpModel.fromJson(response);
      return sendOtpModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<SendOtpModel> resetPasswordSendOTPApi({required dynamic params, bool showLoading = true}) async {
    try {
      var response = await apiManager.postFormAPICall(
        url: '/PageController/forgot_password_send_otp',
        params: params,
        showLoading: showLoading,
      );
      SendOtpModel sendOtpModel = SendOtpModel.fromJson(response);
      return sendOtpModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<StatusMessageCommonModel> verifyOTPApi({required dynamic params, bool showLoading = true}) async {
    try {
      var response = await apiManager.postFormAPICall(
        url: '/verifyOtpauth_user',
        params: params,
        showLoading: showLoading,
      );
      StatusMessageCommonModel statusMessageCommonModel = StatusMessageCommonModel.fromJson(response);
      return statusMessageCommonModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<LoginUserModel> loginApi({required dynamic params, bool showLoading = true}) async {
    try {
      var response = await apiManager.postFormAPICall(
        url: '/send_otpauth_user',
        params: params,
        showLoading: showLoading,
      );

      LoginUserModel loginModel = LoginUserModel.fromJson(response);

      return loginModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<StatusMessageCommonModel> resetPasswordAPi({required dynamic params, bool showLoading = true}) async {
    try {
      var response = await apiManager.postFormAPICall(
        url: '/PageController/reset_password',
        params: params,
        showLoading: showLoading,
      );
      StatusMessageCommonModel statusMessageCommonModel = StatusMessageCommonModel.fromJson(response);
      return statusMessageCommonModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<RegisterUserModel> createPasswordandRegisterAPI({required dynamic params, bool showLoading = true}) async {
    try {
      var response = await apiManager.postFormAPICall(
        url: '/PageController/register',
        params: params,
        showLoading: showLoading,
      );
      RegisterUserModel statusMessageCommonModel = RegisterUserModel.fromJson(response);
      return statusMessageCommonModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<GetCityModel> getCityAPi({
    bool showLoading = false,
  }) async {
    var response = await apiManager.getAPICall(
      url: '/PageController/get_city',
      showLoading: showLoading,
    );
    try {
      GetCityModel getCityModel = GetCityModel.fromJson(response);
      return getCityModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<GetCityModel> postCityAPICall({
    bool showLoading = false,
    required dynamic params,
  }) async {
    var response = await apiManager.postFormAPICall(
      url: '/PageController/add_city',
      params: params,
      showLoading: showLoading,
    );
    try {
      GetCityModel getCityModel = GetCityModel.fromJson(response);
      return getCityModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
